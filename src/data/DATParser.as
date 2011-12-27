package data
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class DATParser extends EventDispatcher
	{
		protected var rawBytes:ByteArray;
		protected var dataVersion:String;
		
		public function DATParser( _byteArray:ByteArray )
		{
			rawBytes = _byteArray;
			rawBytes.endian = Endian.LITTLE_ENDIAN;
		}
		
		public function setByteArray( _bytes:ByteArray ):void
		{
			rawBytes = _bytes;
		}
		
		public function getByteArray():ByteArray
		{
			return rawBytes;
		}
	}
}