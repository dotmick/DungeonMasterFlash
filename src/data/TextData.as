package data
{
	public class TextData
	{
		public static const CODE:Array = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", " ", ".", "(separator)", "(escape 1)", "(escape 2)", "(end)"];
		public static var rawTextsList:Array = [];
		
		public function TextData()
		{
		}
		
		public static function flattenCharArray(_array:Array):String
		{
			var result:String = "";
			for each(var a:Array in _array)
			{
				result += a;
			}
			return result;
		}
		
		public static function backToCode(_str:String, _returnHex:Boolean):*
		{
			var arr:Array = _str.split("");
			var result:String = "";
			
			for each(var a:String in arr)
			{
				result += CODE.indexOf(a).toString(16);
			}
			
			if( _returnHex ) return parseInt(result, 16);
			
			return result;
		}

	}
}