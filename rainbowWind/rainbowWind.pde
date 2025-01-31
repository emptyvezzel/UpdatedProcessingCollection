float alpha = 0;
float step = 0;
float size = 2;
float draw = 180.0;
int space = 25;
int edge = 50;
int place = 1;
int yAdj = 100;
int drop = 180;
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity;

void setup() {
  size(2000, 1000);
  //fullScreen();
  noStroke();
  colorMode(HSB);
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  size = 16;
  space = 40;
  place = 4;
  edge = 0;
  step = 0.011;
  yAdj = 150;
  drop = 200;
  draw = 624;
  alpha += step;
  sensitivity = 200;
  //background(255);
  for (int y = edge; y < height + 400 - edge; y += space) {
    for (int x = -200; x < width - edge; x++) {
      fill(100+((x*0.020)*(y*0.020))%150, 255, 255);
      rect(x+in.left.get(abs(round(x*0.5))%1024)*17*sensitivity, y+place*(drop*noise(alpha+x/draw, alpha+y/draw, alpha)-yAdj), size, size);
    }
  }
}
