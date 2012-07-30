/**
 * 
 * Class represeting a single Enemy
 * 
 */


class Enemy extends ScreenObject {
  
  int startX, direction;
  
  static final String COLOR = 'black';
  static final int SIZE = 40;
  static final int DX = 2;
  static final int DY = 1;
  
  Enemy(CanvasRenderingContext2D context, int direction, int x, int y):
    super(context, x, y, SIZE, 'black'){
    this.startX = x;
    this.direction = direction;
    draw();
  }
  
  bool get bottom() => y > 700;
  
  void updatePosition(int dx, int dy) {
    if (x >= startX + 2 * SIZE) direction = Directions.LEFT;
    else if (x <= startX) direction = Directions.RIGHT;
    super.updatePosition(direction * dx, dy);
  }
  
}
