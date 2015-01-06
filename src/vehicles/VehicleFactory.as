package vehicles {
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class VehicleFactory {
		
		public static const CAR		: uint = 0;
		public static const TRUCK	: uint = 1;
		
		public function addVehicle(vehicleType:uint, target:DisplayObjectContainer, xLoc:int, yLoc:int):VehicleBase {
			var vehicle:VehicleBase = this.createVehicle(vehicleType);
			
			vehicle.drawVehicle();
			vehicle.setLoc(xLoc, yLoc);
			target.addChild(vehicle);
			vehicle.initVehicle();
			
			return vehicle;
		}
		
		private function createVehicle(vehicleType:uint):VehicleBase {
			switch(vehicleType) {
				case CAR:
					return new Car();
					break;
				case TRUCK:
					return new Truck();
					break;
				default:
					throw new Error("Invalid kind of vehicle specified");
					return null;
			}
		}
		
	}

}