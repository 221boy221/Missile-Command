package weapons {
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class TowerWeapon extends Weapon {
		
		public static const MISSILE : uint = 0;
		public static const ROCKET : uint = 1;
		
		override protected function createProjectile(projectileType:uint):Projectile {
			switch (projectileType) {
				case MISSILE:
					return new Missile();
					break;
				case ROCKET:
					return new Rocket();
					break;
				default:
					throw new Error("Invalid kind of projectile specified");
					return null;
			}
		}
		
	}
	
}