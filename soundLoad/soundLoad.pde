float [][] line;
int space;

//minim
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity;

void setup() {
  size(800, 800);
  minim = new Minim(this);
  in = minim.getLineIn();
  line = new float[2000][2000];
}

void draw() {
  background(0);
  space = 13;
  stroke(255);
  sensitivity = 5000;
  for (int j = 0; j < height/space; j++) {
    for (int i = 0; i < 1024; i++) {
      line[i+1][j+1] = in.left.get(i)*sensitivity;
    }
  }
  
  for (int j = 0; j < height/space; j++) {
    for (int i = 0; i < 1024; i++) {
      rect(i, j*space+line[i][j], 1, 1);
    }
  }
}
