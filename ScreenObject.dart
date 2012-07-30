
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
  
  void clear() => context.clearRect(x, y, size, size);
  bool checkCollision(Rocket r) => ((r.x >= x && r.x < x + size)
      && (r.y >= y && r.y < y + size));
  
  void draw() {
    context.beginPath();
    context.rect(x, y, size, size);
    context.fillStyle = color;
    context.fill();
  }
  
  void updatePosition(int dx, int dy) {
    clear();
    x += dx;
    y += dy;
    draw();
  }
  
}
