import ddf.minim.*;
Minim minim;
AudioInput in;
int xPos;
int sensitivity;
int waveThickness = 10;
float space = 20;
int wholeSize = 800;

void setup() {
  size(800, 800);
  //fullScreen();
  minim = new Minim(this);
  in = minim.getLineIn();
  colorMode(HSB);
}

void draw() {
  background(0); 
  stroke(255);
  xPos = 10;
  space = -33.2;
  strokeCap(4);
  strokeWeight(4.4);
  sensitivity = 509;
  waveThickness = 10;
  wholeSize = width - xPos;
  if (wholeSize > 800) wholeSize = 800;
  for (int j = 0; j < 12; j++) {
    for (int i = xPos; i < wholeSize; i++) {
      stroke(i*1.8 % 252, 255, 255);
      line(i, xPos - (j*space) + in.left.get(i)*sensitivity, i+1, xPos - (j*space) + in.left.get(i+waveThickness)*sensitivity);
      line(xPos - (j*space) + in.left.get(i)*sensitivity, i, xPos - (j*space) + in.left.get(i+waveThickness)*sensitivity, i+1);
      line(i, height - xPos + (j*space) + in.left.get(i)*sensitivity, i+1, height - xPos + (j*space) + in.left.get(i+waveThickness)*sensitivity);
      line(width-xPos + (j*space) + in.left.get(i)*sensitivity, i, width - xPos + (j*space) + in.left.get(i+waveThickness)*sensitivity, i+1);
    }
  }
}
