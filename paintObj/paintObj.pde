int numShapes = 40;
color[] palette;
int[][] shapeParams;
float[][][] shapeVertices;
int x, y, w, h, points;
color c;
float angle, px, py;

void setup(){
  size(1500, 1000);
  palette = new color[]{
    #3D6999, #D84343, #E0C87B, #227D3E, #7DC3B2, #C0322E, #F27E5E, #7E5E9A, #3B3A36, #F2E8D5
  };
  shapeParams = new int[numShapes][6];
  shapeVertices = new float[numShapes][][];
  for(int i = 0; i < numShapes; i++) initializeShape(i);
  frameRate(60);
}

void draw(){
  background(#ECE4DA);
  for(int i = 0; i < numShapes; i++){
    if(random(100) < 1) initializeShape(i);
    drawAbstractShape(i);
  }
}

void initializeShape(int i){
  shapeParams[i][0] = int(random(width));
  shapeParams[i][1] = int(random(height));
  shapeParams[i][2] = int(random(100, 300));
  shapeParams[i][3] = int(random(100, 300));
  shapeParams[i][4] = int(random(4, 10));
  shapeParams[i][5] = int(random(palette.length));
  
  int numPoints = shapeParams[i][4];
  shapeVertices[i] = new float[numPoints][2];
  for(int j = 0; j < numPoints; j++){
    float angle = map(j, 0, numPoints, 0, TWO_PI) + random(-0.5, 0.5);
    shapeVertices[i][j][0] = shapeParams[i][0] + cos(angle) * shapeParams[i][2] * random(0.5, 1.0);
    shapeVertices[i][j][1] = shapeParams[i][1] + sin(angle) * shapeParams[i][3] * random(0.5, 1.0);
  }
}

void drawAbstractShape(int i){
  x = shapeParams[i][0];
  y = shapeParams[i][1];
  w = shapeParams[i][2];
  h = shapeParams[i][3];
  points = shapeParams[i][4];
  c = palette[shapeParams[i][5]];
  
  fill(c);
  noStroke();
  beginShape();
  for(int j = 0; j < points; j++){
    vertex(shapeVertices[i][j][0], shapeVertices[i][j][1]);
  }
  endShape(CLOSE);
}
