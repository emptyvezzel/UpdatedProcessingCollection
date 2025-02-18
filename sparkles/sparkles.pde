int maxSparkles = 100;
Sparkle[] sparkles = new Sparkle[maxSparkles];
int w, h;
float x, y, size, life, maxLife, alpha, flicker, angle, radius;

void setup(){
  size(800, 800, P2D);
  w = width;
  h = height;
  for(int i = 0; i < maxSparkles; i++){
    sparkles[i] = new Sparkle();
  }
}

void draw(){
  background(0);
  for(int i = 0; i < maxSparkles; i++){
    sparkles[i].update();
    sparkles[i].display();
  }
}

class Sparkle{
  
  Sparkle(){
    respawn();
  }
  
  void respawn(){
    x = random(w);
    y = random(h);
    size = random(4, 12);
    maxLife = random(40, 100);
    life = maxLife;
  }
  
  void update(){
    life -= 1;
    if(life <= 0)respawn();
    alpha = map(life, 0, maxLife, 0, 255);
    flicker = sin(frameCount * 0.2 + x * 0.1) * 30;
  }
  
  void display(){
    pushMatrix();
    translate(x, y);
    noFill();
    stroke(255, alpha - flicker);
    strokeWeight(1.5);
    
    int points = 8;
    float innerRadius = size * 0.3, outerRadius = size;
    
    beginShape();
    for(int i = 0; i < points * 2; i++){
      float angle = PI * i / points;
      radius = (i % 2 == 0) ? outerRadius : innerRadius;
      float sx = cos(angle) * radius;
      float sy = sin(angle) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
    
    popMatrix();
  }
}
