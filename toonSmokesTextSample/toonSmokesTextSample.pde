import ddf.minim.*;
Minim minim;
AudioInput in;
int textCount = -1;
int bgDraw, textMove, arms, sensitivity, textNum, tex;
float t, u, angleOffset, radius, linearX, linearY, circularX, circularY, x, y, amplitude, timeFactor, transformFactor, soundVar;
String[] text = {"Toon Smokes", "Elmer Fudd", "It Hit", "Perdition", "Seersucker"};
PFont[] letterFonts, fonts;
boolean[] flippedLetters, isSpecialChar;
color[] palette;
int[] currentColorIndex, nextColorIndex;
float[] colorLerpAmount;
char[] currentChars;
char[] specialChars = {
  '◊',  '●',  '∆', '∏', '∑', '−', '±', '×', '÷', '√', '∞',  '≠', '≤', '≥', '¡', '§', 
  '¶', '•', '¤', '¦', '©', '®', '™', '‡', '†', '∞', '≈', '≠', 'µ', 'Ω', 'π', '∂', '♪',
  '&', '@', 'æ', 'Þ', '«', '~', '¾', 'ʑ', 'ϕ'
};

void setup() {
  fullScreen();
  minim = new Minim(this);
  in = minim.getLineIn();
  filterFonts();
  textNum = 0;
  newText();
  colorMode(HSB);
  newPalette();
  textAlign(CENTER, CENTER);
  smooth();
}

void draw() {
  tex = ((textNum % text.length) + text.length) % text.length; 
  sensitivity = 500;
  if(bgDraw % 2 == 0) background(0);
  translate(width / 2, height / 2);
  amplitude = in.mix.level() * 87;
  timeFactor = millis() * 0.0005;
  transformFactor = constrain(t / 10.0, 0, 1);
  arms = 38;

  for(int i = 0; i < 6; i++){
    pushMatrix();
    rotate(TWO_PI * i / 8 * transformFactor + timeFactor * transformFactor);
    
    for(int j = 0; j < text[tex].length(); j++){
      char currentChar = text[tex].charAt(j);
      
      if (letterFonts == null || letterFonts.length <= j || letterFonts[j] == null) {
        letterFonts[j] = getRandomFont(currentChar);
      }

      if (flippedLetters == null || flippedLetters.length <= j) {
        flippedLetters = new boolean[text[tex].length()];
      }

      if (isSpecialChar == null || isSpecialChar.length <= j) {
        isSpecialChar = new boolean[text[tex].length()];
      }

      if(frameCount % 20 == 0) {
        if(random(100) > 90) {
          letterFonts[j] = getRandomFont(currentChar);
          flippedLetters[j] = false;
          isSpecialChar[j] = false;
        }
        if(random(1000) > 995) flippedLetters[j] = !flippedLetters[j];
      }

      if (!isSpecialChar[j] && random(10000) < (currentChar == ' ' ? 20 : 1)) {
        currentChars[j] = specialChars[(int)random(specialChars.length)];
        isSpecialChar[j] = true;
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
      radius = 150 * transformFactor + sin(t + j * 0.8) * 50 * transformFactor + soundVar;
      linearX = (j - text[tex].length() / 2) * 179;
      linearY = 0;
      circularX = cos(j * 0.3 + angleOffset) * radius;
      circularY = sin(j * 0.3 + angleOffset) * radius;
      x = lerp(linearX, circularX, transformFactor);
      y = lerp(linearY, circularY, transformFactor);

      fill(lerpColor(palette[currentColorIndex[j]], palette[nextColorIndex[j]], colorLerpAmount[j]));
      textSize(298 + sin(t + j * 0.7) * 10 * transformFactor + amplitude / 10 + abs(soundVar / 5));
      
      pushMatrix();
      translate(x, y);
      if(flippedLetters[j]) scale(-1, 1);
      char c = isSpecialChar[j] ? currentChars[j] : text[tex].charAt(j);
      text(c, 0, -height/2+i*220);
      popMatrix();
    }
    popMatrix();
  }

  if (textMove % 2 == 1) t += 0.01;
}

void keyPressed() {
  if(key == ' ') bgDraw++;
  if(key == 'b') textMove++;
  if(key == 'd') {
    bgDraw = 0;
    textMove = 0;
    t = 0;
  }
  if (key == 't') {
    textNum++;
    newText();
  }
  if (key == 'g') {
    textNum--;
    newText();
  }
  if (key == 'c') newPalette();
}

void newText() {
  tex = ((textNum % text.length) + text.length) % text.length;
  int textLength = text[tex].length();  

  letterFonts = new PFont[textLength];
  flippedLetters = new boolean[textLength];
  currentColorIndex = new int[textLength];
  nextColorIndex = new int[textLength];
  colorLerpAmount = new float[textLength];
  currentChars = new char[textLength];
  isSpecialChar = new boolean[textLength];

  for(int i = 0; i < textLength; i++){
    letterFonts[i] = getRandomFont(text[tex].charAt(i));
    flippedLetters[i] = false;
    currentColorIndex[i] = (int)random(5);
    nextColorIndex[i] = (int)random(5);
    colorLerpAmount[i] = random(1.0);
    currentChars[i] = text[tex].charAt(i);
    isSpecialChar[i] = false;
  }
}

void newPalette() {
  palette = new color[5];
  for (int i = 0; i < 5; i++) {
    palette[i] = color(random(255), 81, 241);
  }
}

void filterFonts() {
  String[] nonoFonts = {
    "Bahnschrift Bold", "Bahnschrift Bold Condensed", "Bahnschrift Bold SemiCondensed",
    "Bahnschrift Condensed", "Bahnschrift Light", "Bahnschrift Light Condensed",
    "Bahnschrift Light SemiCondensed", "Bahnschrift Regular", "Bahnschrift SemiBold",
    "Bahnschrift SemiBold Condensed", "Bahnschrift SemiBold SemiCondensed",
    "Bahnschrift SemiCondensed", "Bahnschrift SemiLight", "Bahnschrift SemiLight Condensed",
    "Bahnschrift SemiLight SemiCondensed", "BR Face J1", "BR Face J2", "BR Face J3", "BR Face J4",
    "BR-OCRB", "HoloLens MDL2 Assets", "Marlett", "PT Dingbats 1", "PT Dingbats 2",
    "PT Symbol 1", "PT Symbol 2", "Segoe MDL2 Assets", "Symbol", "Webdings", "Wingdings"
  };
  String[] fontNames = PFont.list();
  ArrayList<PFont> filteredFonts = new ArrayList<PFont>();

  for (String fontName : fontNames) {
    String normalizedFontName = fontName.trim();
    boolean isNono = false;
    for (String nono : nonoFonts) {
      if (normalizedFontName.equalsIgnoreCase(nono.trim())) {
        isNono = true;
        break;
      }
    }
    if (!isNono) {
      filteredFonts.add(createFont(normalizedFontName, 64));
      if (normalizedFontName.equals("PT Dingbats 3") || normalizedFontName.equals("PT Dingbats 4")) {
        for (int i = 0; i < 4; i++) {
          filteredFonts.add(createFont(normalizedFontName, 64));
        }
      }
    }
  }
  fonts = filteredFonts.toArray(new PFont[0]);
}

PFont getRandomFont(char c) {
  ArrayList<PFont> allowedFonts = new ArrayList<PFont>();
  for (PFont font : fonts) {
    String fontName = font.getName();
    if (c != ' ' || (!fontName.equals("PT Dingbats 3") && !fontName.equals("PT Dingbats 4"))) {
      allowedFonts.add(font);
    }
  }
  return allowedFonts.get((int)random(allowedFonts.size()));
}
