package archive {
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
		
		public static const SHOOT	:	String		= "Shoot";
		private var _towerArt		:	TowerCannon	= new TowerCannon;
		
		public function Tower_01() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			
			addEventListener(Event.ENTER_FRAME, update);
			addChild(_towerArt);
		}
		
		public function update(e:Event):void {
			pointAtMouse();
		}
		
		private function pointAtMouse():void {
			var _mouseP : Point,
				_diffX : Number,
				_diffY : Number,
				_rotationInRadians : Number;
			
			// Calc diff between player and mouse
			_mouseP = new Point(mouseX, mouseY);
			_mouseP = localToGlobal(_mouseP);
			_diffX = _mouseP.x - this.x;
			_diffY = _mouseP.y - this.y;
			
			// Change the values to radians and rotate the tower
			_rotationInRadians = Math.atan2(_diffY, _diffX);
			rotation = _rotationInRadians * (180 / Math.PI);
		}
		
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
		
	}

}