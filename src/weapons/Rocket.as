package weapons {
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Rocket extends Projectile {
		
		override internal function drawProjectile():void {
			asset = new rocketArt();
		}
		
		override internal function arm():void {
			speed = 15;
		}
		
	}

}