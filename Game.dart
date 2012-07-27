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
  List<Rocket> rockets;
  List<EnemyRow> enemyRows;
  int score, level, tickId, movePlayerId, moveDownId, actionFlag;
  
  static final int WIDTH = 800;
  static final int HEIGHT = 800;
  static final int LEFT = 37;
  static final int RIGHT = 39;
  static final int FIRE = 32;
  static final int NONE = 0;
  static final int DELAY = 20; // 50fps
  static final int MOVE_DOWN_DELAY = 100;
  
  Game(CanvasElement canvas) {
    context = canvas.context2d;
    context.font = '20pt Calibri';
    player = new Player(context);
    rockets = new List<Rocket>();
    enemyRows = new List<EnemyRow>();
    score = 0;
    level = 1;
    window.on.keyDown.add(handleKeyDown);
    window.on.keyUp.add(handleKeyUp);
  }
  
  /** Sets yp the initial game state and draws the game board. */
  void setup() {
    initializeLevel();
    GameDrawer.updateScoreText(context, score);
    GameDrawer.updateLevelText(context, level);
    GameDrawer.drawBottomLine(context);
  }
  
  /** Add enemies to the level. */
  void initializeLevel() {
      enemyRows.add(new EnemyRow(context, level, 0, 50));
      enemyRows.add(new EnemyRow(context, level, 60, 100));
      enemyRows.add(new EnemyRow(context, level, 120, 150));
      enemyRows.add(new EnemyRow(context, level, 180, 200));
  }
  
  /** Event handler for when a key is pressed. */
  void handleKeyDown(KeyboardEvent event) {
    if (event.keyCode == LEFT) {
      actionFlag = LEFT;
    } else if (event.keyCode == RIGHT) {
      actionFlag = RIGHT;
    } else if (event.keyCode == FIRE && rockets.length < 5) {
      rockets.add(new Rocket(context, player.x + 20));
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
    GameDrawer.clearScreen(context);
  }
  
  /** 
   * A game "tick" invoked each DELAY ms. 
   * Updates all the states of the game and checks for collisions.
   */
  void tick() {
    updateRocketPositions();
    updateEnemyPositions();
    checkCollisions();
  }
  
  /** Updates the positions on all rockets in play. */
  void updateRocketPositions() {
    for (Rocket r in rockets) {
      r.updatePosition(Directions.UP);
      if (r.invalid) rockets.removeRange(rockets.indexOf(r), 1);
    }
    
    GameDrawer.drawBottomLine(context); 
  }
  
  /** Updates the position of all enemies and checks for game over. */
  void updateEnemyPositions() {
    for (EnemyRow er in enemyRows) {
      er.updateEnemyPositions();
      if (er.reachedBottom()) gameOver();
    }
  }
  
  /** Collision detection between rockets and enemies. */
  void checkCollisions() {
    for (EnemyRow er in enemyRows) {
      for (Enemy e in er.enemies) {
        for (Rocket r in rockets) {
          if (e.checkCollision(r)) {
            r.clear();
            e.clear();
            
            GameDrawer.updateScoreText(context, ++score);
            
            rockets.removeRange(rockets.indexOf(r), 1);
            er.removeEnemy(e);
            if (er.empty) enemyRows.removeRange(enemyRows.indexOf(er), 1);
            
            if (enemyRows.isEmpty()) advanceLevel();
            
            // This enemy has already been hit by a rocket, no need to loop over the rest.
            break;
          }
        }
      }
    }     
  }
  
  /** Moves the player. */
  void movePlayer() {
    if (actionFlag == NONE) return;
    
    switch (actionFlag) {
      case LEFT:
        player.updatePosition(Directions.LEFT);
        break;
      case RIGHT:
        player.updatePosition(Directions.RIGHT);
        break;
    }
  }
  
  /** Moves the enemies downward slowly. Acts on a separate timer. */
  void moveDown() {
    for (EnemyRow er in enemyRows) {
      er.moveDown();
    }
  }
  
  /** Advances the game one level. */
  void advanceLevel() {
    level++;
    clearIntervals();
    for (Rocket r in rockets) {
      r.clear();
    }
    rockets.clear();
    setup();
    start();  
  }
  
  /** Clear all timers */
  void clearIntervals() {
    window.clearInterval(tickId);
    window.clearInterval(movePlayerId);
    window.clearInterval(moveDownId); 
  }
  
  void gameOver() {
    clearIntervals();
    GameDrawer.drawGameOver(context);
  }
  
}
