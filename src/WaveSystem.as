package  {
	import events.ShootEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Timer;
	import towers.TowerBase;
	import weapons.EnemyWeapon;
	import weapons.Projectile;
	import weapons.Weapon;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class WaveSystem {
		
		public static const SHOOT		: String	= "SHOOT";
		private var _weapon				: Weapon	= new EnemyWeapon();
		private var _game				: Game;		
		private var _ui					: UI		= new UI();
		// Wave system
		private var _wave				: int		= 1;
		private var _timeBetweenWaves	: Timer;
		private var _enemySpawntime		: Timer;
		private var _spawnsPerWave		: int;
		private var _spawnSpeed			: Number	= 2050;
		
		public function WaveSystem(game:Game) {
			_game = game;
			
			_timeBetweenWaves = new Timer(4000, 2);
			_timeBetweenWaves.addEventListener(TimerEvent.TIMER, nextWave);	
			_timeBetweenWaves.start();
		}
		
		private function nextWave(e:TimerEvent):void {
			if (_timeBetweenWaves.currentCount > 1) {
				
				if (_spawnSpeed >= 500) {
					_spawnSpeed -= 150;
				}
				_spawnsPerWave = 10 * _wave;
				_enemySpawntime = new Timer(_spawnSpeed, _spawnsPerWave);
				_enemySpawntime.addEventListener(TimerEvent.TIMER, nextSpawn);
				_enemySpawntime.start();
				_timeBetweenWaves.reset();
				
				// Update wave UI
				//_ui.updateWave(_wave);
				UI.updateWave(_wave);
				
				trace("WAVE: " + _wave);
				trace("Spawntime is: " + _spawnSpeed);
			}
		}
		
		private function nextSpawn(e:TimerEvent):void {
			spawnEnemyMissile();
			if (_enemySpawntime.currentCount == _spawnsPerWave) {
				_wave++;
				_timeBetweenWaves.start();
				_enemySpawntime.reset();
			}
		}
		
		private function spawnEnemyMissile():void {
			var enemyProjectile 	: Projectile,
				allTowers 			: Array = [],
				selectedTower 		: TowerBase,
				target 				: Point,
				spawnPosX 			: Number,
				spawnPosY 			: Number,
				rotationInRadians 	: Number,
				rot					: Number,
				diffX 				: Number,
				diffY 				: Number;
			
			// Grab one out of all the towers in the tower array from the game
			allTowers = _game.towers;
			selectedTower = allTowers[Math.floor(Math.random() * allTowers.length)];
			target = new Point(selectedTower.x, selectedTower.y);

			// Randomly spawn on X
			spawnPosX = _game.stage.stageWidth * Math.random();
			spawnPosY = 10;
			
			diffX = target.x - spawnPosX;
			diffY = target.y - spawnPosY;
			rotationInRadians = Math.atan2(diffY, diffX);
			rot = rotationInRadians * (180 / Math.PI);
			
			enemyProjectile = _weapon.fire(EnemyWeapon.ENEMYMISSILE, _game, spawnPosX, spawnPosY, rot, target, selectedTower);
			
			_game.dispatchEvent(new ShootEvent(SHOOT, enemyProjectile, true));
		}
		
		public function destroy():void {
			_timeBetweenWaves.removeEventListener(TimerEvent.TIMER, nextWave);	
			_enemySpawntime.removeEventListener(TimerEvent.TIMER, nextSpawn);
		}
		
	}

}