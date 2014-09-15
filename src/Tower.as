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
			var _p : Point,
				_diffX : Number,
				_diffY : Number,
				_rotationInRadians : Number;
			
			// Calc diff between player and mouse
			_p = new Point(mouseX, mouseY);
			_p = localToGlobal(_p);
			_diffX = _p.x - this.x;
			_diffY = _p.y - this.y;
			
			// Change the values to radians and rotate the tower
			_rotationInRadians = Math.atan2(_diffY, _diffX);
			_towerArt.rotation = _rotationInRadians * (180 / Math.PI);
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
			
			newRocket.x = this.x + 20 * Math.cos(_radians);
			newRocket.y = this.y + 20 * Math.sin(_radians);
			newRocket.setDirection(_towerArt.rotation);
			
			// Tell the game that we just shot a rocket
			dispatchEvent(new ShootEvent(SHOOT, newRocket));
		}
		
	}

}