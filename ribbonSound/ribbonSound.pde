import ddf.minim.*;

Minim minim;
AudioInput in;

int numLayers, frames = 0;
float t = 0, baseSpeed = 0.02;
float amp, n, r, angle, x1, y1, x2, y2, c;

void setup(){
  size(800,800);
  minim = new Minim(this);
  in = minim.getLineIn();
  numLayers = 50;
  noFill();
}

void draw(){
  t += baseSpeed;
  amp = in.mix.level() * 5;
  background(0);
  translate(width/2, height/2);
  for(int i = 0; i < numLayers; i++){
    n = norm(i, 0, numLayers);
    r = width * 0.5 * (1 - n) + amp * 50;
    angle = t * 2 + n * PI;
    x1 = cos(angle) * r; y1 = sin(angle) * r;
    x2 = cos(angle + PI/2) * r * 0.8; y2 = sin(angle + PI/2) * r * 0.8;
    c = map(n, 0, 1, 180, 360);
    stroke(c, 255, 255, 180);
    strokeWeight(map(n, 0, 1, 6, 1));
    bezier(x1, y1, x2, y2, -x2, -y2, -x1, -y1);
  }
  frames++;
}
