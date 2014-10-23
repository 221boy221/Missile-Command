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
		
		static public const REMOVE_EXPLOSION:String = "REMOVE_EXPLOSION";
		public var asset : MovieClip;
		
		internal function setLoc(xLoc:int, yLoc:int):void {
			x = xLoc;
			y = yLoc;
		}
		
		internal function drawExplosion():void {
			
		}
		
		internal function initExplosion():void {
			addChild(asset);
		}
		
		public function update():void {
			if (asset.currentFrame == asset.framesLoaded) {
				dispatchEvent(new Event(REMOVE_EXPLOSION, true));
			}
		}
		
	}

}