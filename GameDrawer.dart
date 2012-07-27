/**
 * 
 * Helper class for drawing things on the canvas.
 * 
 */


class GameDrawer {
  
  static void clearScreen(CanvasRenderingContext2D context) {
    context.clearRect(0, 0, Game.WIDTH, Game.HEIGHT);
  }
  
  static void drawBottomLine(CanvasRenderingContext2D context) {
    context.beginPath();
    context.moveTo(0, 740);
    context.lineTo(800, 740);
    context.strokeStyle = 'red';
    context.stroke();
  }
  
  static void updateScoreText(CanvasRenderingContext2D context, int score) {
    context.clearRect(650, 0, 200, 40);
    context.fillStyle = 'black';
    context.fillText('Score: $score', 670, 30);
  }
  
  static void updateLevelText(CanvasRenderingContext2D context, int level) {
    context.clearRect(550, 0, 100, 40);
    context.fillStyle = 'black';
    context.fillText('Level: $level', 550, 30);    
  }
  
  static void drawGameOver(CanvasRenderingContext2D context) {
    context.clearRect(0, 40, Game.WIDTH, Game.HEIGHT);
    context.fillStyle = 'black';
    context.font = '40pt Calibri';
    context.fillText('Game Over', Game.WIDTH/2 - 125, Game.HEIGHT/2);
  }
  
}
