package vehicles {
	import flash.events.Event;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Truck extends VehicleBase {
		
		private var _vehicleArt : TruckArt = new TruckArt();
		
		override internal function drawVehicle():void {
			addChild(_vehicleArt);
			velocityX = (Math.floor(Math.random() * (2.25 - 2 + 1)) + 2);
		}
		
		override internal function initVehicle():void {
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		override internal function update(e:Event):void {
			super.update(e);
		}
		
	}

}