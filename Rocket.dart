/**
 * 
 * Class describing a Rocket
 * 
 * */


class Rocket extends ScreenObject {
  
  static final int SIZE = 5;
  static final int DY = 10;
  
  Rocket(CanvasRenderingContext2D context, int x):
    super(context, x, Game.HEIGHT - Player.SIZE - SIZE, SIZE, 'red'){
  }
  
  bool get invalid() => y < 0;
  
  /** Not using direction here, rockets can only go up. */
  void updatePosition(int direction) {
    clear();
    y -= DY;
    draw();
  }
  
}
