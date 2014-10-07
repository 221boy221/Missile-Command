package weapons {
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Missile extends Projectile {
		
		private var _rocketArt : rocketArt = new rocketArt;
		
		override internal function drawProjectile():void {
			addChild(_rocketArt);
			_rocketArt.scaleX = 2;
			_rocketArt.scaleY = 2;
		}
		
		override internal function arm():void {
			speed = -5;
		}
		
	}

}