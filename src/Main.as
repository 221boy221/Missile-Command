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
		
		/*
		private var _txtHighscore : TextField 	= new TextField();
		public static var highscore	: Number = 0;
		
		private function init(e:Event = null):void {
			
			_txtHighscore.text = "Highscore: " + String(highscore);
			_txtHighscore.x = stage.stageWidth / 2 - _txtHighscore.width / 2 - 60;
			_txtHighscore.y = stage.stageHeight / 2 - 125;
			
			_txtHighscore.autoSize = TextFieldAutoSize.LEFT;
			_txtHighscore.selectable = false;
			
			addChild(_txtHighscore);
		}
		
		private function startGame(e:Event):void {
			removeChild(_txtHighscore);
		}
		
		private function openMenu(e:Event):void {
			if (_game.score > highscore) {
				highscore = _game.score;
				_txtHighscore.text = "Highscore: " + String(highscore);
			}
			addChild(_txtHighscore);
		}
		*/
		
		public static const STARTGAME	: String	= "startGame";
		public static const OPENMENU	: String	= "openMenu";
		private var _menu				: Menu;
		private var _game				: Game;
		private var _preloader			: PreLoader;
		private var _plText				: TextField;
		
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			// Start Pre-Loader
			addEventListener(Event.ENTER_FRAME, loading);
		}
		
		private function loading(e:Event):void {
			// Pre-Loader
			var total	:	Number	= stage.loaderInfo.bytesTotal,
				loaded	:	Number	= stage.loaderInfo.bytesLoaded;
				
			_preloader = new PreLoader();
			_plText = new TextField();
			_preloader.x = _plText.x = stage.stageWidth / 2;
			_preloader.y = _plText.y = stage.stageHeight / 2;
			addChild(_preloader);
			addChild(_plText);
			_preloader.scaleX = loaded / total;
			_plText.text = Math.floor((loaded / total) * 100) + "%";
			
			if (total == loaded) {
				removeEventListener(Event.ENTER_FRAME, loading);
				removeChild(_preloader);
				removeChild(_plText);
				openMenu(e = null);
			}
			
		}
		
		private function openMenu(e:Event):void {
			// REMOVE - GAME
			if (_game) {
				if (contains(_game)) {
					
					_game.removeEventListener(OPENMENU, openMenu);
					removeChild(_game);
					_game = null;
				}
			}
			
			// ADD - MENU
			_menu = new Menu();
			addChild(_menu);
			_menu.addEventListener(STARTGAME, startGame);
			stage.focus	= stage;
		}
		
		private function startGame(e:Event):void {
			// REMOVE - MENU
			if (_menu) {
				if (contains(_menu)) {
					
					_menu.removeEventListener(STARTGAME, startGame);
					removeChild(_menu);
					_menu = null;
				}
			}
			
			// ADD - GAME
			_game = new Game();
			addChild(_game);
			_game.addEventListener(OPENMENU, openMenu);
			stage.focus	= stage;
		}
		
	}
	
	
}