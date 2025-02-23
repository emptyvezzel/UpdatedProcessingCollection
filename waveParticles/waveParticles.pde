int waveCount, detail, timeShift, bgDraw;
float speed, frequency, amplitude, globalTime, chromaShift, yOffset, hueValue, hueOffset;
color[] palette;

void setup() {
  size(800, 800);
  palette = new color[5];
  generatePalette();
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  waveCount = 12;  
  detail = 250;  
  speed = 0.02;
  frequency = 0.1;
  amplitude = 150;
  chromaShift = 50;
}

void draw() {
  globalTime += speed;
  if (bgDraw % 2 == 0) background(0);
  for(int i = -10; i < waveCount + 10; i++) {
    yOffset = map(i, -10, waveCount + 10, -height * 0.2, height * 1.2); // Ensure full coverage
    hueOffset = (globalTime * 5 + i * 15) % 360; // Scale hue correctly
    color waveColor = palette[abs(i) % palette.length];
    for(int x = 0; x < width; x++) {
      float nx = x * frequency;
      float t = globalTime + i * 0.05 + noise(x * 0.005, i * 0.02, timeShift * 0.001) * 2;
      float y = yOffset + sin(nx + t) * amplitude * noise(nx, t * 0.1) * 1.5;   
      hueValue = (hueOffset + sin(nx + t) * 50) % 360;
      fill(lerpColor(waveColor, color(hueValue, 100, 100), 0.5));
      ellipse(x, y, 4, 4);
    }
  }
  timeShift++;
  if (frameCount % 300 == 0) generatePalette();
}

void keyPressed() {
  if (key == 'c') generatePalette();
  if (key == 's') speed *= -1; 
  if (key == 'w') waveCount = int(random(1, 20));
  if (key == 'f') frequency = random(0.001, 0.3);
  if (key == 'a') amplitude = random(30, 200);
  if (key == ' ') bgDraw++;
}

void generatePalette() {
  for(int i = 0; i < 5; i++) {
    palette[i] = color(random(360), random(50, 100), random(50, 100));
  }
}
