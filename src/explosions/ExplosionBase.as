package explosions {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import explosions.ExplosionBase;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	
	public class ExplosionBase extends Sprite {
		
		public static const REMOVE_EXPLOSION	: String 		= "REMOVE_EXPLOSION";
		public var asset						: MovieClip;
		private var _explosion_SFX				: Explosion_SFX	= new Explosion_SFX;
		
		internal function setLoc(xLoc:int, yLoc:int):void {
			x = xLoc;
			y = yLoc;
		}
		
		internal function drawExplosion():void {
			
		}
		
		internal function initExplosion():void {
			addChild(asset);
			_explosion_SFX.play();
		}
		
		public function update():void {
			if (asset.currentFrame == asset.framesLoaded) {
				dispatchEvent(new Event(REMOVE_EXPLOSION, true));
			}
		}
		
	}

}