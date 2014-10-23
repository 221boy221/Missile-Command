package  {
	import events.ShootEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import towers.TowerBase;
	import towers.TowerFactory;
	import explosions.ExplosionBase;
	import explosions.ExplosionFactory;
	import weapons.Projectile;
	import weapons.Rocket;
	import towers.Tower_01;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Game extends Sprite {
		
		private var _towers 	: Array = [];
		private var _projectiles : Array = [];
		private var _explosions 	: Array = [];
		private var towerFactory : TowerFactory = new TowerFactory();
		private var explosionFactory : ExplosionFactory = new ExplosionFactory();
		private var shooter : int;
		
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			
			createTowers();
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(TowerBase.SHOOT, addProjectile);
			stage.addEventListener(MouseEvent.CLICK, mouseClick);
			stage.addEventListener(Projectile.EXPLODE, explodeProjectile);
			stage.addEventListener(ExplosionBase.REMOVE_EXPLOSION, removeExplosion);
			
		}
		
		// Loops
		private function update(e:Event):void {
			var projectilesLength : Number = _projectiles.length,
				explosionsLength : Number = _explosions.length,
				currentProjectile : Projectile,
				currentExplosion : ExplosionBase;
				
			// Loop through the projectiles array
			for (var i : int = projectilesLength - 1; i >= 0; i--) {
				currentProjectile = _projectiles[i];
				currentProjectile.update();
			}
			
			// Loop through the explosions array
			for (var j : int = explosionsLength - 1; j >= 0; j--) {
				currentExplosion = _explosions[j];
				currentExplosion.update();
			}
			
		}
		
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
			
			removeProjectile(projectile);
		}
		
		// Add given projectile to projectiles array
		private function addProjectile(e : ShootEvent):void {
			_projectiles.push(e.projectile);
		}
		
		// Remove given projectile from projectilss array
		private function removeProjectile(pro:Projectile):void {
			var projectile : Projectile = pro,
				index : int = _projectiles.indexOf(projectile);
				
			stage.removeChild(projectile);	
			_projectiles.splice(index, 1);		
		}
		
		// Remove given explosion from explosions array
		private function removeExplosion(e:Event):void {
			var explosion : ExplosionBase = e.target as ExplosionBase,
				index : int = _explosions.indexOf(explosion);
			
			stage.removeChild(explosion);
			_explosions.splice(index, 1);
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