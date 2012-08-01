/**
 * 
 * Class describing a row of enemies. Responsible of keeping track
 * of the current direction of the enemies in this row
 * 
 */


class EnemyRow {
  
  List<Enemy> enemies;
  
  EnemyRow(CanvasRenderingContext2D context, int startX, int startY) {
    enemies = new List<Enemy>();
    
    for (int i = 0; i < 10; i++) {
      enemies.add(new Enemy(context, Directions.RIGHT, startX + (i*60), startY));
    }
  }
  
  void removeEnemy(Enemy e) => enemies.removeRange(enemies.indexOf(e), 1);
  bool get empty() => enemies.isEmpty();
  
  /** Updates all enemy positions */
  void updateEnemyPositions() {
    for (Enemy e in enemies) {
      e.updatePosition(Enemy.DX, 0);
    }
  }
  
  void moveEnemyDown() {
    for (Enemy e in enemies) {
      e.updatePosition(0, Directions.DOWN * Enemy.DY);
    }
  }
  
  bool reachedBottom() {
    for (Enemy e in enemies) {
      if (e.atBottom) return true;
    }
    
    return false;
  }
  
}
