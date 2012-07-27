/**
 * 
 * Class describing a human controlled player.
 * 
 * */


class Player extends ScreenObject {
  
  static final int SIZE = 40;
  static final int DX = 10;
  
  Player(CanvasRenderingContext2D context):
    super(context, 0, Game.HEIGHT - SIZE, SIZE, 'blue'){
    draw();
  }
  
  void updatePosition(int direction) => direction == Directions.LEFT ? moveLeft() : moveRight();
  
  void moveLeft() {
    if (x > 0) {
      clear();
      x -= DX;
      draw();
    }
  }
  
  void moveRight() {
    if (x < Game.WIDTH - SIZE) {
      clear();
      x += DX;
      draw();
    }
  }
  
}
