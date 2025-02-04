float proportion=1; 
float colVar = 0;

void setup() {
  background(255);
  colorMode(HSB);
  size(800, 800);
  mouseX = 200;
  mouseY = 200;
}

void draw() {
  //background(255);
  translate(width/2, height-50);
  strokeWeight(10);
  stroke(colVar%255, 255, 255);
  colVar += 0.2;
  F(200);
  tree(1, 15, 200, proportion, map(mouseY, 0, height, 0, 90), map(mouseX, 0, width, 45, -45));
//  tree(1, 15, 100, proportion, map(mouseY, 0, height, 0, 90), -map(mouseX, 0, width, 45, -45));
}


void tree(int level, int max, float scale, float proportion, float angle, float deviation){
  level+=1;
  scale *= 0.7;

  if(level<max){
  strokeWeight(scale / 10);
   pushMatrix();
   L(angle + deviation);
   F(scale - proportion);
   tree(level, max, scale, proportion, angle, deviation);
   popMatrix();

  strokeWeight(scale/10);
   
   pushMatrix();
   R(angle - deviation);
   F(scale + proportion);
   tree(level, max, scale, proportion, angle, deviation);
   popMatrix();
  }
}

void F(float length){
  line(0,0, 0, -length);
  translate(0, -length);
}

void L(float angle){
  rotate(radians(-angle));
}

void R(float angle){
  rotate(radians(angle));
}

void mouseDragged(){
    proportion += float(mouseY - pmouseY)*0.1;
}
