package explosions {
	/**
	 * ...
	 * @author Boy Voesten
	 */
	internal class ExplosionSmall extends ExplosionBase {
		
		override internal function drawExplosion():void {
			asset = new ExplosionArtSmall();
		}
		
	}
	
}