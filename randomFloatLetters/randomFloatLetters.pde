//String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}\\|;:'\",.<>/?";
String chars = "~÷¶µ¦¢»¬®Øæ¤ð¸§°¨þ╬";//┌
int numGlyphs = 3000;
int variability = 200;
Glyph[] glyphs = new Glyph[numGlyphs];

void setup() {
  //size(800, 800);
  fullScreen();
  textSize(24);
  textAlign(CENTER, CENTER);
  for (int i = 0; i < numGlyphs; i++) {
    glyphs[i] = new Glyph();
  }
}

void draw() {
  background(0);
  variability = 600;
  for (int i = 0; i < numGlyphs; i++) {
    glyphs[i].update();
    glyphs[i].display();
  }
}

class Glyph {
  float x, y, angle;
  float speed;
  float radians;
  char character;
  float size;
  boolean isChanging;
  color glyphCol;
  int frame;

  Glyph() {
    radians = random(0, 360);
    frame = (int) random(0, 100);
    glyphCol = color(random(0, 255), random(0, 255), random(0, 255));
    x = random(-variability, width+variability);
    y = random(-variability, height+variability);
    angle = random(TWO_PI);
    speed = random(1, 4);
    size = random(24, 48);
    character = chars.charAt((int)random(chars.length()));
    isChanging = false;
  }

  void update() {
    x += cos(angle) * speed;
    y += sin(angle) * speed;
    angle += random(-0.1, 0.1);
    if (x < 0 - variability || x > width + variability) {
      x = (x + width) % width;
    }
    if (y < 0 - variability || y > height + variability) {
      y = (y + height) % height;
    }
    if (frame % 60 == 0) {
      isChanging = true;
    } else {
      isChanging = false;
    }
    if (isChanging) {
      character = chars.charAt((int)random(chars.length()));
    }
    frame++;
  }

  void display() {
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians);
    translate(-width/2, -height/2);
    fill(glyphCol);
    textSize(size);
    text(character, x, y);
    popMatrix();
  }
}
