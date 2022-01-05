
boolean drawControlPoints;
PFont f;
void setup() {
  drawControlPoints = true;
  size(1280, 720, OPENGL); 
  f = loadFont("ProcessingSansPro-Regular-12.vlw");
  textFont(f);
}
class Marcher {
  PVector pos;
  float r;
  boolean z;
  
  float zOffset = 200.0f;
  void start(PVector _start, float _r) {
    pos = new PVector();
    pos.set(_start);
    r = _r;
    z = true;
  }
  void drawBezier(PVector _a, PVector _b, PVector _c, PVector _d) {
    noFill();
    stroke(0);
    bezier(_a.x, _a.y, _a.z, _b.x, _b.y, _b.z, _c.x, _c.y, _c.z, _d.x, _d.y, _d.z);
  }
  void drawControlPoints(PVector _a, PVector _b, PVector _c, PVector _d) {
    if (drawControlPoints) {
      noFill();
      stroke(255);
      line(_a.x, _a.y, _a.z, _b.x, _b.y, _b.z);
      line(_c.x, _c.y, _c.z, _d.x, _d.y, _d.z);

      noStroke();
      fill(0);
      point(_a.x, _a.y, _a.z);
      point(_b.x, _b.y, _b.z);
      point(_c.x, _c.y, _c.z);
      point(_d.x, _d.y, _d.z);

      text("a", _a.x, _a.y-36, _a.z);
      text("b", _b.x, _b.y-24, _b.z);
      text("c", _c.x, _c.y-12, _c.z);
      text("d", _d.x, _d.y, _d.z);
    }
  }


  void hardRight(int _turningRadius) {

    PVector a = new PVector(pos.x, pos.y, pos.z);
    PVector d = new PVector(pos.x, pos.y, (z ? zOffset : 0.0f));

    PVector b = new PVector();
    PVector c = new PVector();

    b.x = (a.x + cos(r)*_turningRadius*1.5f);
    b.y = (a.y + sin(r)*_turningRadius*1.5f);
    b.z = a.z;

    c.x = d.x - cos(r+PI*1.5f)*_turningRadius*1.5f;
    c.y = d.y - sin(r+PI*1.5f)*_turningRadius*1.5f;
    c.z = d.z;

    drawBezier(a, b, c, d);
    drawControlPoints(a, b, c, d);

    pos.set(d);

    r+= PI*1.5f;
    z = !z;
  }

  void hardLeft(int _turningRadius) {

    PVector a = new PVector(pos.x, pos.y, pos.z);
    PVector d = new PVector(pos.x, pos.y, (z ? zOffset : 0.0f));

    PVector b = new PVector();
    PVector c = new PVector();

    b.x = (a.x + cos(r)*_turningRadius*1.5f);
    b.y = (a.y + sin(r)*_turningRadius*1.5f);
    b.z = a.z;

    c.x = d.x + cos(r+PI*1.5f)*_turningRadius*1.5f;
    c.y = d.y + sin(r+PI*1.5f)*_turningRadius*1.5f;
    c.z = d.z;

    drawBezier(a, b, c, d);
    drawControlPoints(a, b, c, d);

    pos.set(d);

    r-= PI*1.5f;
    z = !z;
  }

  void left(int _turningRadius) {

    PVector a = new PVector(pos.x, pos.y, pos.z);
    PVector d = new PVector(pos.x + cos(r-PI/2.0f)*(float)_turningRadius, pos.y+sin(r-PI/2.0f)*(float)_turningRadius, (z ? zOffset : 0.0f));

    PVector b = new PVector();
    PVector c = new PVector();

    b.x = (a.x + cos(r)*_turningRadius);
    b.y = (a.y + sin(r)*_turningRadius);
    b.z = a.z;

    c.x = d.x - cos(r+PI)*_turningRadius;
    c.y = d.y - sin(r+PI)*_turningRadius;
    c.z = d.z;

    drawBezier(a, b, c, d);
    drawControlPoints(a, b, c, d);

    pos.set(d);

    r+= PI;
    z = !z;
  }


  void right(int _turningRadius) {

    PVector a = new PVector(pos.x, pos.y, pos.z);
    PVector d = new PVector(pos.x + cos(r+PI/2.0f)*(float)_turningRadius, pos.y+sin(r+PI/2.0f)*(float)_turningRadius, (z ? zOffset : 0.0f));

    PVector b = new PVector();
    PVector c = new PVector();

    b.x = (a.x + cos(r)*_turningRadius);
    b.y = (a.y + sin(r)*_turningRadius);
    b.z = a.z;

    c.x = d.x - cos(r+PI)*_turningRadius;
    c.y = d.y - sin(r+PI)*_turningRadius;
    c.z = d.z;

    drawBezier(a, b, c, d);
    drawControlPoints(a, b, c, d);
    pos.set(d);

    r+= PI;
    z = !z;
  }
  void straight(int _l) {

    PVector a = new PVector(pos.x, pos.y, pos.z);
    PVector d = new PVector(pos.x + cos(r)*(float)_l, pos.y+sin(r)*(float)_l, (z ? zOffset : 0.0f));

    PVector b = new PVector();
    PVector c = new PVector();

    b.set(d);
    c.set(d);

    b = ((b.sub(a)).div(3.0f)).add(a);
    b.z = a.z;
    c = ((c.sub(a)).div(3.0f).mult(2.0f)).add(a);
    c.z = d.z;

    drawBezier(a, b, c, d);
    drawControlPoints(a, b, c, d);

    pos.set(d);

    z = !z;
  }
};

void draw() {
  background(128);
  Marcher m = new Marcher();


  PVector start = new PVector(-100, -100, 0);
  float r = 0;
  pushMatrix();
  translate(width/2, height/2);
  rotateX((float)mouseY/100.0f);
  rotateY((float)mouseX/200.0f);

  m.start(start, 0);

  m.straight(100);
m.straight(100);

  m.right(100);

  m.straight(100);
  m.straight(100);


  m.left(100);



  m.straight(100);
  m.straight(100);

  m.hardRight(100);

  m.straight(100);
  m.straight(100);

  m.left(100);

  m.straight(100);
  m.straight(100);

  m.right(100);

  m.straight(100);
  m.straight(100);

  m.hardLeft(100);
  popMatrix();
}

void mousePressed(){
  drawControlPoints = !drawControlPoints;
}
