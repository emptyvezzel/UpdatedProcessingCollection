import ddf.minim.*;

int lines = 1000;
int base = 50;
int bgDraw = 0;
float sensitivity = 50;
float timeOffset = 0;
float[] audioValues;
color[] palette;

// Minim
Minim minim;
AudioInput in;

void setup(){
  size(800, 800);
  colorMode(HSB);
  generateColors();
  noFill();
  
  audioValues = new float[lines];
  
  // Minim setup
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw(){
  base = 0;
  sensitivity = 1000;
  if(bgDraw % 2 == 0) background(0);
  translate(width/2, height/2);
  for(int i = 0; i < lines; i++){
    float targetValue = in.left.get(i % 1024) * sensitivity;
    audioValues[i] = lerp(audioValues[i], targetValue, 0.1); // Smooth transition
    
    float angle = map(i, 0, lines, 0, TWO_PI);
    float radius = base + audioValues[i] * 2;
    float x = cos(angle + timeOffset) * radius;
    float y = sin(angle + timeOffset) * radius;
    
    float t = map(i, 0, lines, 0, 1);
    color c = lerpColor(palette[floor(t * 4)], palette[(floor(t * 4) + 1) % 5], t * 4 % 1);
    
    stroke(c);
    strokeWeight(2);
    line(0, 0, x, y);
  }
  timeOffset += 0.02;
}

void keyPressed(){
  if(key == ' ') bgDraw++;
  if(key == 'b') generateColors();
}

void generateColors(){
  palette = new color[5];
  for (int i = 0; i < 5; i++) {
    palette[i] = color(random(255), random(255), random(167, 255));
  }
}
