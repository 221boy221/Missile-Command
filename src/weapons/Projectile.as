package weapons {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import weapons.Projectile;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Projectile extends Sprite {
		
		static public const EXPLODE:String = "EXPLODE";
		public var asset : MovieClip;
		internal var speed : Number;
		internal var _stepX : Number;
		internal var _stepY : Number;
		internal var _mouseP : Point;
		
		// ABSTRACT
		internal function drawProjectile():void {
		
		}
		
		internal function arm():void { 
			speed = 5;
		}
		
		internal function release():void {
			addChild(asset);
		}
		
		internal function setLoc(xLoc:int, yLoc:int):void {
			x = xLoc;
			y = yLoc;
		}
		
		// Calc and collect all the info
		internal function setDir(angle:Number):void {
			var _radian : Number;
			
			// Put parameter into var
			rotation = angle;
			
			// Turn var angle into Radians
			_radian = angle / (180 / Math.PI);
						
			// Get coördinates to fly to
			_stepX = Math.cos(_radian);
			_stepY = Math.sin(_radian);
			
			// Get click position
			_mouseP = new Point(mouseX, mouseY);
			_mouseP = localToGlobal(_mouseP);
		}
		
		// Check if projectile arrived
		internal function checkDir():void {
			if (this.y <= _mouseP.y) {
				dispatchEvent(new Event(EXPLODE, true));
			}
		}
		
		public function update():void {
			// Fly to the coördinates
			x += _stepX * speed;
			y += _stepY * speed;
			
			checkDir();
		}		
		
	}

}