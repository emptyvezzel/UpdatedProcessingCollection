int num = 256;
float rot = TWO_PI/num;
float innerRadZero, outerRad = 250;
float barrier = 0.96;
void setup() {
  size(700, 700);
  smooth();
}
void draw() {
  background(255);
  translate(width/2, height/2);
  strokeWeight(0.5);
  beginShape(LINES);
  for (int i=0; i<num; i++) {
    float angle = i*rot;
    float x = cos(angle);
    float y = sin(angle);
    float innerRad = 150 + 40*sin( radians(360*noise(i*0.015)) + millis()*0.003);
    if (i == 0) {
      innerRadZero = innerRad;
    }
    else if (i>num*barrier) {
      float perc = map(i, num*barrier, num, 0, 1);
      innerRad = lerp(innerRad, innerRadZero, perc);
    }
    line(x*innerRad, y*innerRad, x*outerRad, y*outerRad);
  }
  endShape();
}
