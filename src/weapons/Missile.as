package weapons {
	import explosions.ExplosionFactory;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Missile extends Projectile {
		
		override internal function drawProjectile():void {
			asset = new rocketArt();
			asset.scaleX = 1.5;
			asset.scaleY = 1.5;
			
			explosionType = ExplosionFactory.EXPLOSION_BIG;
		}
		
		override internal function arm():void {
			speed = 15;
		}
		
	}

}