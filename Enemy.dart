/**
 * 
 * Class represeting a single Enemy
 * 
 */


class Enemy extends ScreenObject {
  
  int level;
  
  static final String COLOR = 'black';
  static final int SIZE = 40;
  static final int DX = 2;
  static final int DY = 1;
  
  Enemy(CanvasRenderingContext2D context, int level, int x, int y):
    super(context, x, y, SIZE, 'black'){
    this.level = level;
    draw();
  }
  
  int updatePosition(int direction) {
    clear();
    x += direction * DX * level;
    draw();
    return x;
  }
  
  void moveDown(int direction) {
    clear();
    y += DY;
    draw();
  }
  
  void adjustOffset(int direction) {
    updatePosition(direction);
    updatePosition(direction);
  }
  
  bool checkCollision(Rocket r) => ((r.x >= x && r.x < x + SIZE) 
      && (r.y >= y && r.y < y + SIZE));
  
  bool get bottom() => y > 700;
  
}
