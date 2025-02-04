int cols, rows, xOffset;
int scale = 5;
float noiseFactor = 0.05;
float timeOffset, distortion, n = 0;
color c;

void setup() {
  size(600, 600);
  cols = width / scale;
  rows = height / scale;
}

void draw() {
  background(0);
  scale = 5;
  noiseFactor = 0.05;
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      distortion = noise(x * noiseFactor, y * 0.1, timeOffset) * 50;
      xOffset = int(distortion) % cols;
      n = noise(x * 0.1, y * 0.1, timeOffset);
      c = (n > 0.5) ? color(255) : color(0);
      fill(c);
      noStroke();
      rect((x * scale + xOffset) % width, y * scale, scale, scale);
    }
  }
  timeOffset += 0.02;
}
