int bgDraw, numPoints = 5000;
float[] x, y, vx, vy, ax, ay, angle, speed, changeTimer;
int[] direction;
color[] colors;

void settings(){
  fullScreen();
}

void setup(){
  x = new float[numPoints];
  y = new float[numPoints];
  vx = new float[numPoints];
  vy = new float[numPoints];
  ax = new float[numPoints];
  ay = new float[numPoints];
  angle = new float[numPoints];
  speed = new float[numPoints];
  changeTimer = new float[numPoints];
  direction = new int[numPoints];
  colors = new color[numPoints];
  noStroke();
  for(int i = 0; i < numPoints; i++){
    x[i] = random(width);
    y[i] = random(height);
    angle[i] = random(TWO_PI);
    speed[i] = random(1, 5);
    vx[i] = cos(angle[i]) * speed[i];
    vy[i] = sin(angle[i]) * speed[i];
    ax[i] = random(0.005, 0.05);
    ay[i] = random(0.005, 0.05);
    changeTimer[i] = random(100, 500);
    direction[i] = random(1) > 0.5 ? 1 : -1;
    colors[i] = color(random(255), random(255), random(255));
  }
}

void draw(){
  if(bgDraw % 2 == 0) background(0, 20);
  textSize(12);
  numPoints = 200;
  for(int i = 0; i < numPoints; i++){
    if(changeRoll(changeTimer[i])){
      angle[i] = random(TWO_PI);
      speed[i] = random(1, 5);
      vx[i] = cos(angle[i]) * speed[i] * (random(1) > 0.5 ? 1 : -1);
      vy[i] = sin(angle[i]) * speed[i] * (random(1) > 0.5 ? 1 : -1);
      ax[i] = random(0.005, 0.05);
      ay[i] = random(0.005, 0.05);
      changeTimer[i] = random(100, 500);
      direction[i] = random(1) > 0.5 ? 1 : -1;
    }
    angle[i] += ax[i] * direction[i];
    vx[i] = cos(angle[i]) * speed[i];
    vy[i] = sin(angle[i]) * speed[i];
    x[i] = constrain(x[i] + vx[i], 0, width);
    y[i] = constrain(y[i] + vy[i], 0, height);
    float r = red(colors[i]) + sin(frameCount * 0.01 + i * 0.02) * 2;
    float g = green(colors[i]) + sin(frameCount * 0.008 + i * 0.015) * 2;
    float b = blue(colors[i]) + sin(frameCount * 0.012 + i * 0.017) * 2;
    colors[i] = color(constrain(r, 0, 255), constrain(g, 0, 255), constrain(b, 0, 255));
    fill(colors[i]);
    ellipse(x[i], y[i], 5, 5);
    text("(" + int(x[i]) + ", " + int(y[i]) + ")", x[i] + 5, y[i] - 5);
  }
}

void keyPressed(){
  if(key == ' ') bgDraw++;
}

boolean changeRoll(float chance){
  return random(chance) < 3;
}
