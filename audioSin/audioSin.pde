import ddf.minim.*;
Minim minim;
AudioInput in;

int points = 100;
int sensitivity;
float[] amplitudes;
float t, radius, level, angle, x, y, offsetX, offsetY, soundVar;

void setup(){
  size(600,600,P3D);
  minim = new Minim(this);
  in = minim.getLineIn();
  amplitudes = new float[points];
}

void draw(){
  background(0);
  translate(width/2, height/2);
  radius = width * 0.3;
  sensitivity = 300;
  t += 0.02;
  for(int i=0; i<points; i++){
    soundVar = in.left.get(i) * sensitivity;
    angle = TWO_PI * i / points;
    x = cos(angle) * radius;
    y = sin(angle) * radius;
    amplitudes[i] = lerp(amplitudes[i], soundVar * sin(angle * 4 + t), 0.1);
    offsetX = cos(angle + t) * amplitudes[i];
    offsetY = sin(angle + t) * amplitudes[i];
    
    pushMatrix();
    translate(x + offsetX, y + offsetY);
    fill(lerpColor(color(0,255,0), color(0,0,255), float(i)/points));
    ellipse(0, 0, 10, 10);
    popMatrix();
  }
}
