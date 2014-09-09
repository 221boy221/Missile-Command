package  {
	import events.ShootEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Tower extends Sprite {
		
		public static const SHOOT : String = "Shoot";
		
		private var _towerArt : TowerCannon = new TowerCannon;
		
		public function Tower() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			
			addEventListener(Event.ENTER_FRAME, update);
			addChild(_towerArt);
		}
		
		private function update(e:Event):void {
			pointAtMouse();
		}
		
		private function pointAtMouse():void {
			var p : Point;
			var _diffX : Number;
			var _diffY : Number;
			var _rotationInRadians : Number;
			
			// Calc diff between player and mouse
			p = new Point(mouseX, mouseY);
			p = localToGlobal(p);
			_diffX = p.x - this.x;
			_diffY = p.y - this.y;
			
			// Change the values to radians and rotate the tower
			_rotationInRadians = Math.atan2(_diffY, _diffX);
			_towerArt.rotation = _rotationInRadians * (180 / Math.PI);
		}
		
		public function shoot():void {
			trace("Shooting a rocket");
			
			var newRocket : Rocket;
			var _radians : Number;
			var _speedX : Number;
			var _speedY : Number;
			
			newRocket = new Rocket();
			newRocket.setDirection(rotation);
			newRocket.x = this.x;
			newRocket.y = this.y;
			
			_radians = rotation * Math.PI / 180;
			_speedX = 1;
			_speedY = 1;
			addChild(newRocket);
			
			// Tell the game that we just shot a rocket
			dispatchEvent(new ShootEvent(SHOOT, newRocket));
		}
		
	}

}