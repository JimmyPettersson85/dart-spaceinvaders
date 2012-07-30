/**
 * Author: Jimmy Pettersson.
 * 
 * Game class containing the overall logic of the game.
 * 
 * Known issues: Vertical sync issues.
 * 
 * */


class Game {
  
  CanvasRenderingContext2D context;
  Player player;
  List<Rocket> playerRockets, enemyRockets;
  List<EnemyRow> enemyRows;
  int score, level, tickId, movePlayerId, moveDownId, actionFlag;
  static ImageElement playerImage, enemyImage, rocketImage;
  
  static final int WIDTH = 800;
  static final int HEIGHT = 800;
  static final int LEFT = 37;
  static final int RIGHT = 39;
  static final int FIRE = 32;
  static final int NONE = 0;
  static final int DELAY = 20; // 50fps
  static final int MOVE_DOWN_DELAY = 100;
  
  Game(CanvasElement canvas, ImageElement playerImage, ImageElement enemyImage, ImageElement rocketImage) {
    context = canvas.context2d;
    Game.playerImage = playerImage;
    Game.enemyImage = enemyImage;
    Game.rocketImage = rocketImage;
    player = new Player(context);
    playerRockets = new List<Rocket>();
    enemyRockets = new List<Rocket>();
    enemyRows = new List<EnemyRow>();
    score = 0;
    level = 1;
    window.on.keyDown.add(handleKeyDown);
    window.on.keyUp.add(handleKeyUp);
  }
  
  /** Sets up the initial game state and draws the game board. */
  void setup() {
    drawStatics();
    initializeLevel();
  }
  
  /** Add enemies to the level. */
  void initializeLevel() {
      enemyRows.add(new EnemyRow(context, 60, 50));
      enemyRows.add(new EnemyRow(context, 60, 100));
      enemyRows.add(new EnemyRow(context, 60, 150));
      enemyRows.add(new EnemyRow(context, 60, 200));
  }
  
  /** Event handler for when a key is pressed. */
  void handleKeyDown(KeyboardEvent event) {
    if (event.keyCode == LEFT) {
      actionFlag = LEFT;
    } else if (event.keyCode == RIGHT) {
      actionFlag = RIGHT;
    } else if (event.keyCode == FIRE && playerRockets.length < 5) {
      playerRockets.add(new Rocket(context, player.rocketCenterX, player.rocketTop));
    }
  }
  
  /** Event handler for when a key is relased. */
  void handleKeyUp(KeyboardEvent event) {
    if (event.keyCode == LEFT || event.keyCode == RIGHT) actionFlag = NONE;
  }
  
  /** Starts the game by starting the different timers. */
  void start() {
    tickId = window.setInterval(tick, DELAY);
    movePlayerId = window.setInterval(movePlayer, DELAY);
    int moveDelay = MOVE_DOWN_DELAY - 5 * level;
    moveDownId = window.setInterval(moveDown, moveDelay);
  }
  
  /** Stops the current game. */
  void stop() {
    clearIntervals();
    drawStatics();
  }
  
  /** 
   * A game "tick" invoked each DELAY ms. 
   * Updates all the states of the game and checks for collisions.
   */
  void tick() {
    drawStatics();
    player.draw();
    updateRocketPositions();
    updateEnemyPositions();
    checkCollisions();
  }
  
  /** Updates the positions on all rockets in play. */
  void updateRocketPositions() {
    for (Rocket r in playerRockets) {
      r.updatePosition(0, Directions.UP * Rocket.DY);
      if (r.invalid) playerRockets.removeRange(playerRockets.indexOf(r), 1);
    }
    
    for (Rocket r in enemyRockets) {
      r.updatePosition(0, Directions.DOWN * Rocket.DY);
      if (r.invalid) enemyRockets.removeRange(enemyRockets.indexOf(r), 1);
    } 
  }
  
  /** Updates the position of all enemies and checks for game over. */
  void updateEnemyPositions() {
    for (EnemyRow er in enemyRows) {
      er.updateEnemyPositions();
      if (er.reachedBottom()) gameOver();
    }
  }
  
  /** Collision detection between rockets and enemies/player. */
  void checkCollisions() {
    /* Player rockets hitting enemies */
    for (EnemyRow er in enemyRows) {
      for (Enemy e in er.enemies) {
        for (Rocket r in playerRockets) {
          if (e.checkCollision(r)) {
            score++;
            playerRockets.removeRange(playerRockets.indexOf(r), 1);
            er.removeEnemy(e);
            if (er.empty) enemyRows.removeRange(enemyRows.indexOf(er), 1);
            
            if (enemyRows.isEmpty()) advanceLevel();
            
            // This enemy has already been hit by a rocket, no need to loop over the rest.
            break;
          }
        }
      }
    }
    
    /* Enemy rockets hitting player */
    for (Rocket r in enemyRockets) {
      if (player.checkCollision(r)) {
        gameOver();
        break;
      }
    }
  }
  
  /** Moves the player. */
  void movePlayer() {
    if (actionFlag == LEFT && player.x > 0) {
      player.updatePosition(Directions.LEFT * Player.DX, 0);
    } else if (actionFlag == RIGHT && player.x < Game.WIDTH - Player.SIZE) {
      player.updatePosition(Directions.RIGHT * Player.DX, 0);
    }
  }
  
  /** Moves the enemies downward slowly. Acts on a separate timer. */
  void moveDown() {
    for (EnemyRow er in enemyRows) {
      er.moveDown();
    }
    
    /* Fire rockets at random on this timer */
    if (enemyRockets.length < 3 && Math.random() > 0.95) {
      EnemyRow er = enemyRows[(Math.random() * enemyRows.length).toInt()];
      Enemy e = er.enemies[(Math.random() * er.enemies.length).toInt()];
      enemyRockets.add(new Rocket(context, e.rocketCenterX, e.rocketBottom));
    }
  }
  
  /** Advances the game one level. */
  void advanceLevel() {
    level++;
    clearIntervals();
    drawStatics();
    playerRockets.clear();
    enemyRockets.clear();
    setup();
    start();  
  }
  
  /** Clear all timers */
  void clearIntervals() {
    window.clearInterval(tickId);
    window.clearInterval(movePlayerId);
    window.clearInterval(moveDownId); 
  }
  
  /** Draws the background gradient, the score and level texts and the bottom line */
  void drawStatics() {
    GameDrawer.drawBackground(context);
    GameDrawer.updateScoreText(context, score);
    GameDrawer.updateLevelText(context, level);
    GameDrawer.drawBottomLine(context);
  }
  
  void gameOver() {
    clearIntervals();
    drawStatics();
    GameDrawer.drawGameOver(context);
    startButton.disabled = false;
    stopButton.disabled = true;
  }
  
}
