public static class Utils {
  
  public static boolean overRect(int x, int y, int rectWidth, int rectHeight, int mouseX, int mouseY)  {
    if (mouseX >= x && mouseX <= x+rectWidth && 
        mouseY >= y && mouseY <= y+rectHeight) {
      return true;
    } else {
      return false;
    }
  }
}
