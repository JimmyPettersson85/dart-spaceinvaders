/**
 * 
 * Class represeting a single Enemy
 * 
 */


class Enemy extends ScreenObject {
  
  int startX, direction;
  
  static final int SIZE = 40;
  static final int DX = 2;
  static final int DY = 1;
  
  Enemy(CanvasRenderingContext2D context, int direction, int x, int y):
    super(context, x, y, SIZE, Game.enemyImage) {
    this.startX = x;
    this.direction = direction;
    draw();
  }
  
  bool get atBottom() => y > 700;
  
  /** Check for direction change before calling super class */
  void updatePosition(int dx, int dy) {
    if (x >= startX + 2 * SIZE) direction = Directions.LEFT;
    else if (x <= startX) direction = Directions.RIGHT;
    super.updatePosition(direction * dx, dy);
  }
  
}
