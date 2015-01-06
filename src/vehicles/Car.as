package vehicles {
	import flash.events.Event;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Car extends VehicleBase {
		
		private var _vehicleArt : CarArt = new CarArt();
		
		override internal function drawVehicle():void {
			addChild(_vehicleArt);
			velocityX = (Math.floor(Math.random() * (2.75 - 2.25 + 1)) + 2.25);
		}
		
		override internal function initVehicle():void {
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		override internal function update(e:Event):void {
			super.update(e);
		}
		
	}

}