/**
 * 
 * Class describing a row of enemies. Responsible of keeping track
 * of the current direction of the enemies in this row
 * 
 */


class EnemyRow {
  
  List<Enemy> enemies;
  int direction;
  
  EnemyRow(CanvasRenderingContext2D context, int level, int startX, int startY) {
    enemies = new List<Enemy>();
    direction = Directions.RIGHT;
    
    for (int i = 0; i < 10; i++) {
      enemies.add(new Enemy(context, level, startX + (i*60), startY));
    }
  }
  
  /** Updates all enemy positions and checks if direction needs to change. */
  void updateEnemyPositions() {
    for (Enemy e in enemies) {
      int x = e.updatePosition(direction);
      if (x >= Game.WIDTH - Enemy.SIZE || x <= 0){
        direction *= -1;
        
        // Adjust for changing direction AFTER moving the first enemy in the array
        if (x <= 0) e.adjustOffset(direction);
      }
    }
  }
  
  void moveDown() {
    for (Enemy e in enemies) {
      e.moveDown(Directions.DOWN);
    }
  }
  
  bool reachedBottom() {
    for (Enemy e in enemies) {
      if (e.bottom) return true;
    }
    
    return false;
  }
  
  void removeEnemy(Enemy e) => enemies.removeRange(enemies.indexOf(e), 1);
  
  bool get empty() => enemies.isEmpty();
  
}
