/**
 * 
 * Class describing a human controlled player.
 * 
 * */


class Player extends ScreenObject {
  
  static final int SIZE = 40;
  static final int DX = 10;
  
  Player(CanvasRenderingContext2D context):
    super(context, 0, Game.HEIGHT - SIZE, SIZE, Game.playerImage){
    draw();
  }
  
}
