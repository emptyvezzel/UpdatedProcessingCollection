import ddf.minim.*;
Minim minim;
AudioInput in;
int variableInt;
int sensitivity;

void setup() {
  size(500, 500);
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  variableInt = 50;
  sensitivity = 50;
  background(0);
  stroke(255);
  for (int j = 0; j < 500 - variableInt; j+=variableInt) {
    for (int i = 0; i < in.bufferSize() - 1; i++) {
      line(i, variableInt + j + in.left.get(i)*sensitivity, i+1, variableInt + j + in.left.get(i+1)*sensitivity);
      line(variableInt + j + in.left.get(i)*sensitivity, i, variableInt + j + in.left.get(i+1)*sensitivity, i+1);
    }
  }
}
