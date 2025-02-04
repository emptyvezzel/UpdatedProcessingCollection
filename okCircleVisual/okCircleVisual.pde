int numCircles = 1000;
int moveDir, colDir = 1;
int colNum, bgDraw = 0;
float angle, radius, x, y, size, r, g, b, frame, movement, randColChange, colAdd, 
colAdd0, colAdd1, colAdd2;

void setup() {
  //fullScreen();
  size(2000, 1000);
  noStroke();
  background(0);
}

void draw() {
  if(bgDraw % 2 == 0) background(0);
  numCircles = 2000;
  translate(width / 2, height / 2);
  for (int i = 0; i < numCircles; i++) {
    angle = TWO_PI / numCircles * i + frame * movement + sin(frame * 0.06);
    radius = sin(frame * 0.03 + i * 0.2) * 300 + cos(frame * 0.02 + i * 0.15) * 1000;
    x = radius * cos(angle) + sin(frame * 0.05 + i * 0.2) * 50;
    y = radius * sin(angle) + cos(frame * 0.05 + i * 0.3) * 50;
    size = abs(sin(frame * 0.2 + i * 0.5)) * 50 + 30 + sin(frame * 0.1) * 10;
    r = map(sin(frame * (0.1+colAdd0) + i * 0.4), -1, 1, 50, 255);
    g = map(cos(frame * (0.15+colAdd1) + i * 0.5), -1, 1, 50, 255);
    b = map(sin(frame * (0.2+colAdd2) + i * 0.6), -1, 1, 50, 255);
    fill(r, g, b, 150 + sin(frame + i) * 50);
    pushMatrix();
    rotate(sin(frame * 0.01 + i * 0.1) * angle);
    ellipse(x, y, size, size);
    popMatrix();
  }
  frame += 0.1;
  movement += 0.00001 * moveDir;
  if(abs(movement) > 0.3) moveDir *= -1;
  randColChange = random(0, 1000);
  if(randColChange > 990){
    colDir *= -1;
    colNum++;
  }
  if(colNum % 3 == 0) colAdd0 += 0.001*colDir;
  if(colNum % 3 == 1) colAdd1 += 0.001*colDir;
  if(colNum % 3 == 2) colAdd2 += 0.001*colDir;
}

void keyPressed(){
  if(key == 'b') bgDraw++;
}
