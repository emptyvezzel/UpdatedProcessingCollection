boolean animate = true;
int xDist = 0;
int yDist = 0;
float zoff = 0;
float angle = 0;
float x = 0;
float y = 0;
float n = 0;
float scale = 0.005;
float size = 100;
float animationSpeed = 1.00;
float radius = 0;  
float radInc = 0.0000;

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100);
  strokeWeight(1.5);
  radius = 0;
}

void draw() {
  size = 400;
  animationSpeed = 0.01;
  //radius = 1;  
  xDist = -50;
  yDist = -50;
  background(255);
  stroke(0);
  noFill();
  for (int i = xDist; i <= width - xDist; i += 3) {
    beginShape();
    for (int j = yDist; j <= height - yDist; j += 10) {
      x = i;
      y = j;
      scale = 0.003;
      //if (dist(i, j, width / 2, height / 2) < size) {
        n = map(noise(i * scale, j * scale, zoff), 0, 1, -1, 1);
        x = i +  n*radius * sin(angle + n * 10);
        y = j +  n*radius * cos(angle + n * 10);
      //}
      curveVertex(x, y);
    }
    endShape();
  }
  zoff += 0.04;
  angle += animationSpeed;
  if(frameCount % 30 == 0) println(frameRate);
  radInc += 0.000001;
  radius += radInc;
}
