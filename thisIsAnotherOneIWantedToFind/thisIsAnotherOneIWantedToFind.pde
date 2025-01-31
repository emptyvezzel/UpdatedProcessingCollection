color c0 = #F04248;
color c1 = #FFADBA;
color c2 = #FFFF31;
color c3 = #3A86FF;
color c4 = #269464;
// color c0 = #e86d52;
//color c1 = #f5a162;
//color c2 = #edc16b;
//color c3 = #28a08c;
//color c4 = #2a444f;
float colVal;
float changeVar = 0;
float lerpInc = 0;
float rotVar = 0.00;
float firstVar = 0;
float secondVar = 0;
float thirdVar = 0;
int rand1st = 1;
int rand2nd = 1;
int rand3rd = 1;
int size = 50;
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity;
float sinSize = 0.1;
int count = 0;
int trig = 0;
int backBool = 0;

void setup() {
  //size(1000, 1000);
  fullScreen();
  minim = new Minim(this);
  in = minim.getLineIn();
  background(c0);
}

void draw() {
  if(backBool % 2 == 0) background(0);
  translate(width/2, height/2);
  size = 6;
  sinSize = 0.009;
  if (size < 1) size = 1;
  changeVar += 0.002;
  sensitivity = 18990;
  //for FS
  //for (float j = -size-90; j < height/size; j+= 1.0) {
    //for (float i = -size-170; i < width/size; i+= 1.0) {
  //for 1kpx res
  for (float j = -size-95; j < height/size; j+= 1.0) {
    for (float i = -size-95; i < width/size; i+= 1.0) {
      //float n = sin(i*2.8)*1.0-tan(i*sinSize*1.0)*1.0 + tan(j*sinSize*1.0)*1.0;
      //n = int(abs(n-0.0)*2);
      if (rand1st % 4 == 0) firstVar = i/(width/size/4)/changeVar;
      if (rand1st % 4 == 1) firstVar = i/(width/size/4)*changeVar;
      if (rand1st % 4 == 2) firstVar = i/(width/size/4)-changeVar;
      if (rand1st % 4 == 3) firstVar = i/(width/size/4)+changeVar;
      if (rand2nd % 4 == 0) secondVar = j/(width/size/4)/changeVar;
      if (rand2nd % 4 == 1) secondVar = j/(width/size/4)*changeVar;
      if (rand2nd % 4 == 2) secondVar = j/(width/size/4)-changeVar;
      if (rand2nd % 4 == 3) secondVar = j/(width/size/4)+changeVar;
      if (rand2nd % 4 == 0) thirdVar = mag(j/changeVar, i/changeVar)/(width/size/2);
      if (rand2nd % 4 == 1) thirdVar = mag(j*changeVar, i/changeVar)/(width/size/2);
      if (rand2nd % 4 == 2) thirdVar = mag(j/changeVar, i*changeVar)/(width/size/2);
      if (rand2nd % 4 == 3) thirdVar = mag(j*changeVar, i*changeVar)/(width/size/2);
      float n = noise(firstVar, secondVar, thirdVar);
      n = int(abs(n-0.5)*27);
      colVal = n*changeVar%5;
      lerpInc = n*changeVar%1;
      if (colVal > 0 && colVal < 1) fill(lerpColor(c0, c1, lerpInc));
      if (colVal > 1 && colVal < 2) fill(lerpColor(c1, c2, lerpInc));
      if (colVal > 2 && colVal < 3) fill(lerpColor(c2, c3, lerpInc));
      if (colVal > 3 && colVal < 4) fill(lerpColor(c3, c4, lerpInc));
      if (colVal > 4) fill(lerpColor(c4, c0, lerpInc));
      noStroke();
      //fill(returnCol(lerpInc, (colVal + sin(i*0.1) + cos(j*-0.2)) % 5));
      if (n % 3 > 1) 
        rect(i*size, j*size, size, size+abs(in.left.get(round(abs(i))%1024)*sensitivity));
    }
  }
  count++;
  if (count % 1400 == 0) generateNewPallet();
}

color returnCol(float lerpIn, float colVal) {
  color thisCol = 0;
  if (colVal > 0 && colVal <= 1) thisCol = lerpColor(c0, c1, lerpIn);
  if (colVal > 1 && colVal <= 2) thisCol = lerpColor(c1, c2, lerpIn);
  if (colVal > 2 && colVal <= 3) thisCol = lerpColor(c2, c3, lerpIn);
  if (colVal > 3 && colVal <= 4) thisCol = lerpColor(c3, c4, lerpIn);
  if (colVal > 4) thisCol = lerpColor(c4, c0, lerpIn);
  return thisCol;
}

void keyPressed() {
  if (key == ' ') {
    backBool++;
  }
  if (key == 'c') {
    generateNewPallet();
    count = 0;
  }
  if (key == 'b'){
    trig++;
    generateNewPallet();
    count = 0;
  }
}

void generateNewPallet() {
  c0 = color(random(0, 255), random(0, 255), random(0, 255));
  c1 = color(random(0, 255), random(0, 255), random(0, 255));
  c2 = color(random(0, 255), random(0, 255), random(0, 255));
  c3 = color(random(0, 255), random(0, 255), random(0, 255));
  c4 = color(random(0, 255), random(0, 255), random(0, 255));
  rand1st = round(random(0, 100));
  rand2nd = round(random(0, 100));
  rand3rd = round(random(0, 100));
  colVal = 0;
  changeVar = 0;
  lerpInc = 0;
  rotVar = 0.00;
}
