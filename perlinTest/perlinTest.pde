int cols, rows, bgDraw, particleSize;
float angle;
float[][] field;
PVector[] particles;
int numParticles = 1000;
float noiseScale = 0.01;
float diffusionRate = 0.05;
color[] palette;
float[] colorOffsets;
int flowDir = 1;

// Minim
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity = 50;

void setup(){
  //fullScreen();
  size(1000, 1000);
  generateParticles();
  generateColors();
  colorMode(HSB);
  
  // Minim setup
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw(){
  sensitivity = 50;
  noiseScale = 0.01;
  diffusionRate = 1.00;
  particleSize = 10;
  if (bgDraw % 2 == 0) background(0);
  if(flowDir > 4) flowDir = 1;
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if(flowDir == 1){
        field[i][j] = noise(i * noiseScale, j * noiseScale, 
        frameCount * noiseScale); //leftv
      } else if(flowDir == 2) {
        field[i][j] = noise(j * noiseScale, -i * noiseScale, 
        frameCount * noiseScale); //up
      } else if(flowDir == 3) {
        field[i][j] = noise(-i * noiseScale, -j * noiseScale, 
        frameCount * -noiseScale); //right
      } else {
        field[i][j] = field[i][j] = noise(-i * noiseScale, -j * noiseScale, 
        frameCount * noiseScale); //down
      }
    }
  }
  
  for (int i = 0; i < numParticles; i++) {
    PVector p = particles[i];
    int x = int(p.x);
    int y = int(p.y);
    if(flowDir == 1) {
      angle = field[x % cols][y % rows] * TWO_PI;  //left
    } else if(flowDir == 2) {
      angle = field[x % cols][y % rows] * TWO_PI + HALF_PI;  //up
    } else if(flowDir == 3) {
      angle = field[x % cols][y % rows] * TWO_PI + PI;  //right
    } else {
      angle = field[x % cols][y % rows] * TWO_PI + PI + HALF_PI;  //down
    }
    PVector dir = PVector.fromAngle(angle);
    dir.mult(diffusionRate);
    p.add(dir);
    p.x = (p.x + width) % width;
    p.y = (p.y + height) % height;
    float t = (frameCount * 0.001 + colorOffsets[i]) % 1;
    color c = lerpColor(palette[floor(t * 5) % 5], 
    palette[(floor(t * 5) + 1) % 5], t * 5 % 1);
    fill(c);
    noStroke();
    if (i % 2 == 0) {
      ellipse(p.x, p.y, particleSize + in.left.get(x%1024) * sensitivity, 
      particleSize);
    } else {
      ellipse(p.x, p.y, particleSize, 
      particleSize + in.left.get(x%1024) * sensitivity);
    }
  }
  println(frameRate);
}

void generateParticles(){
  numParticles = 1000;
  cols = width;
  rows = height;
  field = new float[cols][rows];
  particles = new PVector[numParticles];
  for (int i = 0; i < numParticles; i++) {
    particles[i] = new PVector(random(width), random(height));
  }
}

void generateColors(){
  palette = new color[5];
  colorOffsets = new float[numParticles];
  for (int i = 0; i < numParticles; i++) {
    colorOffsets[i] = random(1);
  }
  for (int i = 0; i < 5; i++) {
    palette[i] = color(random(255), random(255), random(167, 255));
  }
}

void keyPressed(){
  if (key == ' ') bgDraw++;
  if (key == 'b') generateParticles();
  if (key == 'c') generateColors();
  if (key == 'v') flowDir++;
  if (key == 'f'){
    generateParticles();
    generateColors();
    flowDir++;
  }
}
