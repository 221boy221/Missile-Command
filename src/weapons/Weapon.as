package weapons {
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	
	// Skeleton for weapons
	public class Weapon {
		
		public function fire(projectileType:uint, target:Stage, x:int, y:int, angle:Number):Projectile {
			var projectile : Projectile = createProjectile(projectileType);
			
			projectile.drawProjectile();
			projectile.setLoc(x, y);
			projectile.setDir(angle);
			projectile.arm();
			target.addChild(projectile);
			projectile.release();
			
			return projectile;
		}
		
		// ABSTRACT
		protected function createProjectile(cWeapon:uint):Projectile {
			throw new IllegalOperationError("Abstract method hasn't been overriden, please override.");
			return null;
		}
		
	}

}