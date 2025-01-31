float x, y;
int rectSize = 20;
color [] colors;
float zoomVar = 10;
int changeZoomVal = 1;

//minim
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity;

void setup() {
  size(2000, 1000);
  //fullScreen();
  background(0);
  colorMode(HSB, 365, 100, 100);
  x = 0;
  y = 0;
  generateCols();
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  rectSize = 6;
  background(colors[colors.length-1]);
  sensitivity = 1000;
  for (int i = 0; i < width; i += rectSize) {
    for (int j = 0; j < height; j += rectSize) {
      float n = (sin(sqrt(sq(i - width / 2) + sq(j - height / 2)) / zoomVar + x / -1) + 1) / 2;
      int colorIndex = int(map(n, 0, 1, 0, colors.length)) % colors.length;
      fill(lerpColor(colors[colorIndex], colors[(colorIndex + 1) % colors.length], n*colors.length - colorIndex)+1);
      rect(i + sin(x + i) * (10 + in.left.get(i%1024)*sensitivity), j + cos(y + j) * (10 + in.left.get(i%1024)*sensitivity), rectSize + 4, rectSize + 4);
    }
  }
  x += 0.03;
  y += 0.13;
  zoomVar += 1.8*changeZoomVal;
  if(zoomVar < 10) changeZoomVal *= -1;
  if(zoomVar > 300) changeZoomVal *= -1;
  println(zoomVar);
}

void generateCols(){
  noStroke();
  colors = new color[4];
  for (int i=0; i<colors.length; i++) {
    colors[i] = color(random(255), random(150), random(150));
  }
}

void keyPressed(){
  generateCols();
}
