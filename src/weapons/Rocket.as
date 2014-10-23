package weapons {
	import explosions.ExplosionFactory;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Rocket extends Projectile {
		
		override internal function drawProjectile():void {
			asset = new rocketArt();
			
			explosionType = ExplosionFactory.EXPLOSION_SMALL;
		}
		
		override internal function arm():void {
			speed = 15;
		}
		
	}

}