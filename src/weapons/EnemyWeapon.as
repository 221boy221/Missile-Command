package weapons {
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class EnemyWeapon extends Weapon {
		
		public static const ENEMYMISSILE : uint = 0;
		
		override protected function createProjectile(projectileType:uint):Projectile {
			switch (projectileType) {
				case ENEMYMISSILE:
					return new EnemyMissile();
					break;
				default:
					throw new Error("Invalid kind of projectile specified");
					return null;
			}
		}
		
	}

}