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
		private var _target : Point;
		
		
		public function Rocket() {
			_rocketArt = new rocketArt;
			addChild(_rocketArt);
		}
		
		public function setDirection(angle:Number):void {
			var _radian : Number,
				_rotationInRadians : Number;
			
			// Rotate the rocket
			rotation = angle;

			// Turn parameter angle into Radians
			_radian = angle / (180 / Math.PI);
			
			// Get coördinates to fly to
			_stepX = Math.cos(_radian) * _speed;
			_stepY = Math.sin(_radian) * _speed;
			
			// Get click position
			_target = new Point(mouseX, mouseY);
			_target = localToGlobal(_target);
		}
		
		public function update():void {
			var a2 : Number = (_target.x - this.x) * (_target.x - this.x),
				b2 : Number = (_target.y - this.y) * (_target.y - this.y);
				
			// Fly to the coördinates
			this.x += _stepX;
			this.y += _stepY;
			
			// Check if rocket arrived
			if (Math.sqrt(a2 + b2) < 5) {
				trace("remove / explode");
				// Strange delay
			}
			
			// Check if rocket is out of bounds
			if (this.x > stage.stageWidth +10 || this.x < -10 || this.y > stage.stageHeight +10 || this.y < -10) {
				isOutOfBounds = true;
			}
		}
		
		private function get outOfBounds():Boolean {
			return isOutOfBounds;
		}
	}

}