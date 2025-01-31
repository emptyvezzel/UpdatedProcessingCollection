import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity = 50;
int numRects = 1;
float colVal;
float changeVar = 0;
float lerpInc = 0.00;
float radius = 150;
float rectWidth = 20;
float rectHeight = 60; 
float rotWhole = 0.0;
int upperBound = 1200;
int lowerBound = 1;
float addSpeed = 1;
int boundDir = 1;
int backTrue = 0;
float colToggle = 0;
color c0 = #F04248;
color c1 = #FFADBA;
color c2 = #FFFF31;
color c3 = #3A86FF;
color c4 = #269464;
color lineStroke;

void setup() {
  size(600, 600);
  rectMode(CENTER);  
  background(0);
  colorMode(HSB);
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  translate(width / 2, height / 2); 
  rotate(rotWhole);
  rotWhole += 0.0098;
  addSpeed += 1*boundDir;
  numRects = round(addSpeed);
  radius = 150;
  rectWidth = 2;
  rectHeight = 2;
  sensitivity = 400;
  if(backTrue % 2 == 0) background(0);
  
  //changeVar += 0.005;
  //colVal = changeVar%5;
  lerpInc += 0.0022;
  noStroke();
  strokeWeight(0.1);
  for (int i = 0; i < numRects; i++) {
    float angle = TWO_PI / numRects * i;
    float x = cos(angle) * radius;
    float y = sin(angle) * radius;
    if (lerpInc > 1) {
      lerpInc = 0;
      colToggle++;
    }
    if (colToggle > 4) colToggle = 0;
    if (colToggle == 0) lineStroke = lerpColor(c0, c1, lerpInc);
    if (colToggle == 1) lineStroke = lerpColor(c1, c2, lerpInc);
    if (colToggle == 2) lineStroke = lerpColor(c2, c3, lerpInc);
    if (colToggle == 3) lineStroke = lerpColor(c3, c4, lerpInc);
    if (colToggle == 4) lineStroke = lerpColor(c4, c0, lerpInc);
    fill(lineStroke);
    pushMatrix();
    translate(x, y);
    rotate(TWO_PI*i/numRects);
    rect(0, 0, rectWidth+in.left.get(i)*sensitivity+1, rectHeight); 
    popMatrix();
  }
  if(addSpeed > upperBound || addSpeed < lowerBound) boundDir *= -1;
  upperBound = 100;
  //lowerBound = 0;
}

void keyPressed(){
  if(key == ' ') backTrue++;
  if (key == 'b') generateNewPallet();
}

void generateNewPallet() {
  c0 = color(random(0, 255), random(0, 255), 255);
  c1 = color(random(0, 255), random(0, 255), 255);
  c2 = color(random(0, 255), random(0, 255), 255);
  c3 = color(random(0, 255), random(0, 255), 255);
  c4 = color(random(0, 255), random(0, 255), 255);
}
