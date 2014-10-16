package events {
	import flash.events.Event;
	import weapons.Projectile;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class RemoveEvent extends Event {
		
		private var _projectile : Projectile;
		
		public function RemoveEvent(type:String, projectile : Projectile) {
			super(type);
			
			_projectile = projectile;
		}
		
		public function get projectile():Projectile {
			return _projectile;
		}
		
		public function set projectile(value:Projectile):void {
			_projectile = value;
		}
		
	}

}