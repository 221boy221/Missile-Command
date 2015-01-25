package archive:\Users\Boy\Documents\school\flash\Missile-Command\archive {
	import weapons.Rocket;
	import weapons.Projectile;
	import weapons.Missile;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class ProjectileFactory {
		
		public static const ROCKET	: String	=	"Rocket";
		public static const MISSILE	: String	=	"Missile";
		
		public function ProjectileFactory(type : String):Projectile {
			var projectile : Projectile;
			
			if (type == ROCKET) {
				projectile = new Rocket();
			} else if (type == MISSILE) {
				projectile = new Missile();
			} else {
				// For later use
			}
			
			return projectile;
		}
		
	}

}