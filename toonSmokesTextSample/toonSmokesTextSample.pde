import ddf.minim.*;
Minim minim;
AudioInput in;

int bgDraw, textMove;
float t, u, angleOffset, radius, linearX, linearY, circularX, circularY, x, y, 
amplitude, timeFactor, transformFactor;
String text = "Toon Smokes";
PFont font; 
  
void setup() {
  size(800, 800);
  minim = new Minim(this);
  in = minim.getLineIn();
  font = createFont("Webdings", 64);
  textFont(font);
  textAlign(CENTER, CENTER);
  colorMode(HSB);
  smooth();
  String[] fonts = PFont.list();
  for (int i = 0; i < fonts.length; i++) {
    println(fonts[i]);
  }
}

void draw() {
  if (bgDraw % 2 == 0) background(0);
  translate(width / 2, height / 2);
  amplitude = in.mix.level() * 87;
  timeFactor = millis() * 0.0005;
  transformFactor = constrain(t / 10.0, 0, 1); 
  for (int i = 0; i < 8; i++) {
    pushMatrix();
    rotate(TWO_PI * i / 8 * transformFactor + timeFactor * transformFactor);
    for (int j = 0; j < text.length(); j++) {
      angleOffset = sin(t + j * 0.5) * 0.5 * transformFactor;
      radius = 150 * transformFactor + sin(t + j * 0.8) * 50 * transformFactor + amplitude;
      linearX = (j - text.length() / 2) * 50;
      linearY = 0;//(j - text.length() / 2) * 50;
      circularX = cos(j * 0.3 + angleOffset) * radius;
      circularY = sin(j * 0.3 + angleOffset) * radius;
      x = lerp(linearX, circularX, transformFactor);
      float y = lerp(linearY, circularY, transformFactor);
      fill(lerpColor(color(255, 0, 255), color(0, 255, 255), (sin(t + j * 0.5) + 1) / 2));
      textSize(48 + sin(t + j * 0.7) * 10 * transformFactor + amplitude / 10);
      text(text.charAt(j), x, y);
    }
    popMatrix();
  }
  if(textMove % 2 == 1) t += 0.01;
  u += 0.01;
}

void keyPressed() {
  if (key == ' ') bgDraw++;
  if (key == 'b') textMove++;
}
