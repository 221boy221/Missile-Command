package weapons {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import weapons.Projectile;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Projectile extends Sprite {
		
		internal var speed	: Number = 5;
		internal var _stepX : Number;
		internal var _stepY : Number;
		internal var _mouseP : Point;
		internal var a2 : Number;
		internal var b2 : Number;
		
		// ABSTRACT
		internal function drawProjectile():void {	}
		
		internal function arm():void {
			//speed = 5;
		}
		
		internal function release():void {
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		internal function setLoc(xLoc:int, yLoc:int):void {
			x = xLoc;
			y = yLoc;
		}
		
		
		internal function setDir(angle:Number):void {
			var _radian : Number;
			
			// Put parameter into var
			rotation = angle;
			trace("rotation: " + rotation);
			
			// Turn var angle into Radians
			_radian = angle / (180 / Math.PI);
			trace("radian: " + _radian);
			
			// Get coördinates to fly to
			_stepX = Math.cos(_radian) * speed;
			_stepY = Math.sin(_radian) * speed;
			trace("stepX: " + _stepX);
			trace("stepY: " + _stepY);
			
			// Get click position
			_mouseP = new Point(mouseX, mouseY);
			trace("mouseP: " + _mouseP);
			
			_mouseP = localToGlobal(_mouseP);
			trace("mouseP local to global: " + _mouseP);
		}
		
		internal function checkDir():void {
			// Check if projectile arrived
			if (Math.sqrt(a2 + b2) < 5) {
				trace("remove / explode");
				// sometimes detects it twice
				// Tell the game that we just shot a rocket
				//dispatchEvent(new ShootEvent(REMOVE, this));
			}
			
			// Check if out of bounds
			if (x > stage.stageWidth +10 || x < -10 || y > stage.stageHeight +10 || y < -10) {
				removeEventListener(Event.ENTER_FRAME, update);
				stage.removeChild(this);
			}
		}
		
		internal function update(e:Event):void {
			// Fly to the coördinates
			x += _stepX;
			y += _stepY;
			
			// Store projectile's current pos
			a2 = (_mouseP.x - x) * (_mouseP.x - x);
			b2 = (_mouseP.y - y) * (_mouseP.y - y);
			
			// Check for removal
			checkDir();
		}
		
		
	}

}