import ddf.minim.*;
Minim minim;
AudioInput in;

int numVertices = 40;
int size = 100;
int keep = 100;
int sensitivity = 100;
int fillInc = 1;

void setup() {
  //size(500, 500);
  fullScreen();
  minim = new Minim(this);
  in = minim.getLineIn();
  colorMode(HSB, 360, 100, 100);
  noStroke();
  background(0);
}

void draw(){
  //background(0);
  float x = map(noise(frameCount * 0.01), 0, 1, 0, width);
  float y = map(noise(frameCount * 0.01 + 10000), 0, 1, 0, height);

  numVertices = 1024;
  size = 100;
  keep = 200;
  sensitivity = 100;

  float[] xPos = new float[numVertices];
  float[] yPos = new float[numVertices];

  for (int i = 0; i < numVertices; i++) {
    float angle = map(i, 0, numVertices, 0, TWO_PI);
    xPos[i] = cos(angle) * (size + + in.left.get(i)*sensitivity) + width / 2;
    yPos[i] = sin(angle) * (size + + in.left.get(i)*sensitivity) + height / 2;
  }

  float hue = map(noise(frameCount * 0.005 + 40 * 10000), 0, 1, 0, 360);
  float sat = map(noise(frameCount * 0.005 + 40 * 10000 + 10000), 0, 1, 0, 100);
  float bri = map(noise(frameCount * 0.005 + 40 * 10000 + 20000), 0, 1, 0, 100);

  strokeWeight(2.0);
  if(fillInc % 2 == 0) {
    stroke(hue, sat, bri);
    noFill();
  } else {
    fill(hue, sat, bri);
    noStroke();
  }
  
  translate(map(noise(frameCount * 0.01), 0, 1, -2000+keep, 2000-keep), 
  map(noise(frameCount * 0.01 + 10000), 0, 1, -height+keep, height-keep));
  beginShape();
  for (int i = 0; i < numVertices; i++) {
    vertex(xPos[i], yPos[i]);
  }
  endShape(CLOSE);
}

void keyPressed(){
  if(key == ' ') background(random(0, 360), random(0, 100), random(0, 100));
  if(key == 'b') fillInc++;
}
