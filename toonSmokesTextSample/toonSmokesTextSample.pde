import ddf.minim.*;

Minim minim;
AudioInput in;

int bgDraw;
String text = "Toon Smokes";
float t = 0;
PFont font;

void setup() {
  size(800, 800);
  minim = new Minim(this);
  in = minim.getLineIn();
  font = createFont("Arial", 64);
  textFont(font);
  textAlign(CENTER, CENTER);
  smooth();
}

void draw() {
  if(bgDraw % 2 == 0) background(0);
  translate(width / 2, height / 2);

  float amplitude = in.mix.level() * 87;
  float timeFactor = millis() * 0.0005;
  
  for (int i = 0; i < 8; i++) {
    pushMatrix();
    rotate(TWO_PI * i / 8 + timeFactor);

    for (int j = 0; j < text.length(); j++) {
      float angleOffset = sin(t + j * 0.5) * 0.5;
      float radius = 150 + sin(t + j * 0.8) * 50 + amplitude;

      float x = cos(j * 0.3 + angleOffset) * radius;
      float y = sin(j * 0.3 + angleOffset) * radius;

      fill(lerpColor(color(255, 0, 255), color(0, 255, 255), (sin(t + j * 0.5) + 1) / 2));
      textSize(48 + sin(t + j * 0.7) * 10 + amplitude / 10);
      text(text.charAt(j), x, y);
    }
    popMatrix();
  }
  t += 0.02;
}

void keyPressed() {
  if (key == ' ') bgDraw++;
}

void stop() {
  in.close();
  minim.stop();
  super.stop();
}
