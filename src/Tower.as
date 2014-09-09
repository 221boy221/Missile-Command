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
		private var p : Point;
		private var _diffX : Number;
		private var _diffY : Number;
		private var _rotationInRadians : Number;
		
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
			var newRocket : Rocket = new Rocket();
			newRocket.setDirection(rotation);
			newRocket.x = this.x;
			newRocket.y = this.y;
			
			var _radians : Number = rotation * Math.PI / 180;
			var _speedX : Number = 1;
			var _speedY : Number = 1;
			addChild(newRocket);
			
			// Todo: Push the newRocket into the rockets array
			// rockets.push(newRocket);
			dispatchEvent(new ShootEvent(SHOOT, newRocket));
		}
		
	}

}