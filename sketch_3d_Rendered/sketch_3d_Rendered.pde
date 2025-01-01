import controlP5.*;

ControlP5 cp5;

boolean autoRotation = true; 
PVector[] points = new PVector[8]; // Points/verices of the cube
float X_Axis_Rotation_Multiplier = 1; // X-Axis Rotation Multiplier in degrees
float Y_Axis_Rotation_Multiplier = 1; // X-Axis Rotation Multiplier in degrees
float Z_Axis_Rotation_Multiplier = 1; // X-Axis Rotation Multiplier in degrees
float thetaX = 0, thetaY = 0, thetaZ = 0; // Angle of rotation in radians (rad)
float Rotation_Delay = 10, fps = frameRate; // Rotation delay in milliseconds
int size = 150, ratio = 4, FOV = size * ratio; // Size of the cube and FOV of the camera
int currentTime, previousTime = 0, previousTimeFPS = 0; // Time variables for calclulating delay and displaying FPS

String[] textfieldNames = {"X_Axis_Rotation_Multiplier", "Y_Axis_Rotation_Multiplier", "Z_Axis_Rotation_Multiplier"}; // Input feild names

void setup() {
  //size(128, 160);
  size(850, 850);
  frameRate(1000);
  points[0] = new PVector(-size, -size, -size);
  points[1] = new PVector(size, -size, -size);
  points[2] = new PVector(size, size, -size);
  points[3] = new PVector(-size, size, -size);
  points[4] = new PVector(-size, -size, size);
  points[5] = new PVector(size, -size, size);
  points[6] = new PVector(size, size, size);
  points[7] = new PVector(-size, size, size);
  
  cp5 = new ControlP5(this);
  int x = 20, y = height / 40;
  int spacing = (width - 160) / 4;

  for(String name: textfieldNames){
    cp5.addNumberbox(name)
       .setPosition(x, y)
       .setSize(60, 30)
       .setMultiplier(1)
       .setValue(1)
       .setRange(-360, 360);
     x += spacing;
  }
  cp5.addNumberbox("Rotation_Delay")
       .setPosition(x, y)
       .setSize(60, 30)
       .setMultiplier(10)
       .setValue(10)
       .setRange(0, 1000);
}

void draw() {
  currentTime = millis();
  
  background(0);
  if(currentTime - previousTimeFPS >= 200) {
    fps = frameRate;
     previousTimeFPS = currentTime;
  }
  if (autoRotation && currentTime - previousTime >= Rotation_Delay) {
    thetaX += radian(X_Axis_Rotation_Multiplier);
    thetaY += radian(Y_Axis_Rotation_Multiplier);
    thetaZ += radian(Z_Axis_Rotation_Multiplier);
    
    previousTime = millis();
  }
  drawCube();
  drawText();
}

void keyPressed() {
  if (key == 'w' || key == 'W') 
    thetaX -= radian(X_Axis_Rotation_Multiplier);
  if (key == 's' || key == 'S')
    thetaX += radian(X_Axis_Rotation_Multiplier);
  if (key == 'a' || key == 'A')
    thetaY += radian(Y_Axis_Rotation_Multiplier);
  if (key == 'd' || key == 'D')
    thetaY -= radian(Y_Axis_Rotation_Multiplier);
  if (key == 'q' || key == 'Q')
    thetaZ -= radian(Z_Axis_Rotation_Multiplier);
  if (key == 'e' || key == 'E')
    thetaZ += radian(Z_Axis_Rotation_Multiplier);
  if (key == 't' || key == 'T' || key == ' ')
    autoRotation = !autoRotation;
  if (key == 'r' || key == 'R') {
    thetaX = 0;
    thetaY = 0;
    thetaZ = 0;
  }
}

void drawText() {
  noStroke();
  textSize(25);
  text("FPS: " + format(fps), width * 5 / 6, height / 20);
  
  int gap = 22, labelWidth = 125;
  int xPos = height * 39/40;
  float degX, degY, degZ, revX, revY, revZ;

  revX = revolutions(thetaX);
  revY = revolutions(thetaY);
  revZ = revolutions(thetaZ);

  fill(255, 0, 0);
  text("Rotation-X: ", gap, xPos);
  fill(255);
  text(formatP(revX), labelWidth + gap, xPos);
  fill(0, 255, 0);
  text("Rotation-Y: ", width * 1 / 3 + gap, xPos);
  fill(255);
  text(formatP(revY), width * 1 / 3 + labelWidth + gap, xPos);
  fill(0, 0, 255);
  text("Rotation-Z: ", width * 2 / 3 + gap, xPos);
  fill(255);
  text(formatP(revZ), width * 2 / 3 + labelWidth + gap, xPos);

  xPos -= 20;  
  degX = degree(thetaX);
  degY = degree(thetaY);
  degZ = degree(thetaZ);

  fill(255, 0, 0);
  text("Degree-X: ", gap, xPos);
  fill(255);
  text(formatP(degX) + " °", labelWidth + gap, xPos);
  fill(0, 255, 0);
  text("Degree-Y: ", width * 1 / 3 + gap, xPos);
  fill(255);
  text(formatP(degY) + " °", width * 1 / 3 + labelWidth + gap, xPos);
  fill(0, 0, 255);
  text("Degree-Z: ", width * 2 / 3 + gap, xPos);
  fill(255);
  text(formatP(degZ) + " °", width * 2 / 3 + labelWidth + gap, xPos);

  xPos -= 20;
  
  fill(255, 0, 0);
  text("Angle-X: ", gap, xPos);
  fill(255);
  text(formatP(thetaX) + " rad", labelWidth + gap, xPos);
  fill(0, 255, 0);
  text("Angle-Y: ", width * 1 / 3 + gap, xPos);
  fill(255);
  text(formatP(thetaY) + " rad", width * 1 / 3 + labelWidth + gap, xPos);
  fill(0, 0, 255);
  text("Angle-Z: ", width * 2 / 3 + gap, xPos);
  fill(255);
  text(formatP(thetaZ) + " rad", width * 2 / 3 + labelWidth + gap, xPos);
}
  
void drawCube() {
  noFill();
  stroke(255);
  strokeWeight(2);
  for (int i = 0; i < 4; i++) {
    PVector p1, p2, p3, p4;
    p1 = weakProjection(rotate(points[i])); 
    p2 = weakProjection(rotate(points[(i + 1) % 4]));
    p3 = weakProjection(rotate(points[i + 4]));
    p4 = weakProjection(rotate(points[((i + 1) % 4) + 4]));
    
    line(p1.x, p1.y, p2.x, p2.y);
    line(p3.x, p3.y, p4.x, p4.y);
    line(p1.x, p1.y, p3.x, p3.y);
  }
}

PVector rotate(PVector point) {
  PVector rotated = point;
  rotated = rotateX(rotated);
  rotated = rotateY(rotated);
  rotated = rotateZ(rotated);
  
  return rotated;
}

PVector rotateX(PVector point) {
  float X = point.x;
  float Y = point.y * cos(thetaX) - point.z * sin(thetaX);
  float Z = point.y * sin(thetaX) + point.z * cos(thetaX);
  
  return new PVector(X, Y, Z);
}

PVector rotateY(PVector point) {
  float X = point.x * cos(thetaY) + point.z * sin(thetaY) ;
  float Y = point.y;
  float Z = -point.x * sin(thetaY) + point.z * cos(thetaY);
  
  return new PVector(X, Y, Z);
}

PVector rotateZ(PVector point) {
  float X = point.x * cos(thetaZ) - point.y * sin(thetaZ);
  float Y = point.x * sin(thetaZ) + point.y * cos(thetaZ);
  float Z = point.z;
  
  return new PVector(X, Y, Z);
}

PVector weakProjection(PVector p3d) {
  float x = (width / 2) + (FOV * p3d.x) / (FOV + p3d.z); // (width / 2) to center horizontally  
  float y = (height / 2) + (FOV * p3d.y) / (FOV + p3d.z); // (height / 2) to center vertically
  return new PVector(x, y);
}

String format(float number) {
    float decimal = 2;
    float num = (float)(round((number*pow(10, decimal))))/pow(10, decimal);
    return str(num);
} 

String formatP(float number) {
    float decimal = 3;
    float num = (float)(round((number*pow(10, decimal))))/pow(10, decimal);
    return num >=0 ? "+" + str(num) : str(num);
} 

float radian(float degree) {
  return degree * PI / 180;
}
float degree(float radian) {
  return radian * 180 / PI;
}

float revolutions(float degree) {
  return degree / 360;
}