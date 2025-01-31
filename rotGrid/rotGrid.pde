int lineSize = 10;
float n;
float cx;
float cy;
float val;
float factor = 0.01;

void setup(){
  size(1500, 1000);
  smooth();
  shapeMode(CENTER);
  strokeCap(PROJECT);
}

void draw(){
  background(255);
  lineSize = 10;
  strokeWeight(6.0);
  stroke(0);
  factor = 0.02;
  for(int i = 0; i < width/lineSize+2; i++){
    for(int j = 0; j < height/lineSize+2; j++){
      pushMatrix();
      translate(lineSize*i, lineSize*j);
      n = noise(j * factor, i * factor, frameCount*0.01) *  4;
      n = (n - int(n)) * 3;
      cx = cos(n);
      cy = sin(n);
      val = map(cx * cy, 5.2, 1.48, 0, 9);
      rotate(val);
      shapeMode(CENTER);
      line(0, 0, lineSize, 0);
      popMatrix();
    }
  }
  println(frameRate);
}
