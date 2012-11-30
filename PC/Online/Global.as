package  {
	import fl.controls.TextArea;
	import fl.text.TLFTextField;
	import fl.video.*;
	import alducente.services.WebService;

	public class Global {
		public static const STAGE_WIDTH:Number = 1920.0;
		public static const STAGE_HEIGHT:Number = 1080.0;

		public static const CONF_URL:String = "player.conf";

		public static const SUB_COLOR:Object = 0xFFFF00;
		public static const SUB_FONT_NAME:String = "Verdana";
		public static const SUB_FONT_SIZE:Object= 36.0;
		public static const SUB_LINE_HEIGHT:Object = 16.0;
		public static const SUB_MARGIN:Number = 96.0;

		public static const RESULTS_COLOR:Object = 0x000000;
		public static const RESULTS_FONT_NAME:String = "Verdana";
		public static const RESULTS_FONT_SIZE:Object= 16.0;
		public static const RESULTS_LINE_HEIGHT:Object = 8.0;

		public static const DICT_SERVICE_URL:String = "http://services.aonaware.com/DictService/DictService.asmx?wsdl";

		public static var Conf:Object = null;
		public static var Player:FLVPlayback = null;
		public static var Subs:Array = new Array();
		public static var CurrentPlayingSubIndex:uint = 0;
		public static var CurrentClickedWord:String = "";
		public static var CurrentClickedWordIndex:uint = 0;
		
		public static var SubTextField:TLFTextField = null;
		
		public static var DictService:WebService = null;
		public static var IsDictServiceConnected:Boolean = false;

		public static var ResultsTextArea:TextArea = null;
	}
}

