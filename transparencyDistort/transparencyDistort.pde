PImage img;
PGraphics pg;
float waveStrength = 20, noiseStrength = 10;
boolean applyDistortion = true;
PImage distorted;
int x, y, newX, index, newIndex;
float waveOffset, noiseOffset;

void setup(){
  size(800, 800, P2D);
  img = loadImage("your_image.png");
  pg = createGraphics(img.width, img.height, P2D);
  distorted = createImage(img.width, img.height, ARGB);
}

void draw(){
  pg.beginDraw();
  pg.clear();
  pg.image(img, 0, 0);
  pg.endDraw();
  
  if(applyDistortion)distortImage(pg);
  
  image(pg, (width - img.width)/2, (height - img.height)/2);
}

void distortImage(PGraphics src){
  loadPixels();
  src.loadPixels();
  distorted.loadPixels();
  
  for(y = 0; y < src.height; y++){
    for(x = 0; x < src.width; x++){
      waveOffset = sin(y * 0.05) * waveStrength;
      noiseOffset = (noise(x * 0.01, y * 0.01) - 0.5) * noiseStrength;
      newX = constrain(int(x + waveOffset + noiseOffset), 0, src.width - 1);
      index = y * src.width + x;
      newIndex = y * src.width + newX;
      distorted.pixels[index] = src.pixels[newIndex];
    }
  }
  
  distorted.updatePixels();
  src.image(distorted, 0, 0);
}

void keyPressed(){
  if(keyCode == UP)waveStrength += 2;
  if(keyCode == DOWN)waveStrength -= 2;
  if(keyCode == LEFT)noiseStrength -= 2;
  if(keyCode == RIGHT)noiseStrength += 2;
  if(key == ' ')applyDistortion = !applyDistortion;
}
