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
  
  private color rect2Color;
  private int backX, backY, backSizeX, backSizeY;
  
  public KinectView() {}
  public KinectView(Kinect k, color rectColor, int backX, int backY, int backSizeX,int backSizeY) {
    kinect = k;
    kinect.initDepth();
    kinect.setTilt(0);
    
    // Lookup table for all possible depth values (0 - 2047)
    for (int i = 0; i < depthLookUp.length; i++) {
      depthLookUp[i] = rawDepthToMeters(i);
    }
    
    this.rect2Color = rectColor;
    this.backX = backX;
    this.backY = backY;
    this.backSizeX = backSizeX;
    this.backSizeY = backSizeY;
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
    fill(rect2Color);
    stroke(rect2Color);
    rect(backX, backY, backSizeX, backSizeY);
  }

}
