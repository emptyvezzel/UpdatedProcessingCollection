import ddf.minim.*;
Minim minim;
AudioInput in;
int xPos;
int sensitivity;
int inc;
int size = 1;
float space = 1;
float col = 0;
int xSpace = 10;

void setup() {
  //size(1000, 800);  
  fullScreen();
  colorMode(HSB);
  minim = new Minim(this);
  in = minim.getLineIn();
  background(0);
}

void draw() {
  stroke(255);
  sensitivity = 1000;
  //inc = 0;
  space = 0;
  size = 2;
  xSpace = 14;
  noStroke();
  for (int j = 0; j < width/xSpace + 2; j++) {
    for (float i = 0; i < width; i += space+size) {
      if (j%2==0) fill((col+(i*0.35)+(j*5.63))%124, 255, 255);
      else fill((col+(i*0.35)+(j*-5.63))%123+122, 255, 255);
      rect(xSpace*j, i, in.left.get(round(i%1024))*sensitivity+0, size);
    }
  }
  col+= 2.7;
}
