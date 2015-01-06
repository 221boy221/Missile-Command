package explosions {
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class ExplosionFactory {
		
		public static const EXPLOSION_SMALL	: uint = 0;
		public static const EXPLOSION_BIG : uint = 1;
		
		public function addExplosion(explosionType:uint, target:DisplayObjectContainer, xLoc:int, yLoc:int):ExplosionBase {
			var explosion:ExplosionBase = this.createExplosion(explosionType);
			
			explosion.drawExplosion();
			explosion.setLoc(xLoc, yLoc);
			target.addChild(explosion);
			explosion.initExplosion();
			
			return explosion;
		}
		
		private function createExplosion(explosionType:uint):ExplosionBase {
			switch(explosionType) {
				case EXPLOSION_SMALL:
					return new ExplosionSmall();
					break;
				case EXPLOSION_BIG:
					return new ExplosionBig();
					break;
				default:
					throw new Error("Invalid kind of explosion specified");
					return null;
			}
		}
		
	}

}