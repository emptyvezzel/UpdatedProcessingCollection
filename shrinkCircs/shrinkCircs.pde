import ddf.minim.*;
Minim minim;
AudioInput in;
int res = 512;
int prev, colorIndex, bgDraw, shapeToggle;
float radius = 200;
float angleStep = TWO_PI/res; 
float amp, blend;
float smoothFactor = 0.1;
float blendFactor = 0.2 ;
float shrinkFactor = 1;
float shrinkSpeed = 0.005;
PVector[] points = new PVector[res];
float[] smoothedAmps = new float[res], tempAmps = new float[res];
color colVal;
color[] colors = new color[5];

void setup(){
  size(800,800);
  colorMode(HSB);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, res);
  for (int i = 0; i < res; i++){
    points[i] = new PVector();
    smoothedAmps[i] = 0;
    tempAmps[i] = 0;
  }
  genCols();
  background(0);
}

void draw(){
  if(bgDraw == 1) background(0);
  translate(width/2, height/2);
  shrinkFactor -= shrinkSpeed;
  if (shrinkFactor <= 0){
    shapeToggle++;
    shrinkFactor = 3;
    colorIndex = (colorIndex + 1) % 5;
  }
  for (int i = 0; i < res; i++){
    amp = in.left.get(i) * 100;
    smoothedAmps[i] = lerp(smoothedAmps[i], amp, smoothFactor);
  }
  for (int i = 0; i < res / 10; i++){
    blend = lerp(smoothedAmps[i], smoothedAmps[res - i - 1], blendFactor);
    smoothedAmps[i] = blend;
    smoothedAmps[res - i - 1] = blend;
  }
  for (int i = 0; i < res; i++){
    prev = (i - 1 + res) % res;
    int next = (i + 1) % res;
    tempAmps[i] = (smoothedAmps[prev] + smoothedAmps[i] + smoothedAmps[next]) / 3;
  }
  for (int i = 0; i < res; i++){
    smoothedAmps[i] = tempAmps[i];
    points[i].set(cos(i * angleStep) * (radius * shrinkFactor + smoothedAmps[i]), sin(i * angleStep) * (radius * shrinkFactor + smoothedAmps[i]));
  }
  colVal = lerpColor(colors[colorIndex], colors[(colorIndex + 1) % 5], 1 - shrinkFactor*2);
  if(shapeToggle % 2 == 1) {
    strokeWeight(2.0);
    stroke(colVal);
    noFill();
  } else {
    strokeWeight(1.0);
    fill(colVal);
    stroke(0);
  }
  beginShape();
  for (int i = 0; i < res; i++) vertex(points[i].x, points[i].y);
  endShape(CLOSE);
}

void keyPressed(){
  if(key == ' ') bgDraw++;
  if(key == 'b') shapeToggle++;
  if(key == 'g') genCols();
}

void genCols(){
  for (int i = 0; i < 5; i++) colors[i] = color(random(0, 255), 
  random(126, 255), random(126, 255));
}
