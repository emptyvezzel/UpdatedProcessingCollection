import ddf.minim.*;
Minim minim;
AudioInput in;

int points = 100;
int sensitivity;
float[] amplitudes;
float t, radius, level, angle, x, y, offsetX, offsetY, soundVar;
color[] colors;

void setup(){
  size(600,600,P3D);
  minim = new Minim(this);
  in = minim.getLineIn();
  colorMode(HSB);
  amplitudes = new float[points];
  colors = new color[points];
  
  for(int i = 0; i < points; i++){
    colors[i] = color(255, random(150,255), random(200,255)); 
  }
}

void draw(){
  background(0);
  translate(width/2, height/2);
  radius = width * 0.3;
  sensitivity = 300;
  t += 0.02;
  
  for(int i = 0; i < points; i++){
    int prevIndex = (i - 1 + points) % points;
    int nextIndex = (i + 1) % points;
    float avgSound = (in.left.get(prevIndex) + in.left.get(i) + in.left.get(nextIndex)) / 3.0;
    soundVar = avgSound * sensitivity;
    //soundVar = in.left.get(i) * sensitivity;
    angle = TWO_PI * i / points + t * 0.1; 
    x = cos(angle) * radius;
    y = sin(angle) * radius;
    amplitudes[i] = lerp(amplitudes[i], soundVar * sin(angle * 4 + t), 0.1);
    offsetX = cos(angle + t) * amplitudes[i];
    offsetY = sin(angle + t) * amplitudes[i];
    colors[i] = lerpColor(colors[i], color(random(200,255), random(150,255), random(200,255)), 0.02);
    pushMatrix();
    translate(x + offsetX, y + offsetY);
    fill(colors[i]%255, 180);
    ellipse(0, 0, 10, 10);
    popMatrix();
  }
}
