package towers {
	import flash.display.Stage;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class TowerFactory {
		
		public static const TOWER_01:uint = 0;
		public static const TOWER_02:uint = 1;
		
		public function addTower(towerType:uint, target:Stage, xLoc:int, yLoc:int):TowerBase {
			var tower:TowerBase = this.createTower(towerType);
			
			tower.drawTower();
			tower.setLoc(xLoc, yLoc);
			target.addChild(tower);
			tower.initTower();
			
			return tower;
		}
		
		private function createTower(towerType:uint):TowerBase {
			switch(towerType) {
				case TOWER_01:
					return new Tower_01();
					break;
				case TOWER_02:
					return new Tower_02();
					break;
				default:
					throw new Error("Invalid kind of tower specified");
					return null;
			}
		}
		
	}

}