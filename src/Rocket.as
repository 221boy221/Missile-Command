package  {
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Rocket extends Sprite {
		
		private var _rocketArt : rocketArt;
		private var _speed : Number = 10;
		// Direction
		private var _stepX : Number;
		private var _stepY : Number;
		private var _diffX : Number;
		private var _diffY : Number;
		private var _radian : Number;
		private var _rotationInRadians : Number;
		// Check
		private var isOutOfBounds : Boolean = false;
		
		
		public function Rocket() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			addEventListener(Event.ENTER_FRAME, update);
			
			_rocketArt = new rocketArt;
			addChild(_rocketArt);
		}
		
		private function update(e:Event):void {
			// Fly to the coördinates
			this.x += _stepX;
			this.y += _stepY;
			
			// Check if rocket is out of bounds
			if (this.x > stage.stageWidth + 10 || this.x < -10 || this.y > stage.stageHeight +10 || this.y < -10) {
				isOutOfBounds = true;
			}
		}
		
		public function setDirection(angle:Number):void {
			// Turn parameter angle into Radians
			_radian = angle / (180 / Math.PI);
			
			// Get coördinates to fly to
			_stepX = Math.cos(_radian) * _speed;
			_stepY = Math.sin(_radian) * _speed;
			
			// Makes the rocket point into the direction it's going
			_diffX = _stepX - this.x;
			_diffY = _stepY - this.y;
			_rotationInRadians = Math.atan2(_diffY, _diffX);
			rotation = _rotationInRadians * (180 / Math.PI);
			//trace(this.x + " and " + this.y);
		}
		
		private function get outOfBounds():Boolean {
			return isOutOfBounds;
		}
	}

}