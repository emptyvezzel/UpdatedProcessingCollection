int n = 250;
float radius = 80; 
float inter = 0.05f; 
float maxNoise = 500;

float kMax;
float step;
float noiseProg(float x) {
  return x * x;
}

void setup() {
  size(1000, 1000);
  //size(displayWidth, displayHeight);
  colorMode(HSB, 1);
  noFill();
  kMax = random(0.5, 1);
  step = 0.01;
}

void draw() {
  background(0.1);

  for (int i = 0; i < n; i++) {
    float alpha = 1 - noiseProg((float) i / n);
    stroke(0.9, alpha);
    float size = radius + i * inter;
    float k = kMax * sqrt((float) i / n);
    float noisiness = maxNoise * noiseProg((float) i / n);
    blob(size, width / 2, height / 2, k, i * step, noisiness);
  }
}

void blob(float size, float xCenter, float yCenter, float k, float t, float noisiness) {
  beginShape();
  float angleStep = 360.0f / 500;
  for (float theta = 0; theta < 360; theta += angleStep) {
    float r1 = cos(radians(theta)) + 1;
    float r2 = sin(radians(theta)) + 1;
    float r = size + noise(k * r1, k * r2, t) * noisiness;
    float x = xCenter + r * cos(radians(theta));
    float y = yCenter + r * sin(radians(theta));
    curveVertex(x, y);
  }
  endShape(CLOSE);
}
