package events {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import weapons.Projectile;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class ShootEvent extends Event {
		
		private var _projectile : Projectile;
		
		public function ShootEvent(type:String, projectile : Projectile, bubbles : Boolean = false) {
			super(type, bubbles);
			
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