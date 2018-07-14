import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

int y;

int rect1X, rect1Y, rect2X, rect2Y, backX, backY;
int rectSize, backSizeX, backSizeY;
color rect1Color, rect2Color, backgroundColor;

boolean overRect1 = false;
boolean overRect2 = false;
boolean overBack = false;

int screen = 0;

int blackEnd = 700;
int whiteEnd = 850;
int brownEnd = 1000;
int lightBrownEnd = 1150;
int greenEnd = 1300;
int lightGreenEnd = 1450;
int yellowEnd = 1600;
int lightBlueEnd = 1750;
int blueEnd = 1900;

void setup() {
  size(338, 225);
  surface.setResizable(true);
  setupMenu();
}

void setupMenu() {
  rectSize = 100;
  backSizeX = 75;
  backSizeY = 40;
  
  rect1Color = color(0);
  rect2Color = color(55);
  backgroundColor = color(1);
  
  rect1X = width/2 - rectSize - 30;
  rect1Y = height/2 - rectSize/ 2;
  rect2X = width/2 + 30;
  rect2Y = height/2 - rectSize/ 2;
  
  backX = width - backSizeX;
  backY = 0;
}

void setupKinect() {
  kinect = new Kinect(this);
  kinect.initDepth();
}

void draw() {
  checkMousePosition();
  if (screen == 0) {
    drawMenuScreen();
  } else if (screen == 1) {
    drawSandboxScreen();
  } else if (screen == 2) {
    drawTreasureSearchScreen();
  } 
}

void drawMenuScreen() {
  background(255, 204, 0);
  
  fill(rect1Color);  
  stroke(rect1Color);
  rect(rect1X, rect1Y, rectSize, rectSize);
  
  fill(rect2Color);
  stroke(rect2Color);
  rect(rect2X, rect2Y, rectSize, rectSize);
  
  textAlign(CENTER);
  fill(255);
  textSize(30);
  text("ARenero", width/2, height/2 - 75);
}

void drawSandboxScreen() {
  background(0);
  drawBack();
  
  PImage img = kinect.getDepthImage();
  image(img, 0, 0);
  
  for (int x = 0; x < img.width; x ++) {
    for (int y = 0; y < img.height; y++) {
      int index = x +y * width;
      int depth = img.pixels[index];
      color pixelColor = getPixelColor(depth);
      fill(pixelColor);
      rect(x, y, 5, 5);
    }
  }
}

color getPixelColor(int depth) {
  color pixelColor = 0 ;
  if (depth < blackEnd) {
    pixelColor = color(0, 0,0);
  } else if (depth < whiteEnd) {
    pixelColor = color(255, 255, 255);
  } else if (depth < brownEnd) {
    pixelColor = color(139,69,19);
  } else if (depth < lightBrownEnd) {
    pixelColor = color(205,133,63);
  } else if (depth < greenEnd) {
    pixelColor = color(0, 102, 0);
  } else if (depth < lightGreenEnd) {
    pixelColor = color(51, 255, 51);
  } else if (depth < yellowEnd) {
    pixelColor = color(255, 255, 0);
  } else if (depth < lightBlueEnd) {
    pixelColor = color(173, 216, 230);
  } else {
    pixelColor = color(0, 0, 255);
  }
  return pixelColor;  
}

void drawTreasureSearchScreen() {
  background(0);
  drawBack();
}

void drawBack() {
  fill(rect2Color);
  stroke(rect2Color);
  rect(backX, backY, backSizeX, backSizeY);
}

void mousePressed() {
  if (overRect1 && screen == 0) {
    //Go to sandbox
    screen = 1;
  } else if (overRect2  && screen == 0) {
    //Go to treasure hunt
    screen = 2;
  } else if (overBack && (screen == 1 || screen == 2)) {
    screen = 0;
  }
}

void checkMousePosition() {
  switch(screen) {
    case 0:
      overBack = false;
      if (overRect(rect1X, rect1Y, rectSize, rectSize)) {
        overRect1 = true;
        overRect2 = false;
      } else if (overRect(rect2X, rect2Y, rectSize, rectSize)) {
        overRect1 = false;
        overRect2 = true;
      } else {
        overRect1 = false;
        overRect2 = false;
      } 
      break;
    case 1:
    case 2:
      overRect1 = false;
      overRect2 = false;
      if (overRect(backX, backY, backSizeX, backSizeY)) {
        overBack = true;
      } else {
        overBack = false;
      }
      break;
  }
}

boolean overRect(int x, int y, int rectWidth, int rectHeight)  {
  if (mouseX >= x && mouseX <= x+rectWidth && 
      mouseY >= y && mouseY <= y+rectHeight) {
    return true;
  } else {
    return false;
  }
}
