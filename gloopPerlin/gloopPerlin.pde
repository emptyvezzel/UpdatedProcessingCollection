float a, b, c, d;
int cols, rows;
float[][] field;
float scaleFactor;
color[] palette;
PVector offset;
color col;

void setup() {
  size(800, 800);
  newPalette();
}

void draw() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      field[i][j] = sin(a * (i + offset.x)) * cos(b * (j + offset.y)) + sin(c * dist(i, j, mouseX * 0.1, mouseY * 0.1)) * cos(d * frameCount * 0.01);
    }
  }
  translate(scaleFactor / 2, scaleFactor / 2);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float v = field[i][j];
      col = lerpColor(palette[floor(abs(v) * palette.length) % palette.length], palette[ceil(abs(v) * palette.length) % palette.length], abs(v));
      pushMatrix();
      translate(i * scaleFactor, j * scaleFactor);
      rotate(v * TWO_PI);
      fill(col);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, scaleFactor * 0.8, scaleFactor * 0.8);
      popMatrix();
    }
  }
  offset.add(PVector.random2D().mult(0.1));
}

void keyPressed(){
  if(key == 'b') newPalette();
}

void newPalette(){
  a = random(0.01, 0.03);
  b = random(0.01, 0.03);
  c = random(0.01, 0.03);
  d = random(0.01, 0.03);
  cols = 100;
  rows = 100;
  field = new float[cols][rows];
  scaleFactor = width / float(cols);
  palette = new color[6];
  offset = new PVector(random(10), random(10));
  for (int i = 0; i < palette.length; i++) {
    palette[i] = color(random(255), random(255), random(255));
  }
}
