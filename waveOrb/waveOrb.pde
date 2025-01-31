import ddf.minim.*;
Minim minim;
AudioInput in;
float speed = 0.2;
float radius;
float divisor = 13;
float divisorChange;
int sensitivity;
int incDivisor = 1;

void setup() {
  fullScreen();
  smooth();
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  speed += 0.20;
  sensitivity = 400;
  divisorChange = 0.010;
  divisor -= divisorChange*incDivisor;
  if(divisor == 0) divisor = 1;
  background(0);
  stroke(255);
  translate(width/2, height/2);
  noFill();
  radius = height/2-20;
  for (float i =- 0.5*PI; i<PI+0.5*PI; i += abs(0.01)*PI) {
    beginShape();
    for (float j =- sin(i)*radius; j < sin(i)*radius+sin(i); j += sin(i)*20) {
      float divisorResult = j/divisor;
      //if(divisorResult > 1) divisorResult = 1;
      curveVertex(j, cos(i)*radius+sin(speed-(divisorResult))*abs(i*4+abs(in.left.get(Math.round(i))*sensitivity)));
    }
    endShape();
  }
  if(divisor < 0.0) incDivisor = -1;
  if(divisor > 13.0) incDivisor = 1;
}
