
/**
 * 
 * Superclass describing a screen object holding convenience methods for drawing and clearing itself.
 *
 */

class ScreenObject {
  
  CanvasRenderingContext2D context;
  int x, y, size;
  ImageElement image;
  
  ScreenObject(this.context, this.x, this.y, this.size, this.image);
  
  /* Make the rocket appear in the middle (x-axis) of the object */
  int get rocketCenterX() => x + (size/2).toInt() - (Rocket.SIZE/2).toInt();
  /* Make the rocket appear at the top of the object */
  int get rocketTop() => y - Rocket.SIZE;
  /* Make the rocket appear at the bottom of the object */
  int get rocketBottom() => y + size + Rocket.SIZE;
  
  void clear() => context.clearRect(x, y, size, size);
  bool checkCollision(Rocket r) => ((r.x >= x && r.x < x + size)
      && (r.y >= y && r.y < y + size));
  
  void draw() {
    context.drawImage(image, x, y, size, size);
  }
  
  void updatePosition(int dx, int dy) {
    clear();
    x += dx;
    y += dy;
    draw();
  }
  
}
