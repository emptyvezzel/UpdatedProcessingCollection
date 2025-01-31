import ddf.minim.*;
Minim minim;
AudioInput in;
float lineSize;
double randVar;
double colRand;
int colRand0;
int[][] beans;
int x;
int y;

void setup() {
  size(800, 800);
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  strokeWeight(abs(lineSize * 0.50  + in.left.get(1)*100));
  lineSize = abs(42.3);
  translate(-lineSize, -lineSize);
  if (frameCount % 5 == 0) generateLines();
}

void generateLines() {
  x = Math.round(width/lineSize);
  y = Math.round(height/lineSize);
  beans = new int[x+2][y+2];
  strokeCap(PROJECT);
  background(0);
  for (int i = 0; i < width/lineSize+1; i++) {
    for (int j = 0; j < height/lineSize+1; j++) {
      colRand0 = (int) random(0, 255);
      colRand = Math.random();
      randVar = Math.random();
      if (colRand > 0) stroke(0, 184, 146);
      if (colRand > 0.25) stroke(21, 140, 240);
      if (colRand > 0.5) stroke(253, 136, 118);
      if (colRand > 0.75) stroke(253, 250, 133);
      if (j == 0 || i == 0) {
        if (randVar > 0.5) {
          line(lineSize*i, lineSize*j, lineSize+lineSize*i, lineSize+lineSize*j);
          beans[i][j] = 0;
        } else {
          line(lineSize*i, lineSize+lineSize*j, lineSize+lineSize*i, lineSize*j);
          beans[i][j] = 1;
        }
      } else {
        if (beans[i][j] == 0 && beans[i][j-1] == 0 && beans[i-1][j-1] == 1) {
          line(lineSize*i, lineSize*j, lineSize+lineSize*i, lineSize+lineSize*j);
          beans[i][j] = 0;
        } else {
          if (randVar > 0.5) {
            line(lineSize*i, lineSize*j, lineSize+lineSize*i, lineSize+lineSize*j);
            beans[i][j] = 0;
          } else {
            line(lineSize*i, lineSize+lineSize*j, lineSize+lineSize*i, lineSize*j);
            beans[i][j] = 1;
          }
        }
      }
    }
  }
}
