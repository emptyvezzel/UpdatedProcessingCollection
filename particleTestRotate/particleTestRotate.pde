int numParticles = 500;
float particleRadius = 3;
float[] x, y, angle, speed, radius, hue;
float centerX, centerY;

void setup() {
  size(800, 800);
  x = new float[numParticles];
  y = new float[numParticles];
  angle = new float[numParticles];
  speed = new float[numParticles];
  radius = new float[numParticles];
  hue = new float[numParticles];
  centerX = width / 2;
  centerY = height / 2;
  colorMode(HSB, 360, 100, 100);
  noStroke();
  for (int i = 0; i < numParticles; i++) {
    x[i] = random(width);
    y[i] = random(height);
    angle[i] = random(TWO_PI);
    speed[i] = random(0.5, 2);
    radius[i] = random(50, 300);
    hue[i] = random(360);
  }
}

void draw() {
  fill(0, 10);
  rect(0, 0, width, height);
  for (int i = 0; i < numParticles; i++) {
    x[i] = centerX + cos(angle[i]) * radius[i];
    y[i] = centerY + sin(angle[i]) * radius[i];
    fill(hue[i], 100, 100, 50);
    ellipse(x[i], y[i], particleRadius, particleRadius);
    angle[i] += speed[i] / radius[i];
    hue[i] += 0.5;
    if (hue[i] > 360) hue[i] = 0;
  }
}
