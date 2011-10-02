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
		private var dungeonDAT:DungeonDATParser;
		private var graphicsDAT:GraphicsDATParser;
		
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
			
			( (event.currentTarget).name == "dungeonf.dat" )?dungeonDAT = new DungeonDATParser( (event.currentTarget as File).data ):graphicsDAT = new GraphicsDATParser( (event.currentTarget as File).data );
		}
		
		public function loadData():void
		{
			dungeonDATFile.load();
			graphicsDATFile.load();
		}
	}
}