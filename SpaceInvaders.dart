
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
  List<String> sources = new List<String>();
  sources.add('player.png');
  sources.add('enemy.png');
  sources.add('rocket.png');
  loadImages(sources, (images) {
    game = new Game(canvas, images['player.png'], images['enemy.png'], images['rocket.png']);
    game.setup();
    game.start();
  });
}

void stopGame(MouseEvent event) {
  toggleButtons();
  game.stop();
}

void loadImages(List<String> sources, callback) {
  Map<String, ImageElement> images = new Map<String, ImageElement>();
  for (String source in sources) {
    ImageElement img = new ImageElement(source);
    img.on.load.add((event) {
      images.putIfAbsent(source, () => img);
      if (images.length == sources.length)
        callback(images);
    });
  }
}

void toggleButtons() {
  startButton.disabled = ! startButton.disabled;
  stopButton.disabled = ! stopButton.disabled;
}
