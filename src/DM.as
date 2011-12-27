package
{
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import data.MapData;
	import flash.events.Event;
	import data.DMData;
	
	import flash.display.Sprite;
	
	[SWF(backgroundColor="#111111", frameRate="31", width="800", height="600")]
	public class DM extends Sprite
	{
		private static const VERSION:String = "0.1";
		
		private var datas:DMData;
		private var currentMap:int = 0;
		private var b : Bitmap;
		
		public function DM()
		{
			datas = new DMData( "dungeonf.dat", "graphics.dat" );
			datas.addEventListener("complete", dataLoadedHandler);
			datas.loadData();
		}

		private function dataLoadedHandler(evt:Event) : void
		{
			trace("DATAS LOADED");
			datas.dungeonDAT.addEventListener("parse_complete", dataParsedHandler);
			datas.dungeonDAT.parse();
		}

		private function dataParsedHandler(evt:Event) : void
		{
			trace("- DUNGEON.DAT PARSED");
			
			drawMap(currentMap);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keydownHandler);
		}

		private function keydownHandler(event : KeyboardEvent) : void
		{
			trace("PRESSED");
			
			if(event.keyCode == Keyboard.LEFT)
			{
				if(currentMap==0)currentMap=datas.dungeonDAT.nbMaps-1;
				else currentMap--;
			}
			if(event.keyCode == Keyboard.RIGHT)
			{
				if(currentMap==datas.dungeonDAT.nbMaps-1)currentMap=0;
				else currentMap++;
			}
			trace("DRAWING MAP " + currentMap);
			drawMap(currentMap);
		}

		private function drawMap(currentMap : int) : void
		{
			if(b!=null)removeChild(b);
			var map:MapData = datas.dungeonDAT.getMap(currentMap);
			var xOffset:int = map.xOffset;
			var yOffset:int = map.yOffset;
			var bdata:BitmapData = new BitmapData(map.width+1+xOffset, map.height+1+yOffset, false, 0x111111);
			for (var i : int = 0; i < map.tiles.length; i++)
			{
				for (var j : int = 0; j < map.tiles[i].length; j++)
				{
					if(map.tiles[i][j].type == 0) bdata.setPixel(xOffset+i, yOffset+j, 0x3f3f3f);
					if(map.tiles[i][j].type == 1) bdata.setPixel(xOffset+i, yOffset+j, 0xc1bfbf);
					if(map.tiles[i][j].type == 2) bdata.setPixel(xOffset+i, yOffset+j, 0x356baf);
					if(map.tiles[i][j].type == 3) bdata.setPixel(xOffset+i, yOffset+j, 0x72af1d);
					if(map.tiles[i][j].type == 4) bdata.setPixel(xOffset+i, yOffset+j, 0x593400);
					if(map.tiles[i][j].type == 5) bdata.setPixel(xOffset+i, yOffset+j, 0xc54ca0);
					if(map.tiles[i][j].type == 6) bdata.setPixel(xOffset+i, yOffset+j, 0x96180a);
				}
			}
			
			b = new Bitmap(bdata);
			b.scaleX = b.scaleY = 15;
			addChild(b);
		}
	}
}