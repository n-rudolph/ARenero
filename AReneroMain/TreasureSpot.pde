public class TreasureSpot { 
  private int xCoord;
  private int yCoord;
  private float depth;
  
  private float discoverTime;
  
  public TreasureSpot(int xCoord, int yCoord, float depth) {
    this.xCoord = xCoord;
    this.yCoord = yCoord;
    this.depth = depth;
  }
  
  public int getXCoord() {
    return xCoord;
  }
  
  public int getYCoord() {
    return yCoord;
  }
  
  public void setDiscover() {
    discoverTime = millis();
  }
  
  public boolean isDiscovered(int x, int y, float currentDepth) {
    return ((xCoord <= (x+3) && xCoord >= (x-3)) && (yCoord <= (y+3) && yCoord >= (y-3)) && currentDepth >= depth);
  }
  
  public boolean hasExpired() {
    return ((millis() - discoverTime) > 3000.0);
  }
}
