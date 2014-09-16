package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Rocket extends Projectile {
		
		public static var ARRIVED : Boolean;
		private var _stepX : Number;
		private var _stepY : Number;
		private var _mouseP : Point;
		
		public function Rocket() {
			
			projectileName = "Rocket";
			projectileArt = new rocketArt;
			speed = 10;
			
			addChild(projectileArt);
		}
		
		public function setDirection(angle:Number):void {
			var _radian : Number,
				_rotationInRadians : Number;
			
			// Rotate the rocket
			rotation = angle;

			// Turn parameter angle into Radians
			_radian = angle / (180 / Math.PI);
			
			// Get coördinates to fly to
			_stepX = Math.cos(_radian) * speed;
			_stepY = Math.sin(_radian) * speed;
			
			// Get click position
			_mouseP = new Point(mouseX, mouseY);
			_mouseP = localToGlobal(_mouseP);
		}
		
		override public function update():void {
			var a2 : Number = (_mouseP.x - this.x) * (_mouseP.x - this.x),
				b2 : Number = (_mouseP.y - this.y) * (_mouseP.y - this.y);
				
			// Fly to the coördinates
			this.x += _stepX;
			this.y += _stepY;
			
			// Check if rocket arrived
			if (Math.sqrt(a2 + b2) < 5) {
				trace("remove / explode");
				// Strange delay
				ARRIVED = true;
				
			}
		}
		
	}

}