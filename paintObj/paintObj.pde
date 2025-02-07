int numShapes = 20;
color[] palette;

void setup(){
  size(800,800);
  palette = new color[]{
    #3D6999, #D84343, #E0C87B, #227D3E, #7DC3B2, #C0322E, #F27E5E, #7E5E9A, #3B3A36, #F2E8D5
  };
  noLoop();
}

void draw(){
  background(#ECE4DA);
  for(int i = 0; i < numShapes; i++){
    drawAbstractShape();
  }
}

void drawAbstractShape(){
  int x = int(random(width));
  int y = int(random(height));
  int w = int(random(100, 300));
  int h = int(random(100, 300));
  int points = int(random(4, 10));
  color c = palette[int(random(palette.length))];
  fill(c);
  noStroke();
  beginShape();
  for(int i = 0; i < points; i++){
    float angle = map(i, 0, points, 0, TWO_PI) + random(-0.5, 0.5);
    float px = x + cos(angle) * w * random(0.5, 1.0);
    float py = y + sin(angle) * h * random(0.5, 1.0);
    vertex(px, py);
  }
  endShape(CLOSE);
}
