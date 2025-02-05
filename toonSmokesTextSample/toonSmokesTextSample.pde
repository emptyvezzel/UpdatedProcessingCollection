import ddf.minim.*;
Minim minim;
AudioInput in;
int textCount = -1;
int bgDraw, textMove, arms, sensitivity;
float t, u, angleOffset, radius, linearX, linearY, circularX, circularY, x, y,
  amplitude, timeFactor, transformFactor, soundVar;
String text = "Toon Smokes";
PFont[] letterFonts;
boolean[] flippedLetters;
String[] fontNames = PFont.list();
PFont[] fonts = new PFont[fontNames.length];
color[] palette;
int[] currentColorIndex;
int[] nextColorIndex;
float[] colorLerpAmount;

void setup() {
  size(2000, 1200);
  minim = new Minim(this);
  in = minim.getLineIn();
  newText();
  colorMode(HSB);
  newPalette();
  textAlign(CENTER, CENTER);
  smooth();
}

void draw() {
  sensitivity = 500;
  if(bgDraw % 2 == 0) background(0);
  translate(width / 2, height / 2);
  amplitude = in.mix.level() * 87;
  timeFactor = millis() * 0.0005;
  transformFactor = constrain(t / 10.0, 0, 1);
  arms = 38;
  for(int i = 0; i < 1; i++){
    pushMatrix();
    rotate(TWO_PI * i / 8 * transformFactor + timeFactor * transformFactor);
    for(int j = 0; j < text.length(); j++){
      if(frameCount % 10 == 0) {
        if(random(100) > 90) {
          letterFonts[j] = fonts[(int)random(fonts.length)];
          flippedLetters[j] = false;
        }
        if(random(1000) > 995) flippedLetters[j] = !flippedLetters[j];
      }
      colorLerpAmount[j] += 0.0050;
      if (colorLerpAmount[j] >= 1.0) {
        currentColorIndex[j] = nextColorIndex[j];
        nextColorIndex[j] = (int)random(palette.length);
        colorLerpAmount[j] = 0.0;
      }
      textFont(letterFonts[j]);
      soundVar = in.left.get(i) * sensitivity;
      angleOffset = sin(t + j * 0.5) * 0.5 * transformFactor;
      radius = 150 * transformFactor + sin(t + j * 0.8) * 50 *
        transformFactor + soundVar;
      linearX = (j - text.length() / 2) * 179;
      linearY = 0;
      circularX = cos(j * 0.3 + angleOffset) * radius;
      circularY = sin(j * 0.3 + angleOffset) * radius;
      x = lerp(linearX, circularX, transformFactor);
      y = lerp(linearY, circularY, transformFactor);
      fill(lerpColor(palette[currentColorIndex[j]], palette[nextColorIndex[j]], colorLerpAmount[j]));
      textSize(298 + sin(t + j * 0.7) * 10 * transformFactor + amplitude / 10 +
        abs(soundVar / 5));
      pushMatrix();
      translate(x, y);
      if(flippedLetters[j])scale(-1, 1);
      text(text.charAt(j), 0, 0);
      popMatrix();
    }
    popMatrix();
  }
  if (textMove % 2 == 1) t += 0.01;
  println(frameRate);
}

void keyPressed() {
  if(key == ' ') bgDraw++;
  if(key == 'b') textMove++;
  if(key == 'd') {
    bgDraw = 0;
    textMove = 0;
    t = 0;
  }
  if (key == 't') newText();
  if (key == 'c') newPalette();
}

void newText() {
  textCount++;
  if(textCount % 3 == 0) text = "Toon Smokes";
  if(textCount % 3 == 1) text = "Elmer Fudd";
  if(textCount % 3 == 2) text = "It Hit";
  for(int i = 0; i < fontNames.length; i++){
    fonts[i] = createFont(fontNames[i], 64);
  }
  letterFonts = new PFont[text.length()];
  flippedLetters = new boolean[text.length()];
  currentColorIndex = new int[text.length()];
  nextColorIndex = new int[text.length()];
  colorLerpAmount = new float[text.length()];
  for(int i = 0; i < text.length(); i++){
    letterFonts[i] = fonts[(int)random(fonts.length)];
    flippedLetters[i] = false;
    currentColorIndex[i] = (int)random(5);
    nextColorIndex[i] = (int)random(5);
    colorLerpAmount[i] = random(1.0);
  }
}

void newPalette() {
  palette = new color[5];
  for (int i = 0; i < 5; i++) {
    palette[i] = color(random(255), 255, 255);
  }
}
