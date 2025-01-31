float rotVal;
float angle;
float colMod;
int sqrs;
int bgrToggle = 0;
int shapeToggle = 0;
int colorToggle = 1;
int transToggle = 0;
float transNum = 200;
float transSpeed = 1.0;
int transLimit = 500;
boolean transUpToggle = true;

//lerp
int lerpToggle;
float lerpVal = 0;
float lerpInc = 0.01;
color col;
color col0 = #DC3522;
color col1 = #D9CB9E;
color col2 = #374140;
color col3 = #2A2C2B;
color col4 = #1E1E20;

//minim
import ddf.minim.*;
Minim minim;
AudioInput in;
float adj = 50;

void setup(){
  size(800, 800);
  background(0);
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw(){
  smooth();
  if(bgrToggle % 2 == 0) background(0);
  translate(width/2, height/2);
  adj = 50;
  rotate(rotVal);
  transLimit = 500;
  transSpeed = 1.0;
  if(transToggle % 2 == 0) transNum = 200.5;
  else {
    if(transNum > transLimit || transNum < -transLimit){
      transSpeed *= -1;
    }
    transNum += transSpeed;
  }
  for (float i=0; i<360; i += 1.0) { 
    pushMatrix();
      rotate(radians(i*1));
      translate(0, transNum);
      rotate(radians((i+rotVal*100)*3));
      scale(map(sin(radians(i*6)), -1, 1.0, 0.5, 1), map(sin(radians(i*3)), -1, 1, 0.5, 1));
      if(colorToggle % 2 == 0) {
        colorMode(HSB);
        stroke(i*colMod%255, 255, 255);
      } else {
        colorMode(RGB);
        lerpInc = 0.00009;
        lerpVal += lerpInc;
        if (lerpVal > 1) {
          lerpVal = 0;
          lerpToggle++;
        }
        lerpToggle = lerpToggle + round(i);
        if (lerpToggle % 5 == 0) col = lerpColor(col0, col1, lerpVal);
        if (lerpToggle % 5 == 1) col = lerpColor(col1, col2, lerpVal);
        if (lerpToggle % 5 == 2) col = lerpColor(col2, col3, lerpVal);
        if (lerpToggle % 5 == 3) col = lerpColor(col3, col4, lerpVal);
        if (lerpToggle % 5 == 4) col = lerpColor(col4, col0, lerpVal);
        stroke(col);
    }
    if(shapeToggle % 3 == 0) drawRect(in.left.get(round(i)%1024)*adj);
    if(shapeToggle % 3 == 1) drawEllipse(in.left.get(round(i)%1024)*adj);
    if(shapeToggle % 3 == 2) drawStar(in.left.get(round(i)%1024)*adj);
    popMatrix();
  }
  rotVal += 0.005;
  println(transNum);
}

void drawRect(float in) {
  noFill();
  //stroke(255, 255, 255, 128);
  rect(-60, -40+in, 120, 80);
}  

void drawEllipse(float in) {
  noFill();
  //stroke(255, 255, 255, 128);
  ellipse(0, 0+in, 100, 80);
}

void drawStar(float in) {
  float r1 = 40.0;
  float r2 = 120.0;
  float numPoints = 3;
  float dTheta = radians(360)/(numPoints * 2.0);
  for (int i=0; i<numPoints; i++) {
    float x0 = r1 * cos((2*i)*dTheta);
    float y0 = r1 * sin((2*i)*dTheta);
    float x1 = r2 * cos(((2*i)+1) * dTheta);
    float y1 = r2 * sin(((2*i)+1) * dTheta);
    float x2 = r1 * cos(((2*i)+2) * dTheta);
    float y2 = r1 * sin(((2*i)+2) * dTheta);
    noFill();
    //stroke(255, 255, 255, 128);
    line(x0, y0+in, x1, y1);
    line(x1, y1+in, x2, y2);
  }    
}

void keyPressed(){
  if(key == ' ') bgrToggle++;
  if(key == 'f') colorToggle++;
  if(key == 'j') shapeToggle++;
  if(key == 'g') genCols();
  if(key == 't') transToggle++;
  if(key == 'b') {
     genCols();
     shapeToggle++;
  }
}

void genCols(){
  col0 = color(random(0, 255), random(0, 255), random(0, 255));
  col1 = color(random(0, 255), random(0, 255), random(0, 255));
  col2 = color(random(0, 255), random(0, 255), random(0, 255));
  col3 = color(random(0, 255), random(0, 255), random(0, 255));
  col4 = color(random(0, 255), random(0, 255), random(0, 255));
}
