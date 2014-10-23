package towers {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import weapons.Rocket;
	import weapons.TowerWeapon;
	import weapons.Weapon;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	internal class Tower_02 extends TowerBase {
		
		private var _towerArt : TowerArt_02 = new TowerArt_02();
		
		override internal function drawTower():void {
			addChild(_towerArt);
		}
		
		override internal function initTower():void {
			addEventListener(Event.ENTER_FRAME, update);
			projectileType = TowerWeapon.MISSILE;
		}
		
		override internal function update(e:Event):void {
			super.update(e);
		}
		
	}

}