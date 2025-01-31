int backTrue = 0;
int size = 1;
int spread = 5;
int colorAmount = 5;
float counter = 0;
float scale = 5; 
float range;
float n;
float scroll = 1;
float colVal;
float changeVar = 0;
float lerpInc = 0.00;
float rangeUp = 0;
float scrollRange = 0;
float rangeRange = 0;
ArrayList cols = new ArrayList();
import ddf.minim.*;
Minim minim;
AudioInput in;
int sensitivity;

void setup() {
  //colorMode(HSB);
  size(1800, 1000);
  //fullScreen();
  cols.add(#F04248);
  cols.add(#FFADBA);
  cols.add(#FFFF31);
  cols.add(#3A86FF);
  cols.add(#269464);
  println(cols.size());
  range = width/scale;
  minim = new Minim(this);
  in = minim.getLineIn();
  changeDirection();
  //generateNewPallet();
}

void draw() {
  changeVar += 0.001; //* cols.size();
  rangeUp += rangeRange;
  if (backTrue % 2 == 0) background(0);
  sensitivity = 200;
  scale = 4;
  scroll -= scrollRange;
  if (scale < 3) scale = 3;
  range = width/scale/2;
  counter += 0.000;
  scale(scale);
  size = 2;
  lerpInc += 0.050;
  if (lerpInc > 1)lerpInc = 0;
  for (float i =- range; i < range; i++) {
    for (float j =- range; j < range; j++) {
      n = noise(i/range-rangeUp, j/range+scroll, mag(j, i)/range+counter);
      n = int(abs(n-0.5)*100);
      //colVal = n*changeVar%spread;
      colVal = n*changeVar%cols.size(); //no change pls :))
      lerpInc = n*changeVar%1; //no change pls :))
      for(int k = 0; k < cols.size()-1; k++){
        if (colVal > k && colVal < k+1) fill(lerpColor((int) cols.get(k), (int) cols.get(k+1), lerpInc));
      }
      if (colVal > cols.size()-1) fill(lerpColor((int) cols.get(cols.size()-1), (int) cols.get(0), lerpInc));
      //if (colVal > 0 && colVal < 1) fill(lerpColor(c0, c1, lerpInc));
      //if (colVal > 1 && colVal < 2) fill(lerpColor(c1, c2, lerpInc));
      //if (colVal > 2 && colVal < 3) fill(lerpColor(c2, c3, lerpInc));
      //if (colVal > 3 && colVal < 4) fill(lerpColor(c3, c4, lerpInc));
      //if (colVal > 4) fill(lerpColor(c4, c0, lerpInc));
      noStroke();
      float floatReturn = n % 3.00;
      if (floatReturn >= 0 && floatReturn <= 1) rect(j + range, i + range, size, size
      + in.left.get(abs(round(j*i)%1024))*sensitivity);
    }
  }
}

void keyPressed() {
  if (key == ' ') backTrue++;
  if (key == 'c') generateNewPallet();
  if (key == 'v') changeDirection();
  if (key == 'b') {
    generateNewPallet();
    changeDirection();
  }
}

void generateNewPallet() {
  cols.clear();
  colorAmount = 2;
  for(int i = 0; i < colorAmount; i++){
    cols.add(color(random(0, 255), random(0, 255), random(0, 255)));
  }
}

void changeDirection(){
  rangeRange = random(-0.03, 0.03);
  scrollRange = random(-0.03, 0.03);
}
