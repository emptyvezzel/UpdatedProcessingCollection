float angle, angle1, angle2;
int testVar = 0;
   
void setup(){
  size(1000,1000);
  rectMode(CENTER);
  noStroke();
  background(0);
  angle1 = random(PI);
  angle2 = random(PI);
}
   
void draw(){
  angle1 += 0.0023;
  angle2 += 0.0028;
  angle = angle1 + angle2;
  translate(width/2,height/2);
  rotate(angle2-angle1);
  for (int j=0; j<2; j++){
    pushMatrix();
    for (int i=0; i<70; i++){
      rotate((-1+2*j)*angle/2);
      scale(0.95);
      float a = i*PI/40. + angle1 * 2 * i;
      fill(100 + 140 * sin(a), 100 - 140 * sin(a + TAU/3), 100 + 140 * sin(a - TAU/3), 60);
      float dia = 30 + 20  * sin(3 * angle2) + 25 * sin(i*HALF_PI/40.);
      f(dia, i);
    }
    popMatrix();
  }
}

void f(float r, int i) {
  r += 40;
  testVar = 0;
  float rx = 2 * cos(TAU * i / 70 ), ry = 15 * sin(TAU * i / 70 );
  if(random(1) < 0.5 * (1 + cos(i))) rect( 300 + rx,   0 + ry, r, r); else ellipse( 300 + rx,   0 + ry, r, r);
  if(random(1) < 0.5 * (1 + cos(i))) rect(-300 + rx,   0 + ry, r, r); else ellipse(-300 + rx,   0 + ry, r, r);
  if(random(1) < 0.5 * (1 + cos(i))) rect(   0 + rx, 300 + ry, r, r); else ellipse(   0 + rx, 300 + ry, r, r);
  if(random(1) < 0.5 * (1 + cos(i))) rect(   0 + rx,-300 + ry, r, r); else ellipse(   0 + rx,-300 + ry, r, r);
}

void mousePressed(){
  background(0);
}
