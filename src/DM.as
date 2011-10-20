package
{
	import data.DMData;
	
	import flash.display.Sprite;
	
	public class DM extends Sprite
	{
		private static const VERSION:String = "0.1";
		
		private var datas:DMData;
		
		public function DM()
		{
			datas = new DMData( "dungeonf.dat", "graphics.dat" );
			datas.loadData();
		}
	}
}