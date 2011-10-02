package data
{
	import flash.utils.ByteArray;

	public class GraphicsDATParser extends DATParser
	{	
		public static const VERSION_DMCSB1	:String = "DMCSB1";
		public static const VERSION_DMCSB2	:String = "DMCSB2";
		public static const VERSION_DMII	:String = "DMII";
		
		public function GraphicsDATParser( _byteArray:ByteArray )
		{
			super(_byteArray);
			
			switch( this.rawBytes.readShort() )
			{
				case 384:
					dataVersion = VERSION_DMCSB2;
				case 1408:
					dataVersion = VERSION_DMCSB2;
				default:
					dataVersion = VERSION_DMCSB1;
					break;
			}
			
			trace("graphics.dat from " + dataVersion);
		}
	}
}