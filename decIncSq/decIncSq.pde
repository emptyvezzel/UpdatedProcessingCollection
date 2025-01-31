float weight = 5.0;
float space = 2.5;
float amt = 10;
int diff = 1;

void setup() {
  size(800, 800);
  colorMode(HSB);
  rectMode(CENTER);
}

void draw() {
  weight = 2.1;
  space = 5.16;
  amt = 229;
  diff = 22;
  background(0);
  noFill();
  translate(width/2, height/2);
  for (int i = 0; i < amt; i++) {
    if (i % 2 == 0) {
      strokeWeight(weight);
      stroke(255-i*(255/amt), 255, 255);
      rect(0, 0, width-space*i, height-space*i);
    } else {
      strokeWeight(weight);
      stroke(255-i*(255/amt), 255, 255);
      rect(0, 0,space*i+diff, space*i+diff);
    }
  }
}
