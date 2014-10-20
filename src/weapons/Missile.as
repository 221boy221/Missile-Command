package weapons {
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Missile extends Projectile {
		
		override internal function drawProjectile():void {
			asset = new rocketArt();
			asset.scaleX = 2;
			asset.scaleY = 2;
		}
		
		override internal function arm():void {
			speed = 3;
		}
		
	}

}