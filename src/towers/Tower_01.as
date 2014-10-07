package towers {
	import events.ShootEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import weapons.Rocket;
	import towers.Tower_01;
	import weapons.TowerWeapon;
	import weapons.Weapon;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	internal class Tower_01 extends Tower {
		
		
		private var _towerArt : TowerCannon = new TowerCannon();
		
		public function Tower_01():void {
			super();
		}
		
		override internal function drawTower():void {
			addChild(_towerArt);
		}
		
		override internal function initTower():void {
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, fire2);
		}
		
		private function fire2(e:MouseEvent):void {
			super.fire(e, TowerWeapon.MISSILE);
			
		}
		
		override internal function update(e:Event):void {
			super.update(e);
		}
		
		/*
		public function shoot():void {
			var newRocket : Rocket,
				_radians : Number,
				_speedX : Number,
				_speedY : Number;
			
			newRocket = new Rocket;
			
			_radians = _towerArt.rotation * Math.PI / 180;
			_speedX = 1;
			_speedY = 1;
			
			// Give the rocket it's spawn info
			newRocket.x = this.x + 20 * Math.cos(_radians);
			newRocket.y = this.y + 20 * Math.sin(_radians);
			newRocket.setDirection(_towerArt.rotation);
			
			// Tell the game that we just shot a rocket
			dispatchEvent(new ShootEvent(SHOOT, newRocket));
		}
		*/
		
	}

}