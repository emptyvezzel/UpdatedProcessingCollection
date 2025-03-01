int numPoints = 50;
float[] x, y, vx, vy;

void settings(){
  size(800, 600);
}

void setup(){
  x = new float[numPoints];
  y = new float[numPoints];
  vx = new float[numPoints];
  vy = new float[numPoints];

  for(int i = 0; i < numPoints; i++){
    x[i] = random(width);
    y[i] = random(height);
    vx[i] = random(2, 4) * (random(1) > 0.5 ? 1 : -1);
    vy[i] = random(2, 4) * (random(1) > 0.5 ? 1 : -1);
  }
}

void draw(){
  background(0);
  fill(255);
  textSize(12);

  for(int i = 0; i < numPoints; i++){
    x[i] += vx[i];
    y[i] += vy[i];

    if(x[i] <= 0 || x[i] >= width) vx[i] *= -1;
    if(y[i] <= 0 || y[i] >= height) vy[i] *= -1;

    ellipse(x[i], y[i], 5, 5);
    text("(" + int(x[i]) + ", " + int(y[i]) + ")", x[i] + 5, y[i] - 5);
  }
}
