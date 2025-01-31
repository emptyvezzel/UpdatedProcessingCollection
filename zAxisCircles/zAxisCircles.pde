// made by Jack Murphy / emptyvezzel

import peasy.*;

PeasyCam cam;

float rot = 0;
float col;
int frameRedraw = 0;
int colMode = 0;

void setup(){
  size(1000, 1000, P3D);
  cam = new PeasyCam(this, 500);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(1000);
  smooth();
  colorMode(HSB);
  //noCursor();
}
void draw(){
  if(frameRedraw % 2 == 0)
    background(0);
  if(col >= 255)
    col = 0;
  else
    col++;
  pushMatrix();
  shapeMode(CENTER);
  noFill();
  for(int i = 0; i < 100; i++) {
    rotateY(radians(rot));
    if(colMode % 4 == 0)
      stroke(i*2.5, 255, 255);
    if(colMode % 4 == 1)
      stroke(col, 255, 255);
    if(colMode % 4 == 2)
      stroke(0, 0, 255);
    if(colMode % 4 == 3){
      if(i < 20)
        stroke(12, 78, 100);
      if(i > 19)
        stroke(60, 38, 100);
      if(i > 39)
        stroke(96, 32, 92);
      if(i > 59)
        stroke(139, 36, 74);
      if(i > 79)
        stroke(170, 100, 63);
    }
    ellipse(0, 0, 10+i*10, 10+i*10);
  }
  popMatrix();
  rot += .01;
  if(frameCount % 60 == 0) frameRedraw++;
}
void keyPressed(){ 
  if(key == 'b') frameRedraw++;
  if(key == '`') colMode++;
  if(key == 'v') rot = -5;
}
