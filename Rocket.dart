/**
 * 
 * Class describing a Rocket
 * 
 * */


class Rocket extends ScreenObject {
  
  static final int SIZE = 5;
  static final int DY = 10;
  
  Rocket(CanvasRenderingContext2D context, int x, int y):
    super(context, x, y, SIZE, Game.rocketImage){
  }
  
  /* Rocket is out of bounds */
  bool get invalid() => y < 0 || y > Game.HEIGHT;
  
}
