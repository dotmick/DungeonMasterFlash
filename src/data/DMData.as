package data
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class DMData extends EventDispatcher
	{
		private var dungeonDATFile:File;
		private var graphicsDATFile:File;
		private var _dungeonDAT:DungeonDATParser;
		private var _graphicsDAT:GraphicsDATParser;
		private var queueCount:int = 0;
		
		public function DMData( _dungeonDATFileName:String, _graphicsDATFileName:String )
		{
			dungeonDATFile = new File( File.applicationDirectory.nativePath + "/data/" + _dungeonDATFileName );
			dungeonDATFile.addEventListener(Event.COMPLETE, dataFileLoadedHandler);
			
			graphicsDATFile = new File( File.applicationDirectory.nativePath + "/data/" + _graphicsDATFileName );
			graphicsDATFile.addEventListener(Event.COMPLETE, dataFileLoadedHandler);
			
		}
		
		protected function dataFileLoadedHandler(event:Event):void
		{
			trace( (event.currentTarget).name + " loaded");
			
			( (event.currentTarget).name == "dungeonf.dat" )?(_dungeonDAT = new DungeonDATParser( (event.currentTarget as File).data )):(_graphicsDAT = new GraphicsDATParser( (event.currentTarget as File).data ));
			if(queueCount == 1) dispatchEvent(new Event("complete"));
			
			queueCount++;
			
		}
		
		public function loadData():void
		{
			dungeonDATFile.load();
			graphicsDATFile.load();
		}

		public function get dungeonDAT() : DungeonDATParser
		{
			return _dungeonDAT;
		}

		public function set dungeonDAT(dungeonDAT : DungeonDATParser) : void
		{
			_dungeonDAT = dungeonDAT;
		}

		public function get graphicsDAT() : GraphicsDATParser
		{
			return _graphicsDAT;
		}

		public function set graphicsDAT(graphicsDAT : GraphicsDATParser) : void
		{
			_graphicsDAT = graphicsDAT;
		}
	}
}