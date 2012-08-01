/**
 * 
 * Helper class for drawing things on the canvas.
 * 
 */


class GameDrawer {
  
  static void drawBackground(CanvasRenderingContext2D context) {
    var grd = context.createLinearGradient(0, 0, Game.WIDTH, Game.HEIGHT);
    grd.addColorStop(0, '#8ED6FF');
    grd.addColorStop(1, '#004CB3');
    context.fillStyle = grd;
    context.fillRect(0, 0, Game.WIDTH, Game.HEIGHT); 
  }
  
  static void drawBottomLine(CanvasRenderingContext2D context) {
    context.beginPath();
    context.moveTo(0, 740);
    context.lineTo(800, 740);
    context.strokeStyle = 'red';
    context.stroke();
  }
  
  static void updateScoreText(CanvasRenderingContext2D context, int score) {
    context.fillStyle = 'black';
    context.font = '20pt Calibri';
    context.fillText('Score: $score', 670, 30);
  }
  
  static void updateLevelText(CanvasRenderingContext2D context, int level) {
    context.fillStyle = 'black';
    context.font = '20pt Calibri';
    context.fillText('Level: $level', 550, 30);    
  }
  
  static void drawGameOver(CanvasRenderingContext2D context) {
    context.fillStyle = 'black';
    context.font = '40pt Calibri';
    context.fillText('Game Over', Game.WIDTH/2 - 125, Game.HEIGHT/2);
  }
  
}
