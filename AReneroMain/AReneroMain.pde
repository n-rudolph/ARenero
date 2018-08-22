import org.openkinect.processing.*;
import org.openkinect.freenect.*;

int y;

Menu menuView;

color backgroundColor;

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
  
  backgroundColor = color(1);
  
  kinectView = new KinectView(k);
  treasureView = new TreasureSearchView(k);
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
      overRect1 = menuView.isOverRect1();
      overRect2 = menuView.isOverRect2();
      break;
    case 1:
      overRect1 = false;
      overRect2 = false;
      overBack = kinectView.isOverBack();
      break;
    case 2:
      overRect1 = false;
      overRect2 = false;
      overBack = treasureView.isOverBack();
      break;
  }
}
