package towers {
	import flash.display.Stage;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class TowerFactory {
		
		public static const TOWER:uint = 0;
		public static const TOWER_02:uint = 1;
		
		public function addTower(towerType:uint, target:Stage, xLoc:int, yLoc:int):Tower {
			var tower:Tower = this.createTower(towerType);
			
			tower.drawTower();
			tower.setLoc(xLoc, yLoc);
			target.addChild(tower);
			tower.initTower();
			
			return tower;
		}
		
		private function createTower(towerType:uint):Tower {
			switch(towerType) {
				case TOWER:
					return new Tower_01();
					break;
				case TOWER_02:
					return new Tower_01();
					break;
				default:
					throw new Error("Invalid kind of tower specified");
					return null;
			}
		
		}
		
	}

}