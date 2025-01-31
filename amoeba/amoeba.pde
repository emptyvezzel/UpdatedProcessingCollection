int cols, rows;
float scl = 35;
float minus = 0.03;
int w = 2000;
int h = 1600;
int redraw = 0;
int speedVar;
int record = 1;
float changeVar = -900;
float changeSpeed = 5;
float thirdChange = changeSpeed/3;
int sensitivity = 300;
float additive = 0.01;
float speed = 0.01;
float xSpeed = 0.01;
float ySpeed = 0.01;
float rotVar = 1.00;
float flying = 0;
float[][] terrain;
import ddf.minim.*;
Minim minim;
AudioInput in;

void setup() {
  size(1920, 1080);
  //fullScreen();
  //colorMode(HSB);
  smooth();
  minim = new Minim(this);
  in = minim.getLineIn();
}


void draw() {
  scl = abs(9.6);
  if(scl - minus <= 1) scl = 1;;
  if(scl == 0) scl = 1;
  w = width + 100;
  h = height + 100;;
  ySpeed = 0.1;
  xSpeed = 0.1;
  cols = w / (int)scl;
  sensitivity = 300;
  rows = abs(h/ (int)scl);
  terrain = new float[cols][rows];
  flying -= 0.01;
  additive += 0.85;
  float yoff = flying;
  noStroke();
  for (int y = abs(0); y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0.00, 1.24, changeVar, 300);
      xoff += xSpeed;
    }
    yoff += ySpeed;
  }
  noStroke();
  //background(0);
  translate(width/2, height/2+0);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    for (int x = 0; x < cols; x++) {
      //fill((terrain[x][y+1]*in.left.get(y)*sensitivity) % 255, (terrain[x][y+1]*4.0) % 255, (terrain[x][y+1]*4.0) % 255);
      fill((terrain[x][y+0]*4.0 + additive*2.5) % 255, (terrain[x][y+1]*1.7+additive*1.0) % 255, (terrain[x][y+1]*4.7+additive*1.0) % 255);
      rect(x*scl, y*scl, scl, scl);
    }
  }
  if(scl < 14 && minus == 0.03) minus /= 2;
  if(scl < 4 && minus == 0.015) minus /= 1.5;
  println(changeVar);
  scl -= minus;
  if(changeVar > 50 && changeVar < 350) changeVar += changeSpeed/3;
  else changeVar += changeSpeed;
  if(changeVar <= -1200 | changeVar >= 1100) changeSpeed *= -1;
  //saveFrame("line-######.png");
}

void keyPressed(){
  if(key == ' ') record++;
}
