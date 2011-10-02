package
{
	import data.DMData;
	
	import flash.display.Sprite;
	
	public class DM extends Sprite
	{
		private var datas:DMData;
		
		public function DM()
		{
			datas = new DMData( "dungeonf.dat", "graphics.dat" );
			datas.loadData();
		}
	}
}