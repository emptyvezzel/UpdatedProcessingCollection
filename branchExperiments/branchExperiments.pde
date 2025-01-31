import ddf.minim.*;
Minim minim;
AudioInput in;
int xPos;
float sensitivity;

float z = 0;
ArrayList fractals;
float rInc = 0.00;
float facInc = 0.00;

void setup() {
  size(800, 800, P3D);
  colorMode(HSB);
  fractals = new ArrayList();
  fractals.add(new Fractal(90.0, 20.0, random(10, 30), 1.1));
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  strokeWeight(16.1);
  sensitivity = 756;
  z = 100;
  rInc += 0.01;
  facInc = 0.00;
  translate(width/2, height/2, z);
  //float camy = map(radians(mouseX), 0, 14, 0, TWO_PI);
  //float camx = map(radians(mouseY), 0, 14, 0, TWO_PI);
  //rotateX(camx*2);
  //rotateY(camy);
  background(0);
  stroke(255);
  for (int i=fractals.size()-1; i>=0; i--) {
    Fractal fractal = (Fractal) fractals.get(i);
    fractal.draw();
    if (keyPressed == true) {
      fractals.remove(i);
      fractals.add(new Fractal(70.0, 20.0, random(10, 90), random(0.2, 1.1)));
    }
  }
}

class Fractal {
  float b;
  float g;
  float r;
  float fac;
  Fractal(float ib, float ig, float ir, float ifac) {
    b = ib;
    g = ig;
    r = ir;
    fac = ifac;
  }
  void draw() {
    rInc += 0.001;
    facInc += 0.00001;
    branch(b-0.0, g-0.0, r-rInc, fac-facInc);
  }
  void branch(float b, float g, float r, float fac) {
    stroke((abs(r*9))%255, 255, 255);
    b*=0.8;
    r*=fac;
    if (b > g - 4) {
      pushMatrix();
      rotateX(r);
      line(0, 0, 0, -b+in.left.get(0)*sensitivity);
      translate(0, -b);
      branch(b, g, r, fac);
      popMatrix();
      pushMatrix();
      rotateX(-r);
      line(0, 0, 0, -b+in.left.get(0)*sensitivity);
      translate(0, -b);
      branch(b, g, r, fac);
      popMatrix();
      pushMatrix();
      rotateZ(r);
      line(0, 0, 0, -b+in.left.get(0)*sensitivity);
      translate(0, -b);
      branch(b, g, r, fac);
      popMatrix();
      pushMatrix();
      rotateZ(-r);
      line(0, 0, 0, -b+in.left.get(0)*sensitivity);
      translate(0, -b);
      branch(b, g, r, fac);
      popMatrix();
    }
  }
}
