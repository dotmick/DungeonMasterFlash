package data.objects
{
	public class Teleporter extends GenericObject
	{
		public static const SCOPE:Array = ["items", "creatures", "items/party", "everything"];
		public static const ROTATION:Array = ["none/north", "90° clockwise/east", "180°/south", "90° anti-clockwise/west"];
		
		private var _hasSound:Boolean;
		private var _scope:String;
		private var _rotationTypeAbsoluteNorth:Boolean;
		private var _rotation:String;
		private var _destinationX:int;
		private var _destinationY:int;
		private var _destinationMap:int;
		
		public function Teleporter()
		{
		}

		public function get hasSound():Boolean
		{
			return _hasSound;
		}

		public function set hasSound(value:Boolean):void
		{
			_hasSound = value;
		}

		public function get scope():String
		{
			return _scope;
		}

		public function set scope(value:String):void
		{
			_scope = value;
		}

		public function get rotationTypeAbsoluteNorth():Boolean
		{
			return _rotationTypeAbsoluteNorth;
		}

		public function set rotationTypeAbsoluteNorth(value:Boolean):void
		{
			_rotationTypeAbsoluteNorth = value;
		}

		public function get rotation():String
		{
			return _rotation;
		}

		public function set rotation(value:String):void
		{
			_rotation = value;
		}

		public function get destinationX():int
		{
			return _destinationX;
		}

		public function set destinationX(value:int):void
		{
			_destinationX = value;
		}

		public function get destinationY():int
		{
			return _destinationY;
		}

		public function set destinationY(value:int):void
		{
			_destinationY = value;
		}

		public function get destinationMap():int
		{
			return _destinationMap;
		}

		public function set destinationMap(value:int):void
		{
			_destinationMap = value;
		}


	}
}