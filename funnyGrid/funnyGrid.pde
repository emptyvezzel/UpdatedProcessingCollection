float x, y;

void setup() {
  size(800, 600);
  background(0);
  colorMode(HSB, 360, 100, 100);
  x = 0;
  y = 0;
}

void draw() {
  background(0);
  for (int i = 0; i < width; i += 20) {
    for (int j = 0; j < height; j += 20) {
      fill(map(sin(x + i + j), -1, 1, 0, 360), 100, 100);
      rect(i + sin(x + i) * 10, j + cos(y + j) * 10, 20, 20);
    }
  }
  x += 0.05;
  y += 0.05;
}
