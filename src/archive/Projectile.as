package archive {
	import flash.display.Sprite;
	import flash.events.Event;
	import weapons.Projectile;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Projectile extends Sprite {
		
		private var _projectileName	:	String;
		private var _projectileArt	:	Sprite;
		private var _speed			:	Number;
		
		public function get projectileName():String {
			return _projectileName;
		}
		
		public function set projectileName(projectileName : String):void {
			_projectileName = projectileName;
		}
		
		public function get projectileArt():Sprite {
			return _projectileArt;
		}
		
		public function set projectileArt(projectileArt : Sprite):void {
			_projectileArt = projectileArt;
		}
		
		public function get speed():Number {
			return _speed;
		}
		
		public function set speed(speed : Number):void {
			_speed = speed;
		}
		
		public function update():void {
		
		}
		
	}

}