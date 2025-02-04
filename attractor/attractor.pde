//based on sketch Shifting Stars by Roni Kaufman: https://openprocessing.org/sketch/993783

PVector[] particles;
PVector[] attractors;
PVector move;
color[] palette;
float[] colorOffsets;
int numParticles, numAttractors, colorIndex, bgDraw, bgInit;
float radius, posX, posY, angle, audioValue;

// Minim
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity = 50;

void setup() {
  size(1800, 1000);
  generateColors();
  if (bgInit % 2 == 0) background(0);
  strokeWeight(1);
  colorMode(HSB);
  numParticles = 5000;
  numAttractors = (int) random(3, 10);
  radius = height/2 - 100;
  particles = new PVector[numParticles];
  attractors = new PVector[numAttractors];
  colorOffsets = new float[numParticles];
  generateParticles();
  // Minim setup
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  sensitivity = 100; // Minim
  if (bgDraw % 2 == 1) background(0);
  translate(width / 2, height / 2);
  for (int i = 0; i < numParticles; i++) {
    posX = particles[i].x;
    posY = particles[i].y;
    angle = 0.0;
    for (int j = 0; j < numAttractors; j++) {
      angle += atan2(attractors[j].y - posY, attractors[j].x - posX) * 2;
    }
    move = new PVector(5, 0);
    move.rotate(angle);
    particles[i].add(move);
    float t = (frameCount * 0.001 + colorOffsets[i]) % 1;
    color c = lerpColor(palette[floor(t * 5) % 5], 
                        palette[(floor(t * 5) + 1) % 5], 
                        t * 5 % 1);
    stroke(c);
    audioValue = in.left.get(i%1024) * sensitivity; // Minim
    strokeWeight(1.0);
    line(posX, posY, particles[i].x + audioValue, particles[i].y + audioValue); // Minim
  }
}

void generateColors() {
  palette = new color[5];
  for (int i = 0; i < 5; i++) {
    palette[i] = color(random(255), random(255), random(150, 255));
  }
}

void generateParticles(){
  numParticles = 5000;
  numAttractors = (int) random(3, 10);
  radius = height/2 - 100;
  //particles = new PVector[numParticles];
  attractors = new PVector[numAttractors];
  //colorOffsets = new float[numParticles];
  for (int i = 0; i < numParticles; i++) {
    particles[i] = new PVector(cos(i) * radius, sin(i) * radius);
    colorOffsets[i] = random(1);
  }
  for (int i = 0; i < numAttractors; i++) {
    attractors[i] = new PVector(random(-radius, radius), random(-radius, radius));
  }
}

void keyPressed() {
  if (key == 'v') setup();
  if (key == ' ') bgDraw++;
  if (key == 'b') bgInit++;
  if (key == 'c') generateColors();
}
