package weapons {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import towers.TowerBase;
	import weapons.Projectile;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Projectile extends Sprite {
		
		static public const EXPLODE	:String 		= "EXPLODE";
		internal var asset 			: MovieClip;
		internal var speed 			: Number;
		internal var _stepX 		: Number;
		internal var _stepY 		: Number;
		internal var _target 		: Point;
		internal var _clickTarget 	: Point;
		internal var _selectedTower : TowerBase;
		public var explosionType 	: uint;
		
		// ABSTRACT
		internal function drawProjectile():void {
			
		}
		
		internal function tower(selectedTower:TowerBase):void {
			if (selectedTower) {
				_selectedTower = selectedTower;
			}
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
		internal function setDir(angle:Number, target:Point):void {
			var _radian : Number;
			
			// Put parameter into var
			rotation = angle;
			
			// Turn var angle into Radians
			_radian = angle / (180 / Math.PI);
						
			// Get coördinates to fly to
			_stepX = Math.cos(_radian);
			_stepY = Math.sin(_radian);
			
			// Get click position
			_target = new Point(target.x, target.y);
			_clickTarget = localToGlobal(_target);
		}
		
		// Check if projectile arrived
		internal function checkDir():void {
			
		}
		
		public function update():void {
			// Fly to the coördinates
			x += _stepX * speed;
			y += _stepY * speed;
			
			checkDir();
		}
		
		public function explode():void {
			dispatchEvent(new Event(EXPLODE, true));
		}
		
	}

}