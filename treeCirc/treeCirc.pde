float t = 0; //just an animation factor
float s = 0; //just an animation factor
int rec = 9; // numbers of recursions

void setup() {
  size(800, 800);
  //fullScreen();
  frameRate(200);
  background(0);
}

void draw() {
  //stroke(255); 
  fill(255, 50);
  rect(0, 0, width, height);
  if (!mousePressed) {
    s += 0.01;
    t = sin(s)*2;
  }
  Branch b = new Branch();
  b.angle_ = HALF_PI;
  b.x_ = width/2.0; 
  b.y_ = height/ 2.0; 
  b.length_ = 130; 
  makeTree(rec, b);
}

void makeTree( int recursion_depth, Branch b_) {
  int index = 0;
  Branch b[] = new Branch[2];
  b[index] = new Branch();
  b[index].angle_  = b_.angle_ + radians( mouseX/2.0 - t*12);
  b[index].x_      = b_.x_ + b_.length_ * cos( b[index].angle_ ) ;
  b[index].y_      = b_.y_ + b_.length_ * sin( b[index].angle_) ;
  b[index].length_ = b_.length_;
  b[index].length_fac_ = .7;
  b[index].manageLength();

  index++;
  b[index] = new Branch();
  b[index].angle_  = b_.angle_ + radians( mouseY/2.0 + t*6) ;
  b[index].x_      = b_.x_ + b_.length_ * cos( b[index].angle_ ) ; 
  b[index].y_      = b_.y_ + b_.length_ * sin( b[index].angle_ ) ;
  b[index].length_ = b_.length_;
  b[index].length_fac_ = .7;
  b[index].manageLength();

  float col_f = map(mouseX, 0, width, 0, 255);
  float col_r = 0 + recursion_depth * ( (255-col_f) / (rec + 3 ));
  float col_g = 0 + recursion_depth * ( map( b[0].x_, 0, width, 0, 255) / (rec + 3 ) ) ;
  float col_b = 0 + recursion_depth * ( (col_f)  / (rec + 3) );

  stroke( col_r, col_g, col_b );
  strokeWeight( recursion_depth/1.8);
  for (int i = 0; i < b.length; i++) line( b_.x_, b_.y_, b[i].x_, b[i].y_);
  if (recursion_depth-- > 0) for (int i = 0; i < b.length; i++) makeTree( recursion_depth, b[i] );
}

class Branch {
  float x_, y_, angle_, length_;
  float length_fac_ = .7;
  void manageLength() {
    length_ *= length_fac_;
  }
}
