package weapons {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import weapons.Projectile;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Rocket extends Projectile {
		
		function Rocket() {
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private var _rocketArt : rocketArt = new rocketArt;
		
		override internal function drawProjectile():void {
			addChild(_rocketArt);
		}
		override internal function arm():void {
			speed = 5;
		}
		override internal function update(e:Event):void {
			super.update(e);
		}
		
	}

}