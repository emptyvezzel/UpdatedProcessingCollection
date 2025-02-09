int cols = 12;
int rows = 12;
float t, cellSize, cx, cy, phase, offset, angle;

void setup() {
  size(800, 800);
  cellSize = width / cols;
}

void draw() {
  background(0);
  t += 0.01;
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      cx = x * cellSize + cellSize / 2;
      cy = y * cellSize + cellSize / 2;
      phase = (x + y) * 0.2 + t;
      offset = sin(phase) * cellSize * 0.3;
      pushMatrix();
      translate(cx, cy);
      rotate(phase);
      if ((x + y) % 2 == 0) {
        drawHexagon(0, 0, cellSize * 0.3);
      } else {
        ellipse(x, y, cellSize, cellSize);
      }
      
      popMatrix();
    }
  }
}

void drawHexagon(float x, float y, float radius) {
  beginShape();
  for (int i = 0; i < 6; i++) {
    angle = TWO_PI / 6 * i;
    vertex(x + cos(angle) * radius, y + sin(angle) * radius);
  }
  endShape(CLOSE);
}
