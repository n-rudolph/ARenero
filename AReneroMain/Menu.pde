public class Menu {
  
  int rect1X, rect1Y, rect2X, rect2Y;
  int rectSize, backSizeX, backSizeY;
  color rect1Color, rect2Color;
  
  PImage backgroundImg;
  PImage logo;

  public Menu(int height, int width) {
    rectSize = 200;
       
    rect1Color = color(255, 251, 175);
    rect2Color = color(255, 251, 175);
    
    rect1X = width/2 - rectSize * 2 - 30;
    rect1Y = height/2;
    rect2X = width/2 + 30;
    rect2Y = height/2;
    
    backgroundImg = loadImage("menu.jpg");
    logo = loadImage("logo.png");
  }
  
  public void drawMenu() {
    image(backgroundImg, 0, 0, width, height);
  
    fill(rect1Color);  
    stroke(rect1Color);
    rect(rect1X, rect1Y, rectSize*2, rectSize);
    
    textSize(32);
    fill(0);
    text("SANDBOX", rect1X + rectSize - 80, rect1Y + rectSize - 90);
    
    fill(rect2Color);
    stroke(rect2Color);
    rect(rect2X, rect2Y, rectSize*2, rectSize);
    
    textSize(32);
    fill(0);
    text("TREASURE HUNT", rect2X + rectSize - 130, rect2Y + rectSize - 90);
    
    
   image(logo, width/2 - 175, height/2 - 300, 300, 300);
  }
  
  public boolean isOverRect1(){
    return Utils.overRect(rect1X, rect1Y, rectSize, rectSize, mouseX, mouseY);
  }
  
  public boolean isOverRect2(){
    return Utils.overRect(rect2X, rect2Y, rectSize, rectSize, mouseX, mouseY);
  }
  
}
