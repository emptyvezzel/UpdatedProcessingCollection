PImage img;
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity = 50;
int gridSize = 20;
float time, wave, h, s, b;
color c, bg1, bg2;
float lerpInc = 0;
int gridMode = 0;
int colStatic, drawBg, bgColor, waveMode = 1;

void setup() {
  size(800, 800, P3D);
  colorMode(HSB);
  img = loadImage("ts1.png");
  img.resize(width, height);
  minim = new Minim(this);
  in = minim.getLineIn();
  bg1 = generateRandomColor();
  bg2 = generateRandomColor();
  noStroke();
}

void draw() {
  lerpInc += 0.01;
  if(lerpInc > 1){
      bg1 = bg2;
      bg2 = generateRandomColor();
      lerpInc = 0;
  }
  if (drawBg % 2 == 1){
    if(bgColor % 2 == 1){
      background(lerpColor(bg1, bg2, lerpInc));
    } else {
      background(255);
    }
  }

  sensitivity = 100;
  time = millis() * 0.002;
  gridSize = 5;
  if(gridSize < 1) gridSize = 1;

  for (int x = 0; x < width; x += gridSize) {
    for (int y = 0; y < height; y += gridSize) {
      wave = sin(time + (x + y) * 0.02) * gridSize * 0.5;
      int imgX = constrain(x + int(wave), 0, img.width - 1);
      int imgY = constrain(y + int(wave), 0, img.height - 1);
      c = img.get(imgX, imgY);
      h = hue(c);
      s = saturation(c);
      b = brightness(c);
      if(colStatic % 2 == 0){
        h = hue(c) + random(-100, 100);
        s = saturation(c) + random(-100, 100);
        b = brightness(c) + random(-100, 100);
      }
      fill(color(constrain(h, 0, 255), constrain(s, 0, 255), constrain(b, 0, 255), random(100, 255)));
      pushMatrix();
      translate(x, y, sin(time + x * 0.01 + y * 0.01) * 50);
      rotateY(time * 0.1);
      rotateX(time * 0.1);
      if(gridMode % 4 == 0) {
        rect(0, 0, gridSize, gridSize);
      }
      if(gridMode % 4 == 1) {
        ellipse(0, 0, gridSize + in.left.get(x) * sensitivity, gridSize + in.left.get(y) * sensitivity);
      }
      if(gridMode % 4 == 2) {
        triangle(0, 0, gridSize + in.left.get(x) * sensitivity, gridSize + in.left.get(y) * sensitivity, gridSize, gridSize);
      }
      if(gridMode % 4 == 3) {
        rect(0, 0, gridSize + in.left.get(x) * sensitivity, gridSize + in.left.get(y) * sensitivity);
      }
      popMatrix();
    }
  }
}

void keyPressed(){
  if(key == 'g') gridMode++;
  if(key == 'b') drawBg++;
  if(key == 'c') colStatic++;
  if(key == 'v') waveMode++;
  if(key == 'x') bgColor++;
}

color generateRandomColor(){
  return color(random(0, 255), random(100, 255), 255);
}
