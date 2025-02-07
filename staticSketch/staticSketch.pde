import ddf.minim.*;
Minim minim;
AudioInput in;

int sensitivity = 50;
int numPoints = 12;
float[] angles, radii, targetRadii;
float shapeX, shapeY, t, soundVar;
PGraphics noiseTexture;

void setup(){
  size(800, 800, P2D);
  minim = new Minim(this);
  in = minim.getLineIn();
  angles = new float[numPoints];
  radii = new float[numPoints];
  targetRadii = new float[numPoints];
  noiseTexture = createGraphics(width, height);
  for(int i=0; i<numPoints; i++){
    angles[i] = TWO_PI * i / numPoints;
    radii[i] = targetRadii[i] = random(50, 150);
  }
}

void draw(){
  background(0);
  t += 0.005;
  sensitivity = 20;
  shapeX = width/2 + cos(t) * 100;
  shapeY = height/2 + sin(t * 0.7) * 100;
  for(int i=0; i<numPoints; i++){
    targetRadii[i] += random(-5, 5);
    targetRadii[i] = constrain(targetRadii[i], 50, 150);
    radii[i] = lerp(radii[i], targetRadii[i], 0.05);
  }
  generateNoise();
  drawShape();
}

void generateNoise(){
  noiseTexture.beginDraw();
  noiseTexture.loadPixels();
  for(int i = 0; i<width*height; i++){
    noiseTexture.pixels[i] = color(random(255));
  }
  noiseTexture.updatePixels();
  noiseTexture.endDraw();
}

void drawShape(){
  maskShape(noiseTexture);
}

void maskShape(PGraphics src){
  PGraphics mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.beginShape();
  for(int i=0; i<numPoints; i++){
    soundVar = in.left.get(i) * sensitivity;
    float x = shapeX + cos(angles[i]) * (radii[i] + soundVar);
    float y = shapeY + sin(angles[i]) * (radii[i] + soundVar);
    mask.vertex(x, y);
  }
  mask.endShape(CLOSE);
  mask.endDraw();
  src.mask(mask);
  image(src, 0, 0);
}
