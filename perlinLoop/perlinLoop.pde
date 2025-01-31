import ddf.minim.*;
Minim minim;
AudioInput in;
float phase = 0;
float zoff = 0;
int amt = 0;
float numVal = 0;
float numSpeed = 1.0;
int numDir = 1;
int param = 3000;

void setup() {
  size(800, 800);
  //fullScreen();
  minim = new Minim(this);
  in = minim.getLineIn();
  smooth();
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(abs(2.00));
  //noFill();
  amt = 75;
  numSpeed = 24;
  param = 7000;
  if(numVal < -param || numVal > param) numDir *= -1;
  numVal += numSpeed * numDir;
  translate(width/2, height/2);
  float noiseMax = map(numVal, 0, width, 1, 2);
  for (int i = 0; i < amt; i++) {
    beginShape();
    for (float a = 0.00; a < TWO_PI; a += radians(abs(5))) {
      fill(0);
      //if (i == amt - 1) fill(250, 250, 217);
      //else noFill();
      float xoff = map(cos(a + phase), -1, 1, 0, noiseMax);
      float yoff = map(sin(a + phase), -1, 1, 0, noiseMax);
      float r = map(noise(xoff, yoff, zoff), 0, 1, 476-i*(6+in.left.get(i)*51), height / 2);
      float x = r * cos(a);
      float y = r * sin(a);
      vertex(x, y);
    }
    endShape(CLOSE);
  }
  phase += 0.010;
  zoff += 0.03;
  println(numVal);
}
