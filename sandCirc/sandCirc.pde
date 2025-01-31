import ddf.minim.*;
Minim minim;
AudioInput in;
float sensitivity;
int n = 10000;
int amt = 1;
int randX;
int randY;
float[] m = new float[n];
float[] x = new float[n];
float[] y = new float[n];
float[] vx = new float[n];
float[] vy = new float[n];

void setup() {
  minim = new Minim(this);
  in = minim.getLineIn();
  //size(800, 800);
  fullScreen();
  fill(0, 32);
  background(0);
  reset();
}

void draw() {
  amt = 8;
  n = 1024*amt;
  sensitivity = 10;
  noStroke();
  rect(0, 0, width, height);
  strokeWeight(2.5);
  for (int i = 0; i < n; i++) {
    float dx = randX - x[i];//+in.left.get(i/amt)*sensitivity;
    float dy = randY - y[i];//+in.left.get(i/amt)*sensitivity;
    float d = sqrt(dx*dx + dy*dy);
    if (d < 1) d = 1;
    float f = sin(d * 0.23 + in.left.get(i/amt)*sensitivity) * m[i] / d;
    vx[i] = vx[i] * 0.5 + f * dx;
    vy[i] = vy[i] * 0.5 + f * dy;
  }
  for (int i = 0; i < n; i++) {
    x[i] += vx[i];
    y[i] += vy[i];
    if (x[i] < 0) x[i] = width;
    else if (x[i] > width) x[i] = 0;
    if (y[i] < 0) y[i] = height;
    else if (y[i] > height) y[i] = 0;
    if (m[i] < 0) stroke(128, 212, 255);
    else stroke(135, 248, 170);
    point(x[i], y[i]);
  }
  if(frameCount % 60 == 0) generateRand();
  if(frameCount % 600 == 0) reset();
}

void reset() {
  for (int i = 0; i < n; i++) {
    m[i] = randomGaussian() * 7;
    x[i] = random(width);
    y[i] = random(height);
  }
}

void generateRand(){
  randX = round(random(0, width));
  randY = round(random(0, height));
}

void mousePressed() {
  reset();
}
