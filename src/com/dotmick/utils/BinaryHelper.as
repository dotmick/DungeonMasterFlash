package com.dotmick.utils
{
	public class BinaryHelper
	{
		public static const BYTE:int = 8;
		public static const SHORT:int = 16;
		public static const INT:int = 32;
		public static const DOUBLE:int = 64;
		
		public function BinaryHelper()
		{
		}
		
		public static function getDecFromBinaryRange( _binaryNumber:String, _fromBit:int, _toBit:int ):int
		{
			var reversed:Array = _binaryNumber.split("").reverse();
			var f:String = "";
			for( var i:int = _toBit; i >= _fromBit; i--){ f += reversed[i]; };
			return parseInt( f, 2 );
		}
		
		public static function normalizeBinaryNumber( _binaryNumber:String, _size:int = SHORT):String
		{
			var mask:String = "0000000000000000000000000000000000000000000000000000000000000000";
			
			return ( _binaryNumber.length >= _size )?_binaryNumber:mask.substr(0, (_size - _binaryNumber.length)) + _binaryNumber;
		}
		
		public static function getBoolFromBinaryRange( _binaryNumber:String, _fromBit:int, _toBit:int ):Boolean
		{
			var reversed:Array = _binaryNumber.split("").reverse();
			var f:String = "";
			for( var i:int = _toBit; i >= _fromBit; i--){ f += reversed[i]; };
			if( parseInt( f, 2 ) == 0 ) return false;
			
			return true;
		}
	}
}