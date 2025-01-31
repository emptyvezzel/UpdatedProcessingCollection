float angle;

void setup(){
  size(963, 1080);
  surface.setLocation(957, 0);
  noStroke();
  colorMode(HSB);
  background(255);
  fill(0, 0, 0);
}

void draw(){
  background(255);
  float x = width;
  float dia = 125;
  int num = 150;
  translate(width/2, height/2);
  for(float a=0; a<360; a+=22.5){
    //fill(a/2.028%255, 255, 255);
    rotate(radians(a));
    pushMatrix();
    for(int i=0; i<num; i++){
      scale(0.95);
      rotate(radians(angle));
      rect(x, 0, dia, dia);
    }
    popMatrix();
    pushMatrix();
    for(int i=0; i<num; i++){
      scale(0.95);
      rotate(-radians(angle));
      rect(x, 0, dia, dia);
    }
    popMatrix();
  }
  angle+=0.01;
}
