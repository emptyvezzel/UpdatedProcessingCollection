import peasy.*;
PeasyCam cam;
ArrayList<Strand> strands;
int bgDraw;

void setup(){
  size(800, 800, P3D);
  cam = new PeasyCam(this, 400);
  strands = new ArrayList<Strand>();
  
  for(int i = 0; i < 5; i++){
    strands.add(new Strand(random(100, 255), random(100, 255), random(100, 255), random(50, 200)));
  }
}

void draw(){
  if(bgDraw % 2 == 0) background(0);
  lights();
  for(Strand strand : strands){
    strand.update();
    strand.display();
  }
}

class Strand{
  ArrayList<PVector> points;
  float angle;
  color col;
  float spread;
  Strand(float r, float g, float b, float spreadFactor){
    points = new ArrayList<PVector>();
    col = color(r, g, b);
    angle = random(TWO_PI);
    spread = spreadFactor;
    
    for(int i = 0; i < 200; i++){
      float t = i * 0.1;
      float x = cos(t) * spread;
      float y = sin(t * 1.5) * spread;
      float z = sin(t * 3) * (spread / 2);
      points.add(new PVector(x, y, z));
    }
  }
  
  void update(){
    angle += 0.01;
    for(int i = 0; i < points.size(); i++){
      PVector p = points.get(i);
      float offset = sin(frameCount * 0.05 + i * 0.2) * 5;
      p.x += cos(angle + i * 0.1) * offset;
      p.y += sin(angle + i * 0.1) * offset;
      p.z += cos(angle + i * 0.1) * offset;
    }
  }
  
  void display(){
    pushMatrix();
    rotateY(angle);
    noStroke();
    fill(col);
    
    for(int i = 0; i < points.size() - 1; i++){
      PVector p = points.get(i);
      pushMatrix();
      translate(p.x, p.y, p.z);
      box(8, 8, 8);
      popMatrix();
    }
    popMatrix();
  }
}

void keyPressed(){
  if(key == ' ') bgDraw++;
}
