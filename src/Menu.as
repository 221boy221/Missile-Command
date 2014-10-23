package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Menu extends Sprite {
		
		public function Menu() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			
			stage.addEventListener(MouseEvent.CLICK, startgame);
		}
		
		private function startgame(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.CLICK, startgame);
			dispatchEvent(new Event("startGame"));
		}
		
	}

}