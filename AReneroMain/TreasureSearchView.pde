public class TreasureSearchView extends KinectView {
  
  private ArrayList<TreasureSpot> treasures;
  private ArrayList<TreasureSpot> discoveredTreasures;
  
  private PImage treasureImage ;
  
  public TreasureSearchView(Kinect k, color rectColor, int backX, int backY, int backSizeX,int backSizeY) {
    super(k, rectColor, backX, backY, backSizeX, backSizeY);
    treasureImage = loadImage("treasure.png");    
    treasures = new ArrayList<TreasureSpot>();
    discoveredTreasures = new ArrayList<TreasureSpot>();
  }
  
  private boolean placeTreasure() {
    int varX = int(random(horizontalStart, horizontalEnd));
    int varY = int(random(verticalStart, verticalEnd));
    
    int index = getDepthIndex(varX, varY);
    int rawDepth = depth[index];
    float realDepth = depthLookUp[rawDepth];
    if (realDepth >= 1.2) {
      return false;
    }
    float treasureDepth = random(realDepth, 1.2);
    TreasureSpot t = new TreasureSpot(varX, varY, treasureDepth);
    treasures.add(t);
    return true;
  }
  
  @Override
  protected void checkTreasure(int x, int y, float depth) {
    while (treasures.size() < 5) {
      println ("treasure added");
      placeTreasure();
    }
    TreasureSpot treasure = null;
    for (TreasureSpot spot: treasures) {
      if (spot.isDiscovered(x, y, depth)) {
        treasure = spot;
        break;
      }
    }
    if (treasure != null) {
      println("Tesoro encontrado");
      treasures.remove(treasure);
      treasure.setDiscover();
      discoveredTreasures.add(treasure);
    }
  }
  
  @Override
  protected void drawTreasures() {
    println("comenzar a dibujar: ", discoveredTreasures.size());
   ArrayList<TreasureSpot> aux = new ArrayList<TreasureSpot>();
   for(TreasureSpot t: discoveredTreasures) {
     if (t.hasExpired()) {
       aux.add(t);
     } else {
       image(treasureImage, t.getXCoord(), t.getYCoord(), 100, 100);
     }
   }
   for(TreasureSpot t: aux) {
       discoveredTreasures.remove(t);
   }
  }  
}
