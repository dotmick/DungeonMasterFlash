package data
{
	import com.adobe.crypto.MD5;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class DATParser extends EventDispatcher
	{
		protected var rawBytes:ByteArray;
		protected var _md5:String;
		protected var dataVersion:String;
		
		public function DATParser( _byteArray:ByteArray )
		{
			rawBytes = _byteArray;
			_md5 = MD5.hashBytes(rawBytes);
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

		public function get md5() : String
		{
			return _md5;
		}

		public function set md5(md5 : String) : void
		{
			_md5 = md5;
		}
	}
}