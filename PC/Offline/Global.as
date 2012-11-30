package  {
	import fl.controls.TextArea;
	import fl.video.*;
	import flash.text.TextField;
	import flash.display.MovieClip;

	public class Global {
		public static const STAGE_WIDTH:Number = 1920.0;
		public static const STAGE_HEIGHT:Number = 1080.0;

		public static const CONF_URL:String = "player.conf";

		public static const SUB_LINE_SEPARATOR_SYMBOL:String = "{§}";

		public static const SUB_COLOR:Object = 0xFFFF00;
		public static const SUB_FONT_NAME:String = "Verdana";
		public static const SUB_FONT_SIZE:Object= 32.0;
		public static const SUB_LINE_HEIGHT:Object = 0.0;
		public static const SUB_LETTER_SPACING:Number = 4.0;
		public static const SUB_LINE_SPACING:Number = 16.0;
		public static const SUB_MARGIN_BOTTOM:Number = 96.0;

		public static const RESULTS_COLOR:Object = 0x000000;
		public static const RESULTS_FONT_NAME:String = "Verdana";
		public static const RESULTS_FONT_SIZE:Object= 16.0;
		public static const RESULTS_LINE_HEIGHT:Object = 8.0;

		public static var RESULTS_WINDOW_X:Number = 96.0;
		public static var RESULTS_WINDOW_Y:Number = 96.0;
		public static var RESULTS_WINDOW_WIDTH:Number = 550.0;
		public static var RESULTS_WINDOW_HEIGHT:Number = 400.0;
		public static var RESULTS_WINDOW_BUTTONS_SPACE:Number = 16.0;

		public static var Conf:Object = null;

		public static var DictWords:Array = new Array();
		public static var DictDefs:Array = new Array();

		public static var Player:FLVPlayback = null;
		public static var Subs:Array = new Array();
		public static var CurrentPlayingSubIndex:uint = 0;
		public static var CurrentClickedWord:String = "";
		public static var CurrentClickedWordIndex:uint = 0;
		
		public static var Subtitle_mc:MovieClip = null;
		
		public static var ResultsWindow_mc:MovieClip = null;
	}
}

