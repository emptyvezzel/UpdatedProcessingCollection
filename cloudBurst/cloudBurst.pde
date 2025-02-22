int cloudLayers, cloudDetail, bgDraw;
float timeShift, windSpeed, cloudDrift, layerOffset, layerAlpha, noiseVal, cloudSize, xOffset;
color[][] palettes;
color[] currentPalette;
color layerColor;

void setup() {
  size(800, 800);
  cloudLayers = 5;
  cloudDetail = 80;
  timeShift = 0;
  windSpeed = 0.001;
  cloudDrift = random(1000);
  noStroke();
  palettes = new color[][] {
    { color(252, 181, 159), color(255, 207, 160), color(255, 238, 173), color(204, 227, 248), color(255, 255, 255) },
    { color(30, 30, 40), color(60, 70, 80), color(90, 100, 110), color(120, 130, 140), color(200, 210, 220) },
    { color(245, 222, 179), color(240, 128, 128), color(173, 216, 230), color(135, 206, 250), color(255, 250, 250) },
    { color(100, 50, 200), color(150, 100, 255), color(200, 150, 255), color(240, 200, 255), color(255, 255, 255) }
  };
  
  selectPalette();
}

void draw() {
  if (bgDraw % 2 == 0) background(currentPalette[4]);
  timeShift += windSpeed;
  
  for (int i = 0; i < cloudLayers + 2; i++) {
    layerOffset = map(i, 0, cloudLayers, 50, height - 50);
    layerAlpha = map(i, 0, cloudLayers, 100, 250);
    layerColor = currentPalette[i % currentPalette.length];

    for (int x = 0; x < width + 300; x += cloudDetail) {
      for (int y = 0; y < height; y += cloudDetail) {
        noiseVal = noise(x * 0.002, y * 0.002 + timeShift, cloudDrift) * 1.5;
        cloudSize = noiseVal * 140;
        xOffset = sin(timeShift + x * 0.002) * 30;
        
        fill(layerColor, layerAlpha * noiseVal);
        drawCloud(x + xOffset, y + layerOffset, cloudSize);
      }
    }
  }
}

void drawCloud(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  beginShape();
  for (float a = 0; a < TWO_PI; a += PI / 8) {
    float r = size * 0.5 + noise(cos(a) * 0.2, sin(a) * 0.2, timeShift * 0.1) * size * 0.4;
    float cx = cos(a) * r;
    float cy = sin(a) * r;
    vertex(cx, cy);
  }
  endShape(CLOSE);
  popMatrix();
}

void keyPressed() {
  if (key == 'p') selectPalette(); 
  if (key == 'w') windSpeed = random(0.0005, 0.03);
  if (key == 'd') cloudDetail = int(random(60, 120));
  if (key == ' ') bgDraw++;
}

void selectPalette() {
  currentPalette = palettes[int(random(palettes.length))];
}
