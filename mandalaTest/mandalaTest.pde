int bgDraw, paletteMode;
int numLayers = 6;
int shapesPerLayer = 12;
float maxRadius, angleOffset, time;
int spikeDir = 1;
float shapeSpike = 1.0;
float spikeSpeed = 0.01;
float radius = 10;
float offSet = 100;
float colVal;
int val = 9;
color[] palette;
float[] colorOffsets;
float[] soundBuffer;

// Minim
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity = 50;

void setup() {
  size(1800, 1000);
  maxRadius = width * 0.4;
  angleOffset = PI / 180;
  generateColors();
  soundBuffer = new float[shapesPerLayer];
  colorMode(HSB);
  strokeWeight(2);
  
  // Minim setup
  minim = new Minim(this);
  in = minim.getLineIn();  
}

void draw() {
  strokeWeight(2);
  if (bgDraw % 2 == 0) background(0);
  translate(width / 2, height / 2);
  numLayers = 50;
  shapesPerLayer = 17;
  maxRadius = width * 1.0;
  angleOffset += 0.000001;
  offSet += 0.1;
  radius = 18;
  spikeSpeed = 0.03;
  colVal += 1;
  sensitivity = 500;
  shapeSpike += spikeSpeed*spikeDir;
  if(shapeSpike > 1.5 || shapeSpike < -0.5) spikeDir *= -1;
  updateSoundBuffer();
  for (int layer = 0; layer < numLayers; layer++) {
    float layerRadius = map(layer, 0, numLayers - 1, 0, maxRadius);
    float speedFactor = sin(time * 0.004 + layer * 0.2) * 0.01;
    float baseRotation = time * 0.01 + layer * angleOffset * 10;
    if(paletteMode % 2 == 0) stroke(colGen(layer));
    for (int i = 0; i < shapesPerLayer; i++) {
      if(paletteMode % 2 == 1) stroke(colGen(i));
      float angle = TWO_PI / shapesPerLayer * i + baseRotation;
      float x = layerRadius * cos(angle);
      float y = layerRadius * sin(angle);
      pushMatrix();
      translate(x, y);
      rotate(angle + time * speedFactor);
      drawShape(layer * 1 + 1, soundBuffer[i%12]);
      popMatrix();
    }
  }
  time += 0.30;
  val = 9;
}

color colGen(int shape){
  float t = (frameCount * 0.001 + colorOffsets[shape%6]);
  return lerpColor(palette[floor(t * 9) % 9], 
  palette[(floor(t * 9) + 1) % 9], t * 9 % 1);
}

void updateSoundBuffer() {
  float smoothingFactor = 0.010;
  for (int i = 0; i < shapesPerLayer; i++) {
    float rawSoundValue = in.left.get(i % 1024) * sensitivity;
    soundBuffer[i%12] = lerp(soundBuffer[i%12], rawSoundValue, smoothingFactor);
    if (rawSoundValue < 0.1) {
      soundBuffer[i%12] *= 0.95;
    }
  }
}

void drawShape(int numPoints, float soundVar) {
  beginShape();
  noFill();
  for (int i = 0; i < numPoints * 2; i++) {
    float angle = PI / numPoints * i;
    float r = (i % 2 == 0) ? radius : radius * shapeSpike + soundVar;
    float x = r * cos(angle)-val;
    float y = r * sin(angle)-val;
    vertex(x, y);
  }
  endShape(CLOSE);
}

void keyPressed(){
  if (key == ' ') bgDraw++;
  if (key == 'c') generateColors();
  if (key == 'b') paletteMode++;
}

void generateColors(){
  palette = new color[9];
  colorOffsets = new float[numLayers];
  for (int i = 0; i < numLayers; i++) {
    colorOffsets[i] = random(1);
  }
  for (int i = 0; i < 9; i++) {
    palette[i] = color(random(255), random(255), random(167, 255));
  }
}
