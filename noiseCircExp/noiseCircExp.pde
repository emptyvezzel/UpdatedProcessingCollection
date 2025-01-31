int segments = 100;
int amount;
float space;
float ANGLE_PER_SEGMENT = TWO_PI / segments;
int INNER_RADIUS = 100;
float RADIUS_VARIATION = 100;
float NOISE_SCALE = 0.5;
float vari;

void setup() {
  size(800, 800);
  smooth();
  noFill();
  blendMode(ADD);
}

PVector PointForIndex(int i, int j) {
  float angle = ANGLE_PER_SEGMENT * i;
  float cosAngle = cos(angle);
  float sinAngle = sin(angle);
  float time = frameCount * 1e-2*vari;
  float noiseValue = noise(NOISE_SCALE*cosAngle + NOISE_SCALE, NOISE_SCALE*sinAngle + NOISE_SCALE, time);
  float radius = INNER_RADIUS + RADIUS_VARIATION*noiseValue;
  return new PVector((radius+j*space)*cosAngle, (radius+j*space)*sinAngle);
}

void draw() {
  //adj
  vari = 14;
  segments = 100;
  amount = 30;
  space = 8;
  if (segments < 1) segments = 1;
  ANGLE_PER_SEGMENT = TWO_PI / segments;
  background(0);
  strokeWeight(4.0);
  translate(width/2, height/2);
  for (int k = 0; k < 3; k++) {
    if (k == 0) {
      stroke(225, 0, 0);
      INNER_RADIUS = 0;
      RADIUS_VARIATION = 50;
      NOISE_SCALE = 18.5;
    } if (k == 1) {
      stroke(0, 255, 0);
      INNER_RADIUS = 0;
      RADIUS_VARIATION = 50;
      NOISE_SCALE = 19.0;
    } if (k == 2) {
      stroke(0, 0, 255);
      INNER_RADIUS = 0;
      RADIUS_VARIATION = 50;
      NOISE_SCALE = 19.5;
    }
    for (int j = 0; j < amount; j++) {
      beginShape();
      for (int i = 0; i != segments; ) {
        PVector p0 = PointForIndex(++i, j);
        //PVector p1 = PointForIndex(++i);
        vertex(p0.x, p0.y);//, p1.x, p1.y);
      }
      endShape(CLOSE);
    }
  }
  if(frameCount % 60 == 0) println(frameRate);
}
