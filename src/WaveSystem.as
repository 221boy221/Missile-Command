package  {
	import events.ShootEvent;
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
	public class WaveSystem extends Sprite {
		
		public static const SHOOT : String = "SHOOT";
		private var weapon : Weapon = new EnemyWeapon();
		private var _game : Game;		
		// Wave system
		private var _wave				:	int	= 1;
		private var _timeBetweenWaves	:	Timer;
		private var _enemySpawntime		:	Timer;
		private var _spawnsPerWave		:	int;
		private var _spawnSpeed			:	Number	= 2050;
		private var _txtWave : TextField = new TextField();
		
		public function WaveSystem(game:Game) {
			addEventListener(Event.ADDED_TO_STAGE, init);
			_game = game;
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			
			// Text will be added here so that if you decide to remove the wave system
			// you won't have to bother getting rid of the left-overs in the game / other class(es).
			_txtWave.text = ("Wave: " + _wave);
			_txtWave.x = 20;
			_txtWave.y = 40;
			_txtWave.selectable = false;
			addChild(_txtWave);
			
			_timeBetweenWaves = new Timer(4000, 2);
			_timeBetweenWaves.addEventListener(TimerEvent.TIMER, nextWave);	
			_timeBetweenWaves.start();
		}
		
		private function nextWave(e:TimerEvent):void {
			if (_timeBetweenWaves.currentCount > 1) {
				
				if (_spawnSpeed >= 500) {
					_spawnSpeed -= 50;
				}
				_spawnsPerWave = 10 * _wave;
				_enemySpawntime = new Timer(_spawnSpeed, _spawnsPerWave);
				_enemySpawntime.addEventListener(TimerEvent.TIMER, nextSpawn);
				_enemySpawntime.start();
				_timeBetweenWaves.reset();
				
				trace("WAVE: " + _wave);
				trace("Spawntime is: " + _spawnSpeed);
				
				// Update UI
				_txtWave.text = ("Wave: " + _wave);
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
			var enemyProjectile : Projectile,
				allTowers : Array = [],
				selectedTower : TowerBase,
				target : Point,
				spawnPosX : Number,
				spawnPosY : Number,
				_rotationInRadians : Number,
				_diffX : Number,
				_diffY : Number;
			
			// Grab one out of all the towers in the tower array from the game
			allTowers = _game.towers;
			selectedTower = allTowers[Math.floor(Math.random() * allTowers.length)];
			target = new Point(selectedTower.x, selectedTower.y);

			// Randomly spawn on X
			spawnPosX = stage.stageWidth * Math.random();
			spawnPosY = 10;
			
			_diffX = target.x - spawnPosX;
			_diffY = target.y - spawnPosY;
			_rotationInRadians = Math.atan2(_diffY, _diffX);
			rotation = _rotationInRadians * (180 / Math.PI);
			
			enemyProjectile = weapon.fire(EnemyWeapon.ENEMYMISSILE, this.stage, spawnPosX, spawnPosY, rotation, target);
			dispatchEvent(new ShootEvent(SHOOT, enemyProjectile, true));
		}
		
	}

}