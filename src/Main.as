package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Main extends Sprite {
		
		private var _game:Game;
		private var _menu:Menu;
		private var _txtHighscore : TextField 	= new TextField();
		public static var highscore	: Number = 0;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			
			_txtHighscore.text = "Highscore: " + String(highscore);
			_txtHighscore.x = stage.stageWidth / 2 - _txtHighscore.width / 2 - 60;
			_txtHighscore.y = stage.stageHeight / 2 - 125;
			
			_txtHighscore.autoSize = TextFieldAutoSize.LEFT;
			_txtHighscore.selectable = false;
			
			_menu = new Menu;
			_menu.addEventListener("startGame", startGame);
			
			addChild(_menu);
			addChild(_txtHighscore);
		}
		
		private function startGame(e:Event):void {
			
			removeChild(_txtHighscore);
			_menu.removeEventListener("startGame", startGame);
			removeChild(_menu);

			_game = new Game();
			_game.addEventListener("openMenu", openMenu); // Listen to Game.as
			addChild(_game);
			stage.focus	= stage;
		}
		
		private function openMenu(e:Event):void {
			if (_game.score > highscore) {
				highscore = _game.score;
				_txtHighscore.text = "Highscore: " + String(highscore);
			}
			
			// remove the game and add the menu
			_game.removeEventListener("openMenu", openMenu);
			_game.score = 0;
			removeChild(_game);
			_game = null;
			
			_menu = new Menu();
			_menu.addEventListener("startGame", startGame);
			
			addChild(_menu);
			addChild(_txtHighscore);
		}
		
	}
	
	
}