package weapons {
	import flash.display.DisplayObjectContainer;
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import towers.TowerBase;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	
	// Skeleton for weapons
	public class Weapon {
		
		public function fire(projectileType:uint, targetStage:DisplayObjectContainer, x:int, y:int, angle:Number, target:Point, selectedTower:TowerBase = null):Projectile {
			var projectile : Projectile = createProjectile(projectileType);
			
			projectile.drawProjectile();
			projectile.setLoc(x, y);
			projectile.setDir(angle, target);
			projectile.tower(selectedTower);
			projectile.arm();
			targetStage.addChild(projectile);
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