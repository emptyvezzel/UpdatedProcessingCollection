import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity;
float detail = 30;
float maxSize = 100;
float f = 0;

void setup(){
  minim = new Minim(this);
  in = minim.getLineIn();
  size(400, 400, P3D);
  noFill();
  strokeWeight(1);
}

void draw(){
  background(0);
  stroke(255);
  detail = 30;
  maxSize = 100;
  translate(width/2, height/2);
  rotateX(PI/5.0f);
  rotateY(PI/5.0f);
  sensitivity = 50;
  for (float i = f; i < 6.28+f; i+= TWO_PI / detail) {
    pushMatrix();
    translate(0, 0, cos(i) * 50.0f);
    stroke(max(20 + cos(i) * 150,0));
    ellipse(in.left.get(round(i * 40 % 1024)) * sensitivity,
    in.left.get(round(i * 40 % 1024)) * sensitivity, 
    maxSize*2.0f + sin(i) * maxSize, maxSize*2.0f + sin(i) * maxSize);
    popMatrix();
  }
  f+= 0.01f;
}
