PImage img;
int cols, rows;
float scaleFactor = 100;
float timeOffset = 0;
int bgTrue = 0;
color[] palette;

void setup() {
  size(800, 800);
  img = loadImage("Felix_The_Cat.png");
  cols = ceil(width / scaleFactor);
  rows = ceil(height / scaleFactor);
  img.resize(int(scaleFactor), int(scaleFactor));
  noStroke();
  palette = createPalette();
}

void draw() {
  if(bgTrue % 2 == 0) background(0);
  timeOffset += 0.02;
  scaleFactor = 100;
  cols = ceil(width / scaleFactor);
  rows = ceil(height / scaleFactor);
  img.resize(int(scaleFactor), int(scaleFactor));
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      float angle = noise(x * 0.2, y * 0.2, timeOffset) * TWO_PI * 4;
      float scaleMod = map(sin(angle), -1, 1, 0.5, 1.5);
      color col = getColorFromPalette(noise(x * 0.1, y * 0.1, timeOffset));

      pushMatrix();
      translate(x * scaleFactor + scaleFactor / 2, y * scaleFactor + scaleFactor / 2);
      rotate(angle);
      scale(scaleMod);
      tint(col);
      imageMode(CENTER);
      image(img, 0, 0);
      popMatrix();
    }
  }
}

void keyPressed() {
  if(key == ' ') bgTrue++;
  if(key == 'b') palette = createPalette();
}

color[] createPalette() {
  color[] pal = new color[8];
  pal[0] = color(random(0, 255), random(0, 255), random(0, 255));
  pal[1] = color(random(0, 255), random(0, 255), random(0, 255));
  pal[2] = color(random(0, 255), random(0, 255), random(0, 255));
  pal[3] = color(random(0, 255), random(0, 255), random(0, 255));
  pal[4] = color(random(0, 255), random(0, 255), random(0, 255));
  pal[5] = color(random(0, 255), random(0, 255), random(0, 255));
  pal[6] = color(random(0, 255), random(0, 255), random(0, 255));
  pal[7] = color(random(0, 255), random(0, 255), random(0, 255));
  return pal;
}

color getColorFromPalette(float t) {
  t = constrain(t, 0, 1);
  int idx1 = floor(t * (palette.length - 1));
  int idx2 = (idx1 + 1) % palette.length;
  float blend = (t * (palette.length - 1)) % 1.0;
  return lerpColor(palette[idx1], palette[idx2], blend);
}
