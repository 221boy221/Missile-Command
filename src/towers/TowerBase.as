package towers {
	import events.ShootEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import weapons.Projectile;
	import weapons.TowerWeapon;
	import weapons.Weapon;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	
	// ABSTRACT Class
	public class TowerBase extends Sprite {
		
		private var weapon : Weapon = new TowerWeapon();
		public static const SHOOT : String = new String;
		protected var projectileType : uint;
		
		internal function setLoc(xLoc:int, yLoc:int):void {
			x = xLoc;
			y = yLoc;
		}
		
		// ABSTRACT Methods
		internal function drawTower():void { }
		internal function initTower():void { }
		
		internal function update(e:Event):void {
			pointAtMouse();
		}
		
		internal function pointAtMouse():void {
			var _mouseP : Point,
				_diffX : Number,
				_diffY : Number,
				_rotationInRadians : Number;
			
			// Calc diff between player and mouse
			_mouseP = new Point(mouseX, mouseY);
			_mouseP = localToGlobal(_mouseP);
			_diffX = _mouseP.x - this.x;
			_diffY = _mouseP.y - this.y;
			
			// Change the values to radians and rotate the tower
			_rotationInRadians = Math.atan2(_diffY, _diffX);
			rotation = _rotationInRadians * (180 / Math.PI);
		}
		
		// Every tower is able to shoot, but the game decides when to run it
		public function shoot():void {
			var _radians : Number,
				_spawnPosX : Number,
				_spawnPosY : Number,
				projectile : Projectile;
				
			_radians = rotation * Math.PI / 180;
			_spawnPosX = x + 20 * Math.cos(_radians);
			_spawnPosY = y + 20 * Math.sin(_radians);
			
			projectile = weapon.fire(projectileType, stage, _spawnPosX, _spawnPosY, rotation);
			dispatchEvent(new ShootEvent(SHOOT, projectile));
		}
	}

}