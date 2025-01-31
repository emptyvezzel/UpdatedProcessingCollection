float sineTable[];
float dTable[];
float aTable[];
float d,a;
float r,g,b, n;
int offset = 0;
int fc = 0;
float squareDiv = 5;

//minim vars
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity;
 
void setup() {
  size(1000, 1000); //for testing
  //fullScreen();
  colorMode(RGB, 2);
  minim = new Minim(this);
  in = minim.getLineIn();
  background(0);
  sineTable = new float[360];
  for (int i = 0; i < 360; i ++) sineTable[i] = sin(radians(i));
  dTable = new float[width*height];
  aTable = new float[width*height];
  float  cx = width/2;
  float  cy = height/2;
  int n = 0;
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      if (x == cx && y == cy) {
        dTable[n] = 0;
        aTable[n] = 0;
      }
      else {
        dTable[n] = log(dist(x,y,cx,cy));
        aTable[n] = atan2(y - cy, x - cx) + PI;
      }
      ++n;
    }
  }
}
 
void draw() {
  loadPixels();
  sensitivity = 27;
  n = millis() * 0.0058; 
  offset = 0;
  squareDiv = 6;
  if(squareDiv < 1) squareDiv = 1;
  for (int y = 0; y < height; y += 1) {
    for (int x = 0; x < width; x += 1) {
      d = dTable[offset];
      a = aTable[offset];
      if(x > width/(squareDiv+1) && x < (squareDiv*width)/(squareDiv+1) && y > height/(squareDiv+1) && y < (squareDiv*height)/(squareDiv+1)) r = (sineTable[int(degrees(d*(8+abs(in.left.get((x)%1024)*sensitivity))+a)) % 360] * sineTable[int(degrees(a)*3) % 360]) + 1;
      else r = (sineTable[int(degrees(d*(8+abs(in.left.get((y)%1024)*sensitivity))+a)) % 360] * sineTable[int(degrees(a)*3) % 360]) + 1;
      g = (sineTable[359 - int(degrees(abs(d*(8+abs(in.left.get((y)%1024)*sensitivity))+a-PI/2-n))) % 360] * sineTable[int(degrees(a)*5) % 360]) + 1;
      b = (sineTable[int(degrees(d*(8+abs(in.left.get((x*y)%1024)*sensitivity))+a+PI/2+n)) % 360] * sineTable[int(degrees(a)*7) % 360]) + 1;
      pixels[offset ++] = color(r,g,b);       
    }
  }
  ++fc;  
  updatePixels();
}
