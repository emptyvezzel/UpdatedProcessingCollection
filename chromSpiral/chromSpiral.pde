float bounceVar = 5;
float armVar = 40;
int bounceDir = 1;
int armDir = 1;
//minim vars
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity;

void setup() {
  //size(800, 800, P3D);
  fullScreen(P3D);
  colorMode(HSB);
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  //background(0);
  sensitivity = 1000;
  translate(width/2, height/2);
  rotateX(HALF_PI);
  rotateY(frameCount * 0.01);
  bounceVar -= 0.001*bounceDir;
  armVar -= 0.05*armDir;
  if(bounceVar > 5 || bounceVar < -5) bounceDir*=-1;
  if(armVar < 8 || armVar > 50) armDir*=-1;
  for (float v = 0; v < TWO_PI; v += (TWO_PI / 20)) {
    pushMatrix();
    beginShape(QUAD_STRIP);
    for (float y = -height; y < height; y += (height / armVar)) {
      float r = map(y, -height, height, 0, 400);
      float theta = v + map(y, -height, height, 0, TWO_PI);
      float t = TWO_PI / 30.0;
      float x1 = cos(theta - t) * r * bounceVar;
      float z1 = sin(theta - t) * r * bounceVar;
      float x2 = cos(theta + t) * r * bounceVar;
      float z2 = sin(theta + t) * r * bounceVar;
      noStroke();
      fill(getColor(theta - t, (y / 100.0) + (frameCount / 50.0)));
      vertex(x1, y+in.left.get(round(abs(y))%1024)*sensitivity, z1);
      fill(getColor(theta + t, (y / 100.0) - (frameCount / 50.0)));
      vertex(x2, y+in.left.get(round(abs(y))%1024)*sensitivity, z2);
    }
    endShape();
    popMatrix();
  }
}

color getColor(float angle, float time) {
  float[] c1 = {1, 0, 0}; float f1 = 6.0; float p1 = 150;
  float[] c2 = {0, 1, 0}; float f2 = 6.0; float p2 = 180;
  float[] c3 = {0, 0, 1}; float f3 = 6.0; float p3 = 210;
  float s1 = map(cos(angle * f1 + time + p1), -1, 1, 0, 1);
  float s2 = map(cos(angle * f2 + time + p2), -1, 1, 0, 1);
  float s3 = map(cos(angle * f3 + time + p3), -1, 1, 0, 1);
  float r = s1 * c1[0] + s2 * c2[0] + s3 * c3[0];
  float g = s1 * c1[1] + s2 * c2[1] + s3 * c3[1];
  float b = s1 * c1[2] + s2 * c2[2] + s3 * c3[2];
  return color(r * 255, g * 255, b * 255);
}
