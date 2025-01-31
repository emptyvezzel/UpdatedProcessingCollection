int points = 300;
int count = 10;
int radius = 300;
float angle = radians(360) / points;
float t = 0.8;
float x = 0;
float y = 0;
float n = 0;
import ddf.minim.*;
Minim minim;
AudioInput in;
float sensitivity;

void setup() {
  //fullScreen();
  size(1000, 1000);
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  background(0);
  strokeWeight(4);
  t += 0.02;
  count = 54;
  sensitivity = 0.2;
  points = 70;
  angle = radians(360) / points;
  noFill();
  translate(width/2, height/2);
  for (int i = 0; i < count; i++) {
    stroke(76+i*7, 196, 234-i*4);
    rotate(in.left.get(((int)(i*Math.floor(1024/count))%1024))*sensitivity);
    beginShape();
    for (int e = 0; e < points; e++) {    
      x = cos(angle * e) * radius;
      y = sin(angle * e) * radius;
      PVector p = new PVector(x, y).normalize();
      n = map(noise(p.x + t, p.y + t), 0, 1, (width/1+-307)-i*13, 20);
      p.mult(n*1.0);
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  }
}
