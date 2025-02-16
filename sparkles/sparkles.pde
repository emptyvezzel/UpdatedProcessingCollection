int maxSparkles = 100;
Sparkle[] sparkles = new Sparkle[maxSparkles];
int w, h;

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
  float x, y, size, life, maxLife, alpha, flicker;
  
  Sparkle(){
    respawn();
  }
  void respawn(){
    x = random(w);
    y = random(h);
    size = random(2, 10);
    maxLife = random(40, 100);
    life = maxLife;
  }
  void update(){
    life -= 1;
    if(life <= 0)respawn();
    alpha = map(life, 0, maxLife, 0, 255);
    flicker = sin(frameCount * 0.2 + x * 0.1) * 50;
  }
  void display(){
    noStroke();
    for(float r = size; r > 0; r--){
      fill(255, alpha - flicker - r * 10);
      ellipse(x, y, r, r);
    }
  }
}
