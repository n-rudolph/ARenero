import org.openkinect.processing.*;
import org.openkinect.freenect.*;

public class KinectView {
  
  protected Kinect kinect;
  
  // todo calibrate in device
  protected int verticalStart = 30;//40;
  protected int verticalEnd = 350;//295;
  protected int horizontalStart = 80;
  protected int horizontalEnd = 540;
  
  private int skip = 3;
  
  protected int[] depth;
  protected float[] depthLookUp = new float[2048];
  
  private int backX, backY, backSizeX, backSizeY;
  
  public KinectView() {}
  public KinectView(Kinect k) {
    kinect = k;
    
    // Lookup table for all possible depth values (0 - 2047)
    for (int i = 0; i < depthLookUp.length; i++) {
      depthLookUp[i] = rawDepthToMeters(i);
    }
    
    backY = 0;
    backSizeX = 150;
    backSizeY = 60;
    backX = width - backSizeX;  
  }
  
  public void drawView() {
    background(0);
     
    depth = kinect.getRawDepth();
    
    int xx = 0;
    for (int x = horizontalStart; x < horizontalEnd; x++) {
      int yy = 0;
      for (int y = verticalStart; y < verticalEnd; y++) {
        int index = getDepthIndex(x, y);
        int rawDepth = depth[index];
        checkTreasure(x, y, depthLookUp[rawDepth]);
        color pixelColor = getPixelColor(depthLookUp[rawDepth]);
        stroke(pixelColor);
        fill(pixelColor);
        rect(xx, yy, skip, skip);
        yy += skip;
      }
      xx += skip;
    }
    drawTreasures();
    drawBack();
  }
  
  private color getPixelColor(float depth) {
    if (depth < 0.8) {
      return color(0);
    } else if (depth < 0.85) {
      return color(1);
    } else if (depth < 0.9) {
      return color(139,69,19);
    } else if (depth < 0.95) {
      return color(244,164,96);
    } else if (depth < 1.0) {
      return color(0,100,0);
    } else if (depth < 1.05) {
      return color(124,252,0);
    } else if (depth < 1.1) {
      return color(255,255,0);
    } else if (depth < 1.15) {
      return color(0,191,255);
    } else {
      return color(0,0,255);
    } 
  }
  
  float rawDepthToMeters(int depthValue) {
    if (depthValue < 2047) {
      return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
    }
    return 0.0f;
  }
  
  int getDepthIndex(int x, int y) {
    return x + y * kinect.width;
  }
  
  protected void checkTreasure(int x, int y, float depth) {
  // to be overwritten
  }
  protected void drawTreasures() {
   // only to overwrite
  }
  
  void drawBack() {
    fill(255, 251, 175);
    stroke(0);
    strokeWeight(5);
    rect(backX, backY, backSizeX, backSizeY);
    
    textSize(32);
    fill(0);
    text("BACK", backX + 35, backY + 42);
  }
  
  public boolean isOverBack(){
    return Utils.overRect(backX, backY, backSizeX, backSizeY, mouseX, mouseY);
  }

}
