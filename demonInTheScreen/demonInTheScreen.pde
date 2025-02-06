int cols, rows, r, g, b, px, py, reducedCols, reducedRows;
float noiseX, noiseY, sinX, cosY, glitch, value, sinVal, tOffset;
float timeOffset = random(1000);
float speed = 0.03;
int waveCount = 10;
int resolutionFactor = 4;

void setup() {
  //fullScreen();
  size(2000, 1200);
  cols = width;
  rows = height;
}

void draw() {
  background(0);
  noStroke();
  tOffset = timeOffset;
  resolutionFactor = 4;
  waveCount = 4;
  if(resolutionFactor < 4) resolutionFactor = 4;
  reducedCols = cols / resolutionFactor + 1;
  reducedRows = rows / resolutionFactor + 1;
  for (int y = 0; y < reducedRows; y++) {
    noiseY = map(y, 0, reducedRows, 0, waveCount);
    for (int x = 0; x < reducedCols; x++) {
      noiseX = map(x, 0, reducedCols, 0, waveCount);
      sinX = sin(noiseX + tOffset);
      cosY = cos(noiseY + tOffset * 1.2);
      glitch = (noise(x * 0.002, y * 0.002, tOffset * 0.5) * 2 - 1) * 4.0;
      value = (sinX * cosY) + glitch;
      value = map(value, -1, 1, 0, 255);
      sinVal = value * 0.05;
      r = int(abs(sin(sinVal + tOffset * 2)) * 255);
      g = int(abs(sin(sinVal + PI / 3 + tOffset * 1.5)) * 255);
      b = int(abs(sin(sinVal + PI / 2 + tOffset * 1.8)) * 255);
      fill(r, g, b);
      rect(x * resolutionFactor, y * resolutionFactor, resolutionFactor, resolutionFactor);
    }
  }
  println(frameRate);
  timeOffset += speed;
}
