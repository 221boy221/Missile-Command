package weapons {
	import explosions.ExplosionFactory;
	import flash.events.Event;
	
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
		
		override internal function checkDir():void {
			if (this.y <= _clickTarget.y) {
				super.explode();
			}
		}
		
	}

}