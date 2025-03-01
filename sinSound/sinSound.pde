import ddf.minim.*;
Minim minim;
AudioInput in;

int cols = 40;
int rows = 120;
float spacing;
float[][] offsets;
float[] amplitudes;
float t;

void settings(){
  size(800, 800);//
}

void setup(){
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 512);
  spacing = width / (float) cols;
  offsets = new float[cols][rows];
  amplitudes = new float[cols];
}

void draw(){
  background(0);
  float baseAmp = in.mix.level() * 400;
  t += 0.02;

  for(int x = 0; x < cols; x++){
    amplitudes[x] = lerp(amplitudes[x], baseAmp * (1 + sin(x * 0.1 + t)), 0.1);
    for(int y = 0; y < rows; y++){
      float angle = y * 0.1 + t;
      offsets[x][y] = amplitudes[x] * sin(angle);
      float xpos = x * spacing + offsets[x][y];
      float ypos = map(y, 0, rows, 0, height);
      
      float c = map(offsets[x][y], -baseAmp, baseAmp, 50, 255);
      stroke(c, 255, 255);
      point(xpos, ypos);
    }
  }
}
