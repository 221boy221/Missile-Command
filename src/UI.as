package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class UI extends Sprite {
		
		// Static because I only want one of them.
		public static var _scoreText	: TextField	= new TextField();
		public static var _waveText		: TextField	= new TextField();
		
		public function UI():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//
			
			_scoreText.text = "Score: " + 0;
			_scoreText.x = 20;
			_scoreText.y = 20;
			_scoreText.selectable = false;
			addChild(_scoreText);
			
			_waveText.text = "Wave: " + 0;
			_waveText.x = _scoreText.x;
			_waveText.y = 40;
			_waveText.selectable = false;
			addChild(_waveText);
		}
		
		public static function updateScore(_score : int):void {
			_scoreText.text	= "Score: " + _score;
		}
		
		public static function updateWave(_wave : int):void {
			_waveText.text	= "Wave: " + _wave;
		}
		
	}

}