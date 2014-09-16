package  {
	import events.ShootEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Game extends Sprite {
		
		private var _towers		:	Array = [];
		private var _rockets	:	Array = [];
		private var _tower		:	Tower = new Tower;
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
			var _tower : Tower = new Tower;
			addChild(_tower);
			_tower.x = Math.random() * stage.stageWidth;
			_tower.y = stage.stageHeight - 100;
			_towers.push(_tower);
			_tower.addEventListener(Tower.SHOOT, fire);
		}
		
		
	}

}