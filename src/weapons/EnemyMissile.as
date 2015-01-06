package weapons {
	import explosions.ExplosionFactory;
	import flash.events.Event;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class EnemyMissile extends Projectile {
		
		override internal function drawProjectile():void {
			asset = new rocketArt();
			asset.scaleX = 0.5;
			asset.scaleY = 0.5;
			
			explosionType = ExplosionFactory.EXPLOSION_SMALL;
		}
		
		override internal function arm():void {
			speed = 5;
		}
		
		override internal function checkDir():void {
			if (this.y >= _target.y) {
				super.explode();
				_selectedTower.takeDamage(1);
			}
			
		}
		
	}

}