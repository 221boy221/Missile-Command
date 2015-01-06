package vehicles {
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	
	// ABSTRACT Class
	public class VehicleBase extends Sprite {
		
		protected var velocityX : Number;
		
		// ABSTRACT Methods
		internal function drawVehicle():void {
			
		}
		
		internal function setLoc(xLoc:int, yLoc:int):void {
			x = xLoc;
			y = yLoc;
		}
		
		internal function initVehicle():void {
			
		}
		
		internal function update(e:Event):void {
			
			if (x < -100) {
				velocityX = Math.abs(velocityX);
			} else if (x > 900) {
				velocityX = -Math.abs(velocityX);
			}
			
			if (velocityX > 0) {
				scaleX = 1;
			} else {
				scaleX = -1;
			}
			
			x += velocityX;
		}
		
	}

}