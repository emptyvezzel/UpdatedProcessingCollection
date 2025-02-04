int cols, rows;
float spacing = 20;
float time = 0;
float speed = 0.02;
color[] colors;
float x, y, d, offset;

void setup() {
  size(600, 600);
  cols = (width / int(spacing)) + 1;
  rows = (height / int(spacing)) + 1;
  colors = new color[]{#FF0000, #00FF00, #0000FF, #FFFF00, #FF00FF, #00FFFF};
  noFill();
  rectMode(CENTER);
  background(0);
}

void draw() {
  speed = 0.2;
  background(0);
  strokeWeight(1.0);
  translate(width / 2, height / 2);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      x = (i - cols / 2) * spacing;
      y = (j - rows / 2) * spacing;
      d = dist(x, y, 0, 0) * 0.05;
      offset = sin(time + d) * spacing * 0.5;
      stroke(255);
      stroke(colors[(i + j) % colors.length]);
      rect(x, y, spacing + offset, spacing + offset);
    }
  }
  time += speed;
}
