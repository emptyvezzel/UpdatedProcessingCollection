import ddf.minim.*;
Minim minim;
AudioInput in;
int variableInt;
int sensitivity;

void setup() {
  size(1000, 1000);
  //fullScreen();
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  variableInt = 113;
  background(0);
  stroke(255);
  sensitivity = 500;
  for (int j = 0; j < 2500 - variableInt; j+=variableInt) {
    for (int i = 0; i < in.bufferSize()*2 - 1; i+=2) {
      line(i, variableInt + j + in.left.get(i/2)*sensitivity, i+1, variableInt + j + in.left.get((i+1)/2)*sensitivity);
      line(variableInt + j + in.left.get(i/2)*sensitivity, i, variableInt + j + in.left.get((i+1)/2)*sensitivity, i+1);
    }
  }
}
