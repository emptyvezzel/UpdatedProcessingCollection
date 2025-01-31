float angle = 0;
int w = 20;
float ma;
float maxD;
int squareInc = 0;
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity;

void setup() {
  //size(2000, 1100, P3D);
  fullScreen(P3D);
  ma = atan(1/sqrt(2));
  maxD = dist(0, 0, 200, 200);
  colorMode(HSB);
  minim = new Minim(this);
  in = minim.getLineIn();
}


void draw() {
  ortho(-width, width, height, -height, -3000, 10000000);
  ma = atan(1/sqrt(2));
  maxD = dist(0, 0, 200, 200);
  background(0);
  rotateX(ma);
  rotateY(-QUARTER_PI);
  translate(width*0.7, height, 0);
  w = abs(57);
  if(w < 7) w = 7;
  squareInc = w*45;
  sensitivity = 500;
  for (int z = -squareInc; z < height + squareInc; z += w) {
    for (int x = -squareInc; x < width + squareInc; x += w) {
      //fill((abs(z*x))%332, 255, 255);
      pushMatrix();
      float d = dist(x, z, width/2, height/2);
      //float d = in.left.get((abs(z*x))%1024)*sensitivity;
      float offset = map(d, 0, maxD, -PI-0.0, PI-0.0);
      float a = angle + offset; 
      //float h = map(sin(a), -1, 1, 3, 300); 
      float h = map(sin(a), -1, 1, 3, 100+in.left.get(abs(x*z)%300)*sensitivity);
      //noStroke();
      strokeWeight(1.0);
      fill((abs(d)*1.00)%255, 255, 255);
      translate(x - width / 2, 0, z - height / 2);
      box(w - 2, h, w - 2);
      popMatrix();
    }
  }
  angle -= 0.2;
}
