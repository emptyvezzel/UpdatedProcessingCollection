int circSize = 350;
float offset = 0;
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity;

void setup() {
  size(1000, 1000);
  //fullScreen();
  colorMode(HSB);
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  blendMode(BLEND);
  circSize = 800;
  background(255);
  noStroke();
  //fill(0);
  strokeWeight(16.0);
  sensitivity = 402;
  offset -= 2.50;
  for (int h = round(offset); h < height; h += 10 * 6) {
    //for (int i = 0; i < in.bufferSize() - 1; i++) {
    //  line(i, h + in.left.get(i)*sensitivity, i+1, h + in.left.get(i+1)*sensitivity);
    //}
    stroke(h/7%255, 255, 255);
    line(-1, h+in.left.get(abs(h)%1024)*sensitivity, width, h+in.left.get(abs(h)%1024)*sensitivity);
  }
  blendMode(DIFFERENCE);
  fill(255);
  noStroke();
  ellipse(width / 2, height / 2, circSize, circSize);
}
