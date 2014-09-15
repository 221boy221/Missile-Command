package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Rocket extends Sprite {
		
		private var _rocketArt : rocketArt;
		private var _speed : Number = 10;
		private var _stepX : Number;
		private var _stepY : Number;
		// Check
		private var isOutOfBounds : Boolean = false;
		private var _p : Point;
		
		
		public function Rocket() {
			_rocketArt = new rocketArt;
			addChild(_rocketArt);
		}
		
		public function setDirection(angle:Number):void {
			var _diffX : Number,
				_diffY : Number,
				_radian : Number,
				_rotationInRadians : Number;
			
			// Turn parameter angle into Radians
			_radian = angle / (180 / Math.PI);
			
			// Get coördinates to fly to
			_stepX = Math.cos(_radian) * _speed;
			_stepY = Math.sin(_radian) * _speed;
			
			_p = new Point(mouseX, mouseY);
			_p = localToGlobal(_p);
			
			// Makes the rocket point into the direction it's going
			_diffX = _stepX - this.x;
			_diffY = _stepY - this.y;
			_rotationInRadians = Math.atan2(_diffY, _diffX);
			rotation = _rotationInRadians * (180 / Math.PI);
			trace(_p);
		}
		
		public function update():void {
			// Fly to the coördinates
			this.x += _stepX;
			this.y += _stepY;
			
			if (this.x == _p.x || this.y == _p.y) {
				trace("remove / explode");
			}
			
			// Check if rocket is out of bounds
			if (this.x > stage.stageWidth + 10 || this.x < -10 || this.y > stage.stageHeight +10 || this.y < -10) {
				isOutOfBounds = true;
			}
		}
		
		private function get outOfBounds():Boolean {
			return isOutOfBounds;
		}
	}

}