color[] colors = new color[5];
float frame = 0;
float angle;
float radius;
float x;
float y;
float lerpFactor;
int num;
color c1;
color c2;
color c3;
color c4;
color c5;
float spiralFactor = 0.01;
int bgDraw = 0;

void setup() {
  size(800, 800);
  noStroke();
  generateRandomColors();
}

void draw() {
  if(bgDraw % 2 == 0 ) background(0);
  translate(width / 2, height / 2);
  for (int i = 1; i < 5185; i++) {
    angle = i * spiralFactor + frame;
    radius = sqrt(i) * 8;
    x = radius * cos(angle);
    y = radius * sin(angle);
    lerpFactor = abs(sin(frame + i * 0.01));
    num = (i / 200) % colors.length;
    c1 = colors[num];
    c2 = colors[(num + 1) % colors.length];
    fill(lerpColor(c1, c2, lerpFactor));
    ellipse(x, y, 10 + sin(frame + i * 0.01) * 5, 10 + cos(frame + i * 0.01) * 5);
  }
  frame += 0.01;
  spiralFactor += 0.0000001;
}

void keyPressed(){
  if(key == 'b') bgDraw++;
  if(key == 'g') generateRandomColors();
}

void generateRandomColors(){
  for (int i = 0; i < colors.length; i++) {
    colors[i] = color(random(255), random(255), random(255));
  }
}
