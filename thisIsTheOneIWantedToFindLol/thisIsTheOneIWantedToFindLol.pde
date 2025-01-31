int backTrue = 0;
int size = 1;
int spread = 5;
float counter = 0;
float scale = 5; 
float range;
float n;
float scroll = 1;
float colVal;
float changeVar = 0;
float lerpInc = 0.00;
float rangeUp = 0;
float soundVal = 0;
float startSize = 0;
float scrollUpVal;
float scrollSideVal;
color c0 = #F04248;
color c1 = #FFADBA;
color c2 = #FFFF31;
color c3 = #3A86FF;
color c4 = #269464;
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity;

void setup() {
  colorMode(HSB);
  size(2000, 1000);
  //fullScreen();
  range = width/scale;
  minim = new Minim(this);
  in = minim.getLineIn();
  scrollUpVal = random(-0.03, 0.03);
  scrollSideVal = random(-0.03, 0.03);
}

void draw() {
  changeVar += 0.005;
  rangeUp += scrollUpVal;
  if (backTrue % 2 == 0) background(0);
  sensitivity = 5800;
  scale = 4;
  scroll += scrollSideVal;
  //if (scale < 3) scale = 3;
  range = width/scale/2;
  counter += 0.010;
  scale(scale);
  size = 1;
  lerpInc += 0.022;
  if (lerpInc > 1)lerpInc = 0;
  for (float i =- range; i < range; i++) {
    for (float j =- range; j < range; j++) {
      float n = noise(i/range-rangeUp, j/range+scroll, mag(j, i)/range-counter);
      n = int(abs(n-0.5)*100);
      //colVal = n*changeVar%spread;
      colVal = n*changeVar%5;
      lerpInc = n*changeVar%1;
      if (colVal > 0 && colVal < 1) fill(lerpColor(c0, c1, lerpInc));
      if (colVal > 1 && colVal < 2) fill(lerpColor(c1, c2, lerpInc));
      if (colVal > 2 && colVal < 3) fill(lerpColor(c2, c3, lerpInc));
      if (colVal > 3 && colVal < 4) fill(lerpColor(c3, c4, lerpInc));
      if (colVal > 4) fill(lerpColor(c4, c0, lerpInc));
      noStroke();
      //if (n % 3 == 0) rect(j + range, i + range, size, size + in.left.get(abs(round(j*i)%1024))*sensitivity);
      soundVal = in.left.get(abs(round(j*i)%1024))*sensitivity;
      startSize = 2.0;
      if (n % 3 == 0) rect(j*2.0 + range, i*2.0, startSize+soundVal, startSize+soundVal);
    }
  }
}

void keyPressed() {
  if (key == ' ') backTrue++;
  if (key == 'b') generateNewPallet();
}

void generateNewPallet() {
  scrollUpVal = random(-0.03, 0.03);
  scrollSideVal = random(-0.03, 0.03);
  c0 = color(random(0, 255), random(0, 255), 255);
  c1 = color(random(0, 255), random(0, 255), 255);
  c2 = color(random(0, 255), random(0, 255), 255);
  c3 = color(random(0, 255), random(0, 255), 255);
  c4 = color(random(0, 255), random(0, 255), 255);
}
