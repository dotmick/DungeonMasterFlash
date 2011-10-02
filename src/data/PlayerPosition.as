package data
{
	import flashx.textLayout.elements.OverflowPolicy;

	public class PlayerPosition
	{
		public static const FACING:Array = ["north", "east", "south", "west"];
		
		private var _posX:int;
		private var _posY:int;
		private var _posFacing:String;
		
		public function PlayerPosition()
		{
			
		}

		public function get posFacing():String
		{
			return _posFacing;
		}

		public function set posFacing(value:String):void
		{
			_posFacing = value;
		}

		public function get posY():int
		{
			return _posY;
		}

		public function set posY(value:int):void
		{
			_posY = value;
		}

		public function get posX():int
		{
			return _posX;
		}

		public function set posX(value:int):void
		{
			_posX = value;
		}
		
		public function toString():String
		{
			return "Starting party position - x:" + posX + ", y:" + posY + ", " + posFacing;
		}

	}
}