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
		
		private var _removeAble:Boolean;
		
		internal var speed	: Number;
		internal var _stepX : Number;
		internal var _stepY : Number;
		internal var _mouseP : Point;
		internal var a2 : Number;
		internal var b2 : Number;
		public var asset : MovieClip;
		
		// ABSTRACT
		internal function drawProjectile():void { }
		
		internal function arm():void { 
			speed = 5;
		}
		
		internal function release():void {
			addChild(asset);
			asset.gotoAndStop(1);
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
			
			if (this.y <= _mouseP.y) {
				trace("Remove me");
				removeAble = true;
			}
			
		}
		
		public function update():void {
			// Fly to the coördinates
			x += _stepX * speed;
			y += _stepY * speed;
			
			// Store projectile's current pos
			a2 = (_mouseP.x - x) * (_mouseP.x - x);
			b2 = (_mouseP.y - y) * (_mouseP.y - y);
			
			checkDir();
		}
		
		public function get removeAble():Boolean 
		{
			return _removeAble;
		}
		
		public function set removeAble(value:Boolean):void 
		{
			_removeAble = value;
		}
		
		
	}

}