float rotVal = 0;
int chooseVal = 0;
float colVal = 0;
float addVal = 0.00015;
import ddf.minim.*;
Minim minim;
AudioInput in;

void setup() {
  size(1000, 1000, P3D);
  colorMode(HSB);
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  rectMode(CENTER);
  background(0);
  translate(-381, -494, -1404);
  pushMatrix();
  noFill();
  rotVal += addVal;
  addVal = 0.0001622;
  translate(width/1, height/1);
  strokeWeight(10.96);
  for (int i = 0; i < 400; i++) {
    if(i % 4 == 0)
      stroke(26, 209, 254);
    if(i % 4 == 1)
      stroke(#80134e);
    if(i % 4 == 2)
      stroke(126, 138, 212);
    if(i % 4 == 3)
      stroke(#2444bd);
    rotateX(rotVal);
    rotateY(rotVal);
    rotateZ(0.37);
    if(chooseVal % 2 == 0)
      rect(0, 0, 0+i*5 + abs(in.left.get(1)*1500), 0+i*5 + abs(in.left.get(1)*1500));
  }
  popMatrix();
}
