package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import towers.TowerBase;
	import towers.TowerFactory;
	import weapons.Projectile;
	import towers.Tower_01;
	import weapons.Rocket;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Game extends Sprite {
		
		private var _towers : Array = [];
		
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			
			//addEventListener(Event.ENTER_FRAME, update);
			
			createTower();
		}
		
		private function createTower():void {
			var towerFactory:TowerFactory = new TowerFactory(),
				tower : TowerBase;
			
			for (var i:Number = 0; i < 3; i++) {
				switch (Math.ceil(Math.random() * 2)) {
					case 1:
						tower = towerFactory.addTower(TowerFactory.TOWER_01, this.stage, this.stage.stageWidth / i, this.stage.stageHeight - 20);
						break;
					case 2:
						tower = towerFactory.addTower(TowerFactory.TOWER_02, this.stage, this.stage.stageWidth / i, this.stage.stageHeight - 20);
						break;
				}
				//tower = towerFactory.addTower(TowerFactory.TOWER_01, this.stage, this.stage.stageWidth / i, this.stage.stageHeight - 20);
				_towers.push(tower);
			}
		}
		
		
		
		/*
		private var _towers		:	Array = [];
		private var _rockets	:	Array = [];
		private var _tower		:	Tower_01 = new Tower_01;
		private var _isOutOfBounds	:	Boolean = false;
		
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
			getNewTower();
			getNewTower();
			getNewTower();
		}
		
		private function fire(e:ShootEvent):void {
			var _newRocket : Rocket = e.rocket;
			_rockets.push(_newRocket);
			addChild(_newRocket);
			
			trace(_rockets);
		}
		
		private function mouseDown(e:MouseEvent):void {
			getShooter();
		}
		
		private function getShooter():void {
			var shooter : int;
			
			shooter = Math.random() * _towers.length;
			_towers[shooter].shoot();
		}
		
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
		
		private function isOutOfBounds(rocket : Projectile):Boolean {
			return (rocket.x > stage.stageWidth +10 || rocket.x < -10 || rocket.y > stage.stageHeight +10 || rocket.y < -10);	
		}
		
		private function getNewTower():void {
			var _tower : Tower_01 = new Tower_01;
			addChild(_tower);
			_tower.x = Math.random() * stage.stageWidth;
			_tower.y = stage.stageHeight - 100;
			_towers.push(_tower);
			_tower.addEventListener(Tower_01.SHOOT, fire);
		}
		*/
		
	}

}