public class Menu {
  
  int rect1X, rect1Y, rect2X, rect2Y;
  int rectSize, backSizeX, backSizeY;
  color rect1Color, rect2Color;

  public Menu(int height, int width) {
    rectSize = 100;
       
    rect1Color = color(0);
    rect2Color = color(55);
    
    rect1X = width/2 - rectSize - 30;
    rect1Y = height/2 - rectSize/ 2;
    rect2X = width/2 + 30;
    rect2Y = height/2 - rectSize/ 2;
  }
  
  public void drawMenu() {
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
  
  public boolean isOverRect1(){
    return Utils.overRect(rect1X, rect1Y, rectSize, rectSize, mouseX, mouseY);
  }
  
  public boolean isOverRect2(){
    return Utils.overRect(rect2X, rect2Y, rectSize, rectSize, mouseX, mouseY);
  }
  
}
