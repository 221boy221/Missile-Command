package towers {
	import events.ShootEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import weapons.Projectile;
	import weapons.TowerWeapon;
	import weapons.Weapon;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	
	// ABSTRACT Class
	public class TowerBase extends Sprite {
		
		public static const SHOOT		: String 	= "Shoot";
		public static const TOWER_DOWN	: String 	= "Tower Down";
		public var distance				: Number;
		protected var projectileType	: uint;
		private var _weapon				: Weapon	= new TowerWeapon();
		private var _fire_SFX			: Fire_SFX	= new Fire_SFX;
		private var _hp					: int 		= 3;
		
		// ABSTRACT Methods
		internal function drawTower():void { 
			
		}
		
		internal function setLoc(xLoc:int, yLoc:int):void {
			x = xLoc;
			y = yLoc;
		}
		
		internal function initTower():void {
			
		}
		
		internal function update(e:Event):void {
			pointAtMouse();
		}
		
		internal function pointAtMouse():void {
			var mouseP 				: Point,
				diffX 				: Number,
				diffY 				: Number,
				masureDistance 		: Vector3D,
				rotationInRadians 	: Number;
			
			// Calc diff between player and mouse
			mouseP = new Point(mouseX, mouseY);
			mouseP = localToGlobal(mouseP);
			diffX = mouseP.x - this.x;
			diffY = mouseP.y - this.y;
			
			masureDistance = new Vector3D(diffX, diffY);
			distance = masureDistance.length;
			
			// Change the values to radians and rotate the tower
			rotationInRadians = Math.atan2(diffY, diffX);
			rotation = rotationInRadians * (180 / Math.PI);
		}
		
		// Every tower is able to shoot, but the game decides when to run it
		public function shoot():void {
			var radians 		: Number,
				spawnPosX 		: Number,
				spawnPosY 		: Number,
				target 			: Point 		= new Point(mouseX, mouseY),
				projectile 		: Projectile;
				
			radians = rotation * Math.PI / 180;
			spawnPosX = x - 10 * Math.cos(radians);
			spawnPosY = y - 10 * Math.sin(radians);
			
			projectile = _weapon.fire(projectileType, parent, spawnPosX, spawnPosY, rotation, target);
			dispatchEvent(new ShootEvent(SHOOT, projectile, true));
			
			_fire_SFX.play();
		}
		
		public function takeDamage(dmg : int):void {
			_hp -= dmg;
			trace(_hp);
			if (_hp <= 0) {
				dispatchEvent(new Event(TOWER_DOWN, true));
			}
		}
	}

}