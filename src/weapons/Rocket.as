package weapons {
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Rocket extends Projectile {
		
		private var _rocketArt : rocketArt = new rocketArt;
		
		override internal function drawProjectile():void {
			addChild(_rocketArt);
		}
		
		override internal function arm():void {
			speed = 10;
		}
		
	}

}