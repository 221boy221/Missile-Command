package towers {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import weapons.Rocket;
	import towers.Tower_01;
	import weapons.TowerWeapon;
	import weapons.Weapon;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	internal class Tower_01 extends TowerBase {
		
		private var _towerArt : TowerCannon = new TowerCannon();
		
		override internal function drawTower():void {
			addChild(_towerArt);
		}
		
		override internal function initTower():void {
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, fire2);
		}
		
		private function fire2(e:MouseEvent):void {
			super.fire(e, TowerWeapon.ROCKET);
			
		}
		
		override internal function update(e:Event):void {
			super.update(e);
		}
		
	}

}