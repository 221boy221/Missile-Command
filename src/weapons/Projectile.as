package weapons {
	import events.RemoveEvent;
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
		
		//public static var REMOVE : String;
		
		internal var speed	: Number;
		internal var _stepX : Number;
		internal var _stepY : Number;
		internal var _mouseP : Point;
		internal var a2 : Number;
		internal var b2 : Number;
		internal var asset : MovieClip;
		
		// ABSTRACT
		internal function drawProjectile():void { }
		
		internal function arm():void { 
			speed = 5;
		}
		
		internal function release():void {
			addChild(asset);
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
			
			// Turn var angle into Radians
			_radian = angle / (180 / Math.PI);
						
			// Get coördinates to fly to
			_stepX = Math.cos(_radian);
			_stepY = Math.sin(_radian);
			
			// Get click position
			_mouseP = new Point(mouseX, mouseY);
			_mouseP = localToGlobal(_mouseP);
			
		}
		
		internal function checkDir():void {
			// Check if projectile arrived
			if (Math.sqrt(a2 + b2) < 10) {
				asset.gotoAndStop(2);
				speed = 0;
				trace("- Remove");
			}
			/*
			// Check if out of bounds
			if (x > stage.stageWidth +10 || x < -10 || y > stage.stageHeight +10 || y < -10) {
				removeEventListener(Event.ENTER_FRAME, update);
				stage.removeChild(this);
			}
			*/
		}
		
		internal function update(e:Event):void {
			// Fly to the coördinates
			x += _stepX * speed;
			y += _stepY * speed;
			
			// Store projectile's current pos
			a2 = (_mouseP.x - x) * (_mouseP.x - x);
			b2 = (_mouseP.y - y) * (_mouseP.y - y);
			
			// Check for removal
			if (asset.currentFrame == asset.totalFrames) {
				removeEventListener(Event.ENTER_FRAME, update);
				stage.removeChild(this);
			} else {
				checkDir();	
			}
		}
		
		
	}

}