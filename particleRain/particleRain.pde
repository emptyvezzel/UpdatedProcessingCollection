ArrayList<Particle> particles;
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity = 50;

void setup() {
  size(1500, 1000);
  particles = new ArrayList<Particle>();
  colorMode(HSB);
  background(0);
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  //background(0);
  sensitivity = 5;
  for (int i = 0; i < 5; i++) {
    particles.add(new Particle(random(width), random(-20, 0)));
  }

  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update();
    if(i > 1) p.show(in.left.get(i%1024)*sensitivity);

    if (p.isOffScreen()) {
      particles.remove(i);
    }
  }
}

class Particle {
  float x, y;
  float ySpeed;
  color c;
  float size;

  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    this.ySpeed = random(1, 5);
    this.size = random(1, 30);
    this.c = color(random(255), random(255), random(255));
  }

  void update() {
    y += ySpeed;
    //changeColor();
  }

  void show(float sound) {
    noStroke();
    fill(c);
    ellipse(x + sound, y, size, size);
  }

  void changeColor() {
    float r = red(c) + random(-1, 1);
    float g = green(c) + random(-1, 1);
    float b = blue(c) + random(-1, 1);
    c = color(constrain(r, 0, 255), constrain(g, 0, 255), constrain(b, 0, 255));
  }

  boolean isOffScreen() {
    return y > height;
  }
}
