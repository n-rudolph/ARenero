import org.openkinect.processing.*;
import org.openkinect.freenect.*;

int y;

Menu menuView;
int backX, backY, rectSize, backSizeX, backSizeY;
color backgroundColor, rect2Color;

KinectView kinectView;
TreasureSearchView treasureView;

boolean overRect1 = false;
boolean overRect2 = false;
boolean overBack = false;

int screen = 0;

void setup() {
  fullScreen();
  surface.setResizable(true);
  menuView = new Menu(height, width);
  Kinect k  = new Kinect(this);
  k.initDepth();
  k.setTilt(0);
  
  backSizeX = 75;
  backSizeY = 40;
  backgroundColor = color(1);
  rect2Color = color(55);
  backX = width - backSizeX;
  backY = 0;
  
  kinectView = new KinectView(k, rect2Color, backX, backY, backSizeX, backSizeY);
  treasureView = new TreasureSearchView(k, rect2Color, backX, backY, backSizeX, backSizeY);
}

void draw() {
  checkMousePosition();
  if (screen == 0) {
    menuView.drawMenu();
  } else if (screen == 1) {
    kinectView.drawView();
  } else if (screen == 2) {
    treasureView.drawView();
  } 
}

void mousePressed() {
  if (overRect1 && screen == 0) {
    //Go to sandbox
    screen = 1;
  } else if (overRect2  && screen == 0) {
    //Go to treasure hunt
    screen = 2;
    treasureView.reset();
  } else if (overBack && (screen == 1 || screen == 2)) {
    screen = 0;
  }
}

void checkMousePosition() {
  switch(screen) {
    case 0:
      overBack = false;
      if (menuView.isOverRect1()) {
        overRect1 = true;
        overRect2 = false;
      } else if (menuView.isOverRect2()) {
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
      if (Utils.overRect(backX, backY, backSizeX, backSizeY, mouseX, mouseY)) {
        overBack = true;
      } else {
        overBack = false;
      }
      break;
  }
}
