float t = 0;
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity = 50;
float sinAdd;
float cosAdd;

void setup() {
  //size(800, 800);
  fullScreen();
  noStroke();
  colorMode(HSB);
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  //background(0);
  sensitivity = 1;
  for (int x = 0; x < width; x += 100) {
    for (int y = 0; y < height; y += 10) {
      float r = sin((t + in.left.get(abs(y)%1024)*sensitivity) + x * 0.01) * 127 + 128;
      float g = sin((t + in.left.get(abs(x)%1024)*sensitivity) + y * 0.01) * 127 + 128;
      float b = sin((t + in.left.get(abs(y)%1024)*sensitivity) + x * 0.01 + y * 0.01) * 127 + 128;
      fill(r, g, b);
      ellipse(x + sin((t + in.left.get(abs(x)%1024)*sensitivity) + y * (0.05 + sinAdd)) * 50, 
      y + cos((t + in.left.get(abs(y)%1024)*sensitivity) + x * (0.05 + cosAdd)) * 5, 62, 10);
    }
  }
  t += 0.02;
  sinAdd += 0.0003;
  cosAdd += 0.0001;
}
