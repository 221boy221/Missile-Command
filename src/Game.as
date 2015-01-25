package  {
	import flash.display.DisplayObject;
	import vehicles.VehicleBase;
	import vehicles.VehicleFactory;
	import events.ShootEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
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
		
		private var _towers 			: Array				= [];
		private var _projectiles 		: Array				= [];
		private var _explosions 		: Array				= [];
		private var _enemyProjectiles 	: Array				= [];
		private var _vehicles		 	: Array				= [];
		private var _towerFactory 		: TowerFactory 		= new TowerFactory();
		private var _explosionFactory 	: ExplosionFactory	= new ExplosionFactory();
		private var _vehicleFactory		: VehicleFactory	= new VehicleFactory();
		private var _ui					: UI				= new UI();
		private var _waveSystem 		: WaveSystem;
		private var _gameSC 			: SoundChannel;
		private var _gameBG_SFX 		: GameBG_SFX 		= new GameBG_SFX();
		private var _trans				: SoundTransform 	= new SoundTransform(0.5,0); 
		private var _amountOfVehicles	: int				= 10;
		public var score 				: int				= 0;
		
		
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			  
			createTowers();
			createVehicles();
			
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(TowerBase.SHOOT, addProjectile);
			stage.addEventListener(TowerBase.TOWER_DOWN, destroyTower);
			stage.addEventListener(WaveSystem.SHOOT, addProjectile);
			stage.addEventListener(MouseEvent.CLICK, mouseClick);
			stage.addEventListener(Projectile.EXPLODE, explodeProjectile);
			stage.addEventListener(ExplosionBase.REMOVE_EXPLOSION, removeExplosion);
			
			// Enemies
			_waveSystem = new WaveSystem(this);
			//addChild(_waveSystem);
			
			// UI
			addChild(_ui);
			
			// Play and loop forever
			_gameSC = _gameBG_SFX.play(0, int.MAX_VALUE, _trans); 
			_gameSC.addEventListener(Event.SOUND_COMPLETE, soundLoop);
		}
		
		
		
		// Update
		private function update(e:Event):void {
			var projectilesLength 		: Number		= _projectiles.length,
				explosionsLength 		: Number 		= _explosions.length,
				enemyProjectilesLength 	: Number 		= _enemyProjectiles.length,
				currentProjectile 		: Projectile,
				currentExplosion 		: ExplosionBase,
				currentEnemyProjectile	: Projectile;
				
			
			// Loop through the projectiles array
			for (var i : int = projectilesLength - 1; i >= 0; i--) {
				currentProjectile = _projectiles[i];
				currentProjectile.update();
			}
			
			// Loop through the enemyProjectiles array
			for (i = enemyProjectilesLength - 1; i >= 0; i--) {
				currentEnemyProjectile = _enemyProjectiles[i];
				currentEnemyProjectile.update();
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
		
		// Random generate which tower will spawn
		private function createTowers():void {
			var tower : TowerBase;
				
			for (var i:Number = 0; i < 3; i++) {
				switch (Math.floor(Math.random() * 2) + 1) {
					case 1:
						tower = _towerFactory.addTower(TowerFactory.TOWER_01, this, stage.stageWidth / i, stage.stageHeight - 20);
						break;
					case 2:
						tower = _towerFactory.addTower(TowerFactory.TOWER_02, this, stage.stageWidth / i, stage.stageHeight - 20);
						break;
				}
				_towers.push(tower);
			}
		}
		
		private function createVehicles():void {
			var vehicle : VehicleBase;
			
			for (var i:Number = 0; i < _amountOfVehicles; i++) {
				switch (Math.floor(Math.random() * 2) + 1) {
					case 1:
						vehicle = _vehicleFactory.addVehicle(VehicleFactory.CAR, this, i*50, stage.stageHeight - 13);
						break;
					case 2:
						vehicle = _vehicleFactory.addVehicle(VehicleFactory.TRUCK, this, i*50, stage.stageHeight - 13);
						break;
				}
				_vehicles.push(vehicle);
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
		
		
		// Add given projectile to projectiles array
		private function addProjectile(e : ShootEvent):void {
			if (e.projectile is EnemyMissile) {
				_enemyProjectiles.push(e.projectile);
			} else {
				_projectiles.push(e.projectile);
			}
		}
		
		// REMOVE TOWER
		private function destroyTower(e:Event):void {
			var tower 			: TowerBase = e.target as TowerBase,
				index			: int; 
				
			index = _towers.indexOf(tower);
			_towers.splice(index, 1);
			removeChild(tower);
			
			if (_towers.length == 0) {
				destroy();
			}
		}
		
		// Remove given projectile from projectilss array
		private function removeProjectile(pro:Projectile):void {
			var projectile	: Projectile = pro,
				index 		: int;
				
			removeChild(projectile);
			if (projectile is EnemyMissile) {
				index = _enemyProjectiles.indexOf(projectile);
				_enemyProjectiles.splice(index, 1);
				score += 50;
			} else {
				index = _projectiles.indexOf(projectile);
				_projectiles.splice(index, 1);		
			}
			// Update score UI
			UI.updateScore(score);
		}
		
		// Create explosion on projectile
		private function explodeProjectile(e:Event):void {
			var projectile	: Projectile = e.target as Projectile,
				explosion	: ExplosionBase;
				
			explosion = _explosionFactory.addExplosion(projectile.explosionType, this, projectile.x, projectile.y);
			_explosions.push(explosion);
			
			removeProjectile(projectile);
		}
		
		// Remove given explosion from explosions array
		private function removeExplosion(e:Event):void {
			var explosion	: ExplosionBase		= e.target as ExplosionBase,
				index		: int				= _explosions.indexOf(explosion);
				
			removeChild(explosion);
			_explosions.splice(index, 1);
		}
		
		// Loop the bg music
		private function soundLoop(e:Event):void { 
			_gameSC = _gameBG_SFX.play(0, int.MAX_VALUE, _trans);
		}
		
		// GETTER & SETTER
		public function get towers():Array {
			return _towers;
		}
		
		public function set towers(value:Array):void {
			_towers = value;
		}
		
		// Clean everything
		private function destroy():void {
			var l : uint = numChildren,
				current : DisplayObject;
			
			// Manually removing
			_waveSystem.destroy();
			removeEventListener(Event.ENTER_FRAME, update);
			stage.removeEventListener(TowerBase.SHOOT, addProjectile);
			stage.removeEventListener(WaveSystem.SHOOT, addProjectile);
			stage.removeEventListener(MouseEvent.CLICK, mouseClick);
			stage.removeEventListener(Projectile.EXPLODE, explodeProjectile);
			stage.removeEventListener(ExplosionBase.REMOVE_EXPLOSION, removeExplosion);
			_gameSC.removeEventListener(Event.SOUND_COMPLETE, soundLoop);
			_gameSC.stop();
			
			// Automatically removing
			for ( var i : int = l -1; i >= 0; i--) {
				current = getChildAt(i);
				if (current is DisplayObject) {
					if (current is DisplayObject) {
						removeChild(current);
					}
				}
				current = null;
				i = l = NaN;
				
				// Start Game
				dispatchEvent(new Event(Main.OPENMENU, false));
			}
		}
		
		
		
	}
}