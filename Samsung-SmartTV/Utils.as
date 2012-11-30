package {
	public class Utils extends Object {
		public static function ReplaceAll(str:String, findStr:String, replaceStr:String):String {
			return str.split(findStr).join(replaceStr);
		}
		
		public static function Trim(str:String):String {
			return TrimBack(TrimFront(str));
		}

		private static function TrimBack(str:String):String {
			if (str.charAt(str.length - 1) == " ")
				str = TrimBack(str.substring(0, str.length - 1));
			return str;
		}

		private static function TrimFront(str:String):String {
			if (str.charAt(0) == " ")
				str = TrimFront(str.substring(1));
			return str;
		}
	}
}

