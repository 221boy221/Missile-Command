package  {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Menu extends Sprite {
		
		// ART
		private var _startButton	: StartButton;
		private var _fsButton		: FullscreenButton;
		private var _menuBG			: MenuBG;
		// SFX
		private var _menuSC			: SoundChannel;
		private var _menuMusic		: MenuBG_SFX		= new MenuBG_SFX();
		private var _menuClick		: MenuClick_SFX		= new MenuClick_SFX();
		
		
		public function Menu() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
			// Play and loop forever
			_menuSC = _menuMusic.play(0, int.MAX_VALUE); 
			_menuSC.addEventListener(Event.SOUND_COMPLETE, soundLoop);
			
			// Instantiate
			_startButton	= new StartButton();
			_fsButton		= new FullscreenButton();
			_menuBG 		= new MenuBG();
			
			// Positioning
			_fsButton.x 	= _startButton.x = stage.stageWidth / 2;
			_startButton.y	= stage.stageHeight / 2;
			_fsButton.y 	= _startButton.y + 50;
			
			// Adding
			addChild(_menuBG);
			addChild(_startButton);
			addChild(_fsButton);
			
			stage.addEventListener(MouseEvent.CLICK, mouseDown);
		}
		
		private function mouseDown(e:MouseEvent):void {
			if (e.target == _startButton) {
				_menuClick.play();
				destroy();
			} else if (e.target == _fsButton) {
				toggleFullscreen();
			}
		}
		
		private function toggleFullscreen():void {
			if (stage.displayState == StageDisplayState.NORMAL) {
				stage.displayState=StageDisplayState.FULL_SCREEN;
			} else {
				stage.displayState=StageDisplayState.NORMAL;
			}
		}
		
		private function soundLoop(e:Event):void { 
			_menuSC = _menuMusic.play(0, int.MAX_VALUE); 
		}
		
		// Clean everything
		private function destroy():void {
			var l : uint = numChildren,
				current : DisplayObject;
			
			// Manually removing
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_menuSC.removeEventListener(Event.SOUND_COMPLETE, soundLoop);
			_menuSC.stop();
			
			// Automatically removing
			for ( var i : int = l -1; i >= 0; i--) {
				current = getChildAt(i);
				if (current is Sprite || current is DisplayObject) {
					removeChild(current);
				}
			}
			current = null;
			i = l = NaN;
			
			// Start Game
			dispatchEvent(new Event(Main.STARTGAME, false));
		}
		
	}

}