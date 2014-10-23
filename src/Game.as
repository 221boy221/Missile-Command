package  {
	import events.ShootEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import towers.TowerBase;
	import towers.TowerFactory;
	import explosions.ExplosionBase;
	import explosions.ExplosionFactory;
	import weapons.EnemyMissile;
	import weapons.Projectile;
	import weapons.Rocket;
	import towers.Tower_01;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Game extends Sprite {
		
		private var _towers : Array = [];
		private var _projectiles : Array = [];
		private var _explosions : Array = [];
		private var _enemyProjectiles : Array = [];
		private var towerFactory : TowerFactory = new TowerFactory();
		private var explosionFactory : ExplosionFactory = new ExplosionFactory();
		private var shooter : int;
		private var waveSystem : WaveSystem;
		private var scoreText : TextField = new TextField();
		private var hp:int;
		public var score : int = 0;
		
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			  
			createTowers();
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(TowerBase.SHOOT, addProjectile);
			stage.addEventListener(WaveSystem.SHOOT, addProjectile);
			stage.addEventListener(MouseEvent.CLICK, mouseClick);
			stage.addEventListener(Projectile.EXPLODE, explodeProjectile);
			stage.addEventListener(ExplosionBase.REMOVE_EXPLOSION, removeExplosion);
			
			waveSystem = new WaveSystem(this);
			addChild(waveSystem);
			
			scoreText.text = ("Score: " + score);
			addChild(scoreText);
			scoreText.x = 20;
			scoreText.y = 20;
			scoreText.selectable = false;
		}
		
		// Loops
		private function update(e:Event):void {
			var projectilesLength : Number = _projectiles.length,
				explosionsLength : Number = _explosions.length,
				enemyProjectilesLength : Number = _enemyProjectiles.length,
				towersLength : Number = _towers.length,
				currentProjectile : Projectile,
				currentExplosion : ExplosionBase,
				currentEnemyProjectile : Projectile;
				
			// Update score
			scoreText.text = ("Score: " + score);	
			
			// Loop through the projectiles array
			for (var i : int = projectilesLength - 1; i >= 0; i--) {
				currentProjectile = _projectiles[i];
				currentProjectile.update();
			}
			
			// Loop through the enemyProjectiles array
			for (i = enemyProjectilesLength - 1; i >= 0; i--) {
				currentEnemyProjectile = _enemyProjectiles[i];
				currentEnemyProjectile.update();
				
				// HitTest the EnemyProjectiles with the Towers
				for (j = towersLength - 1; j >= 0; j--) {
					if (_towers[j] != null) {
						if (currentEnemyProjectile.hitTestObject(_towers[j])) {
							/*
							//_towers.splice(_towers[j]);
							hp--;
							if (hp <= 0) {
								gameover();
							}
							*/
						}
					}
				}
			}
			
			// Loop through the explosions array
			for (i = explosionsLength - 1; i >= 0; i--) {
				currentExplosion = _explosions[i];
				currentExplosion.update();
				
				// HitTest the explosions with the EnemyProjectiles
				for (var j :int = enemyProjectilesLength - 1; j >= 0; j--) {
					if (_enemyProjectiles[j] != null) {
						if (currentExplosion.hitTestObject(_enemyProjectiles[j])) {
							_enemyProjectiles[j].explode();
						}
					}
					
				}
			}
			
		}
		// DOESN'T WORK YET ;-;
		/*
		private function gameover():void {
			
			// Remove all the eventlisteners
			removeEventListener(Event.ENTER_FRAME, update);
			stage.removeEventListener(TowerBase.SHOOT, addProjectile);
			stage.removeEventListener(WaveSystem.SHOOT, addProjectile);
			stage.removeEventListener(MouseEvent.CLICK, mouseClick);
			stage.removeEventListener(Projectile.EXPLODE, explodeProjectile);
			stage.removeEventListener(ExplosionBase.REMOVE_EXPLOSION, removeExplosion);
			stage.removeChild(waveSystem);
			// Tell the main to open the menu
			//dispatchEvent(new Event("openMenu"));
		}
		*/
		
		// Random generate which tower will spawn
		private function createTowers():void {
			var tower : TowerBase;
				
			for (var i:Number = 0; i < 3; i++) {
				switch (Math.floor(Math.random() * 2) + 1) {
					case 1:
						tower = towerFactory.addTower(TowerFactory.TOWER_01, this.stage, this.stage.stageWidth / i, this.stage.stageHeight - 20);
						break;
					case 2:
						tower = towerFactory.addTower(TowerFactory.TOWER_02, this.stage, this.stage.stageWidth / i, this.stage.stageHeight - 20);
						break;
				}
				_towers.push(tower);
			}
			//hp = _towers.length;
		}
		
		// On mouse click
		private function mouseClick(e:MouseEvent):void {
			getShooter();
		}
		
		// Check which tower is closest to the cursor
		private function getShooter():void {		
			_towers.sortOn("distance", Array.NUMERIC);
			_towers[0].shoot();
		}
		
		// Create explosion on projectile
		private function explodeProjectile(e:Event):void {
			var projectile : Projectile = e.target as Projectile,
				explosion : ExplosionBase;
				
			explosion = explosionFactory.addExplosion(projectile.explosionType, this.stage, projectile.x, projectile.y);
			_explosions.push(explosion);
			
			trace(projectile);
			removeProjectile(projectile);
		}
		
		// Add given projectile to projectiles array
		private function addProjectile(e : ShootEvent):void {
			if (e.projectile is EnemyMissile) {
				_enemyProjectiles.push(e.projectile);
			} else {
				_projectiles.push(e.projectile);
			}
		}
		
		// Remove given projectile from projectilss array
		private function removeProjectile(pro:Projectile):void {
			var projectile : Projectile = pro,
				index : int;
				
			stage.removeChild(projectile);
			if (projectile is EnemyMissile) {
				index = _enemyProjectiles.indexOf(projectile);
				_enemyProjectiles.splice(index, 1);
				score += 50;
			} else {
				index = _projectiles.indexOf(projectile);
				_projectiles.splice(index, 1);		
			}
		}
		
		// Remove given explosion from explosions array
		private function removeExplosion(e:Event):void {
			var explosion : ExplosionBase = e.target as ExplosionBase,
				index : int = _explosions.indexOf(explosion);
			
			stage.removeChild(explosion);
			_explosions.splice(index, 1);
		}
		
		// GETTER & SETTER
		public function get towers():Array 
		{
			return _towers;
		}
		
		public function set towers(value:Array):void 
		{
			_towers = value;
		}
		
		/*
		private function update(e:Event):void {
			var rocketsLength	:	int = _rockets.length,
				currentRocket	:	Projectile;
				
			for (var i : int = rocketsLength - 1; i >= 0; i--) {
				currentRocket = _rockets[i];
				currentRocket.update();
				
				if (isOutOfBounds(currentRocket)) {
					_rockets.splice(i, 1);
				}
			}
		}
		*/
		
	}

}