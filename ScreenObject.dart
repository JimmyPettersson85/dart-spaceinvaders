
/**
 * 
 * Superclass describing a screen object holding convenience methods for drawing and clearing itself.
 *
 */

class ScreenObject {
  
  CanvasRenderingContext2D context;
  int x, y, size;
  String color;
  
  ScreenObject(this.context, this.x, this.y, this.size, this.color);
  
  void draw() {
    context.beginPath();
    context.rect(x, y, size, size);
    context.fillStyle = color;
    context.fill();
  }
  
  void clear() => context.clearRect(x, y, size, size);
  
}
