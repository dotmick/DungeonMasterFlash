package data
{
	import com.doesflash.utils.toStr;

	public class MapData
	{
		private var _globalOffset:int;
		private var _mapComponents:int;	//- only used in DMII
		private var _xOffset:int;
		private var _yOffset:int;
		private var _width:int;
		private var _height:int;
		private var _level:int;
		private var _nbFloorGfxRndDeco:int;
		private var _nbFloorGfxAvailMap:int;
		private var _nbWallGfxRndDeco:int;
		private var _nbWallGfxAvailMap:int;
		private var _difficulty:int;
		private var _nbCreaturesAllowed:int;
		private var _nbDoorDecoGfx:int;
		private var _doorTypeOne:int;
		private var _doorTypeZero:int;
		private var _gfxStyle:int; //- 0h for DM and CSB
		private var _floorAndCeilingGfxStyle:int; //- 0h for DM and CSB
		private var _tiles:Array = new Array();
		private var _creatures:Array = new Array();
		private var _wallDecorations:Array = new Array();
		private var _floorDecorations:Array = new Array();
		private var _doorDecorations:Array = new Array();
		
		public function MapData()
		{
			
		}

		public function get globalOffset():int
		{
			return _globalOffset;
		}

		public function set globalOffset(value:int):void
		{
			_globalOffset = value;
		}

		public function get mapComponents():int
		{
			return _mapComponents;
		}

		public function set mapComponents(value:int):void
		{
			_mapComponents = value;
		}

		public function get xOffset():int
		{
			return _xOffset;
		}

		public function set xOffset(value:int):void
		{
			_xOffset = value;
		}

		public function get yOffset():int
		{
			return _yOffset;
		}

		public function set yOffset(value:int):void
		{
			_yOffset = value;
		}

		public function get width():int
		{
			return _width;
		}

		public function set width(value:int):void
		{
			_width = value;
		}

		public function get height():int
		{
			return _height;
		}

		public function set height(value:int):void
		{
			_height = value;
		}

		public function get level():int
		{
			return _level;
		}

		public function set level(value:int):void
		{
			_level = value;
		}

		public function get nbFloorGfxRndDeco():int
		{
			return _nbFloorGfxRndDeco;
		}

		public function set nbFloorGfxRndDeco(value:int):void
		{
			_nbFloorGfxRndDeco = value;
		}

		public function get nbFloorGfxAvailMap():int
		{
			return _nbFloorGfxAvailMap;
		}

		public function set nbFloorGfxAvailMap(value:int):void
		{
			_nbFloorGfxAvailMap = value;
		}

		public function get nbWallGfxRndDeco():int
		{
			return _nbWallGfxRndDeco;
		}

		public function set nbWallGfxRndDeco(value:int):void
		{
			_nbWallGfxRndDeco = value;
		}

		public function get nbWallGfxAvailMap():int
		{
			return _nbWallGfxAvailMap;
		}

		public function set nbWallGfxAvailMap(value:int):void
		{
			_nbWallGfxAvailMap = value;
		}

		public function get difficulty():int
		{
			return _difficulty;
		}

		public function set difficulty(value:int):void
		{
			_difficulty = value;
		}

		public function get nbCreaturesAllowed():int
		{
			return _nbCreaturesAllowed;
		}

		public function set nbCreaturesAllowed(value:int):void
		{
			_nbCreaturesAllowed = value;
		}

		public function get nbDoorDecoGfx():int
		{
			return _nbDoorDecoGfx;
		}

		public function set nbDoorDecoGfx(value:int):void
		{
			_nbDoorDecoGfx = value;
		}

		public function get doorTypeOne():int
		{
			return _doorTypeOne;
		}

		public function set doorTypeOne(value:int):void
		{
			_doorTypeOne = value;
		}

		public function get doorTypeZero():int
		{
			return _doorTypeZero;
		}

		public function set doorTypeZero(value:int):void
		{
			_doorTypeZero = value;
		}

		public function get gfxStyle():int
		{
			return _gfxStyle;
		}

		public function set gfxStyle(value:int):void
		{
			_gfxStyle = value;
		}

		public function get floorAndCeilingGfxStyle():int
		{
			return _floorAndCeilingGfxStyle;
		}

		public function set floorAndCeilingGfxStyle(value:int):void
		{
			_floorAndCeilingGfxStyle = value;
		}

		public function toString() : String
		{
			return toStr(this);
		}

		public function get tiles() : Array
		{
			return _tiles;
		}

		public function set tiles(tiles : Array) : void
		{
			_tiles = tiles;
		}

		public function get creatures() : Array
		{
			return _creatures;
		}

		public function set creatures(creatures : Array) : void
		{
			_creatures = creatures;
		}

		public function get wallDecorations() : Array
		{
			return _wallDecorations;
		}

		public function set wallDecorations(wallDecorations : Array) : void
		{
			_wallDecorations = wallDecorations;
		}

		public function get floorDecorations() : Array
		{
			return _floorDecorations;
		}

		public function set floorDecorations(floorDecorations : Array) : void
		{
			_floorDecorations = floorDecorations;
		}

		public function get doorDecorations() : Array
		{
			return _doorDecorations;
		}

		public function set doorDecorations(doorDecorations : Array) : void
		{
			_doorDecorations = doorDecorations;
		}

	}
}