
#import('dart:html');
#source('Game.dart');
#source('Player.dart');
#source('Rocket.dart');
#source('Enemy.dart');
#source('EnemyRow.dart');
#source('GameDrawer.dart');
#source('Directions.dart');
#source('ScreenObject.dart');

CanvasElement canvas;
ButtonElement startButton, stopButton;
Game game;

void main() {
  canvas = query('#canvas');
  startButton = query('#start-button');
  startButton.on.click.add(startGame);
  stopButton = query('#stop-button');
  stopButton.on.click.add(stopGame);
}

void startGame(MouseEvent event) {
  toggleButtons();
  game = new Game(canvas);
  game.setup();
  game.start();
}

void stopGame(MouseEvent event) {
  toggleButtons();
  game.stop();
}

void toggleButtons() {
  startButton.disabled = ! startButton.disabled;
  stopButton.disabled = ! stopButton.disabled;
}
