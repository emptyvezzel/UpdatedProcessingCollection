import ddf.minim.*;
Minim minim;
AudioInput in;
int xPos;
int sensitivity;

void setup() {
  size(800, 800);  
  minim = new Minim(this);
  in = minim.getLineIn();
  blendMode(ADD);
}

void draw() {
  background(0); 
  stroke(255);
  xPos = height/2;
  sensitivity = 485;
  strokeWeight(30);
  for (int i = 0; i < in.bufferSize() - 1; i++) {
    stroke(255, 0, 0);
    line(i, xPos + in.left.get(i)*sensitivity, i+1, xPos + in.left.get(i+1)*sensitivity);
    stroke(0, 0, 255);
    line(i, xPos + in.left.get((i+width)%in.bufferSize())*sensitivity, i+1, xPos + in.left.get((i+width)%in.bufferSize())*sensitivity);
    stroke(0, 255, 0);
    line(i, xPos + in.left.get((i+width*2)%in.bufferSize())*sensitivity, i+1, xPos + in.left.get((i+width*2)%in.bufferSize())*sensitivity);
  }
}
