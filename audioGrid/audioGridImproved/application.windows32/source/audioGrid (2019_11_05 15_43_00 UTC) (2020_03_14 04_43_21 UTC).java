import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class audioGrid extends PApplet {


Minim minim;
AudioInput in;
int variableInt;

public void setup() {
  
  minim = new Minim(this);
  in = minim.getLineIn();
}

public void draw() {
  variableInt = 50;
  background(0);
  stroke(255);
  for (int j = 0; j < 500 - variableInt; j+=variableInt) {
    for (int i = 0; i < in.bufferSize() - 1; i++) {
      line(i, variableInt + j + in.left.get(i)*50, i+1, variableInt + j + in.left.get(i+1)*50);
      line(variableInt + j + in.left.get(i)*50, i, variableInt + j + in.left.get(i+1)*50, i+1);
    }
  }
}
  public void settings() {  size(500, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "audioGrid" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
