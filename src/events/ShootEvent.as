package events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class ShootEvent extends Event {
		
		private var _rocket : Rocket;
		
		public function ShootEvent(type:String, rocket : Rocket) {
			super(type);
			
			_rocket = rocket;
		}
		
		public function get rocket():Rocket {
			return _rocket;
		}
		
		public function set rocket(value:Rocket):void {
			_rocket = value;
		}
		
	}

}