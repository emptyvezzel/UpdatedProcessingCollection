float radius = 10;
float numPoints = 100;
int circs = 3;
float rotVal = 0.00;
float limit = 0.01;
float speed = 0.000;
int rotDirection = 1;
int sizeDirection = 1;
float sizeLowLimit = 10;
float sizeHighLimit = 100;
float scale = 1;
color c0 = #F04248;
color c1 = #FFADBA;
color c2 = #FFFF31;
color c3 = #3A86FF;
color c4 = #269464;
float colVal;
float changeVar = 0;
float lerpInc = 0;

void setup() {
  //size(1000, 1000);
  fullScreen();
  //colorMode(HSB);
  background(255);
}

void draw() {
  //background(255);
  translate(width/2, height/2);
  //radius = 22;
  numPoints = 116;
  noFill();
  //stroke(0);
  strokeWeight(3.6);
  limit = 0.10;
  scale = 961;
  speed = 0.001;
  circs = 15;
  changeVar += 0.01;
  colVal = changeVar%5;
  lerpInc = changeVar%1;
  if (colVal > 0 && colVal <= 1) stroke(lerpColor(c0, c1, lerpInc));
  if (colVal > 1 && colVal <= 2) stroke(lerpColor(c1, c2, lerpInc));
  if (colVal > 2 && colVal <= 3) stroke(lerpColor(c2, c3, lerpInc));
  if (colVal > 3 && colVal <= 4) stroke(lerpColor(c3, c4, lerpInc));
  if (colVal > 4) stroke(lerpColor(c4, c0, lerpInc));
  for (int j = 0; j < circs; j++) {
    for (int i = 0; i < numPoints; i++) {
      //stroke(abs(2000*rotVal)%255, 255, 255);
      if (j == 0) {
        line(radius*sin((TWO_PI/numPoints)*i+rotVal), radius*cos((TWO_PI/numPoints)*i+rotVal), 0, 0);
      } else if (j % 2 == 1) {
        line(j*radius*sin((TWO_PI/numPoints)*i+rotVal), j*radius*cos((TWO_PI/numPoints)*i+rotVal), 
          (j+1)*radius*sin((TWO_PI/numPoints)*i-rotVal), (j+1)*radius*cos((TWO_PI/numPoints)*i-rotVal));
      } else {
        line((j+1)*radius*sin((TWO_PI/numPoints)*i+rotVal), (j+1)*radius*cos((TWO_PI/numPoints)*i+rotVal), 
          j*radius*sin((TWO_PI/numPoints)*i-rotVal), j*radius*cos((TWO_PI/numPoints)*i-rotVal));
      }
    }
  }
  if (rotVal < -limit || rotVal > limit) rotDirection *= -1;
  rotVal += speed*rotDirection;
  sizeLowLimit = 2;
  sizeHighLimit = 100;
  if (radius < sizeLowLimit || radius > sizeHighLimit) {
    sizeDirection *= -1;
    generateNewPallet();
  }
  radius += 0.1*sizeDirection;
  println(radius);
}

void keyPressed() {
  if (key == ' ') generateNewPallet();
}

void generateNewPallet() {
  c0 = color(random(0, 255), random(0, 255), random(0, 255));
  c1 = color(random(0, 255), random(0, 255), random(0, 255));
  c2 = color(random(0, 255), random(0, 255), random(0, 255));
  c3 = color(random(0, 255), random(0, 255), random(0, 255));
  c4 = color(random(0, 255), random(0, 255), random(0, 255));
  //c0 = color(random(0, 255), 255, 255);
  //c1 = color(random(0, 255), 255, 255);
  //c2 = color(random(0, 255), 255, 255);
  //c3 = color(random(0, 255), 255, 255);
  //c4 = color(random(0, 255), 255, 255);
}
