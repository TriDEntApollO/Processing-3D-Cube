import controlP5.*;

ControlP5 cp5;

boolean autoRotation = true; 
PVector[] points = new PVector[8];
float X_axis_Rotation_Rate = 0.01;
float Y_axis_Rotation_Rate = 0.01;
float Z_axis_Rotation_Rate = 0.01;
float delay = 0.01, fps = frameRate;
float thetaX = 0, thetaY = 0, thetaZ = 0;
int size = 150, ratio = 4, FOV = size * ratio;
int currentTime, previousTime = 0, previousTimeFPS = 0,intervalTime = 1000;

String[] textfieldNames = {"X_axis_Rotation_Rate", "Y_axis_Rotation_Rate", "Z_axis_Rotation_Rate"};

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
  int x = 20;
  int spacing = (width - 160) / 3;
  for(String name: textfieldNames){
    cp5.addNumberbox(name)
       .setPosition(x,20)
       .setSize(60, 30)
       .setMultiplier(0.01)
       .setValue(0.01);
     x += spacing;
  }
}

void draw() {
  currentTime = millis();
  
  background(0);
  if(currentTime - previousTimeFPS >= 200) {
    fps = frameRate;
     previousTimeFPS = currentTime;
  }
  if (autoRotation && currentTime - previousTime >= intervalTime * delay) {
    thetaX += 1 * X_axis_Rotation_Rate;
    thetaY += 1 * Y_axis_Rotation_Rate;
    thetaZ += 1 * Z_axis_Rotation_Rate;
    
    previousTime = millis();
  }
  drawCube();
  drawText();
}

void keyPressed() {
  if (key == 'w' || key == 'W') 
    thetaX -= 1 * X_axis_Rotation_Rate;
  if (key == 's' || key == 'S')
    thetaX += 1 * X_axis_Rotation_Rate;
  if (key == 'a' || key == 'A')
    thetaY += 1 * Y_axis_Rotation_Rate;
  if (key == 'd' || key == 'D')
    thetaY -= 1 * Y_axis_Rotation_Rate;
  if (key == 'q' || key == 'Q')
    thetaZ -= 1 * Z_axis_Rotation_Rate;
  if (key == 'e' || key == 'E')
    thetaZ += 1 * Z_axis_Rotation_Rate;
  if (key == 't' || key == 'T')
    autoRotation = !autoRotation;
  if (key == 'r' || key == 'R') {
    thetaX = 0;
    thetaY = 0;
    thetaZ = 0;
  }
}

void drawText() {
  noStroke();
  textSize(40);
  text("FPS: " + format(fps), width-200, 50);
 
  fill(255, 0, 0);
  text("Angle-X: ", 15, height-20);
  fill(255);
  text(formatP(thetaX), 160, height-20);
  fill(0, 255, 0);
  text("Angle-Y: ", width * 1 / 3 + 15, height-20);
  fill(255);
  text(formatP(thetaY), width * 1 / 3 + 160, height-20);
  fill(0, 0, 255);
  text("Angle-Z: ", width * 2 / 3 + 15, height-20);
  fill(255);
  text(formatP(thetaZ), width * 2 / 3 + 160, height-20);
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
    float decimal = 2;
    float num = (float)(round((number*pow(10, decimal))))/pow(10, decimal);
    return num >=0 ? "+" + str(num) : str(num);
} 
