int numCircles = 1000;
int moveDir = 1;
float angle, radius, x, y, size, r, g, b, frame, movement;

void setup() {
  size(800, 800);
  noStroke();
  background(0);
}

void draw() {
  //background(0);
  translate(width / 2, height / 2);
  for (int i = 0; i < numCircles; i++) {
    angle = TWO_PI / numCircles * i + frame * movement + sin(frame * 0.06);
    radius = sin(frame * 0.03 + i * 0.2) * 300 + cos(frame * 0.02 + i * 0.15) * 200;
    x = radius * cos(angle) + sin(frame * 0.05 + i * 0.2) * 50;
    y = radius * sin(angle) + cos(frame * 0.05 + i * 0.3) * 50;
    size = abs(sin(frame * 0.2 + i * 0.5)) * 50 + 30 + sin(frame * 0.1) * 10;
    r = map(sin(frame * 0.1 + i * 0.4), -1, 1, 50, 255);
    g = map(cos(frame * 0.15 + i * 0.5), -1, 1, 50, 255);
    b = map(sin(frame * 0.2 + i * 0.6), -1, 1, 50, 255);
    fill(r, g, b, 150 + sin(frame + i) * 50);
    pushMatrix();
    rotate(sin(frame * 0.01 + i * 0.1) * angle);
    ellipse(x, y, size, size);
    popMatrix();
  }
  frame += 0.1;
  movement += 0.00001 * moveDir;
  if(abs(movement) > 0.3) moveDir *= -1;
}
