package data
{
	import com.doesflash.utils.traceV2;
	import com.dotmick.utils.BinaryHelper;
	
	import flash.utils.ByteArray;
	import flash.utils.flash_proxy;

	public class DungeonDATParser extends DATParser
	{
		public static const VERSION_DM		:String = "Dungeon Master";
		public static const VERSION_CSBP	:String = "Chaos Strikes Back Prison";
		public static const VERSION_CSBD	:String = "Chaos Strikes Back Dungeon";
		public static const VERSION_DMII	:String = "Dungeon Master II";
		
		private var globalMapDataSize:int;
		private var nbMaps:int;
		private var textDataSizeInWords:int;
		private var startingPartyPositionBinary:String;
		private var startingPartyPosition:PlayerPosition;
		private var objectListSizeInWords:int;
		private var objectListing:ObjectListing;
		private var maps:Array;
		
		public function DungeonDATParser( _byteArray:ByteArray )
		{
			super(_byteArray);
			
			//- Random seed and Dungeon ID
			switch( this.rawBytes.readShort() )
			{
				case 99:
					dataVersion = VERSION_DM;
				case 8:
					dataVersion = VERSION_CSBP;
				case 13:
					dataVersion = VERSION_CSBP;
				case 0:
					dataVersion = VERSION_DMII;
				default:
					dataVersion = VERSION_DM;
					break;
			}
			
			trace("dungeon.dat from " + dataVersion);
			
			//- Size of global map data in bytes (total size of all maps)
			globalMapDataSize = this.rawBytes.readShort();
			trace("Size of global map data in bytes (total size of all maps) : " + globalMapDataSize);
			
			//- Number of maps (in Dungeon Master and Chaos Strikes Back, number of maps = number of levels)
			nbMaps = this.rawBytes.readByte();
			trace("Number of maps (in Dungeon Master and Chaos Strikes Back, number of maps = number of levels) : " + nbMaps);
			
			//- Unused, padding
			this.rawBytes.readByte();
			
			//- Text data size in words
			textDataSizeInWords = this.rawBytes.readShort();
			trace("Text data size in words : " + textDataSizeInWords + " (" + textDataSizeInWords*2 + "bytes)");
			
			//- Starting party position
			startingPartyPositionBinary = this.rawBytes.readShort().toString(2);
			startingPartyPosition = new PlayerPosition();
			startingPartyPosition.posX = BinaryHelper.getDecFromBinaryRange( startingPartyPositionBinary, 0, 4);
			startingPartyPosition.posY = BinaryHelper.getDecFromBinaryRange( startingPartyPositionBinary, 5, 9);
			startingPartyPosition.posFacing = PlayerPosition.FACING[ BinaryHelper.getDecFromBinaryRange( startingPartyPositionBinary, 10, 11) ];
			trace(startingPartyPosition);
			trace("(starting party position : " + startingPartyPositionBinary + ")");
			
			//- Object list size in words
			objectListSizeInWords = this.rawBytes.readShort();
			trace("Object list size in words : " + objectListSizeInWords + " (" + objectListSizeInWords*2 + "bytes)");
			
			//- Number of objects of each type (16 words)
			objectListing = new ObjectListing();
			//-- doors
			objectListing.doorsCount = this.rawBytes.readShort();
			//-- teleporters
			objectListing.teleportersCount = this.rawBytes.readShort();
			//-- texts
			objectListing.textsCount = this.rawBytes.readShort();
			//-- actuators
			objectListing.actuatorsCount = this.rawBytes.readShort();
			//-- creatures
			objectListing.creaturesCount = this.rawBytes.readShort();
			//-- weapons
			objectListing.weaponsCount = this.rawBytes.readShort();
			//-- clothes
			objectListing.clothesCount = this.rawBytes.readShort();
			//-- scrolls
			objectListing.scrollsCount = this.rawBytes.readShort();
			//-- potions
			objectListing.potionsCount = this.rawBytes.readShort();
			//-- containers
			objectListing.containersCount = this.rawBytes.readShort();
			//-- miscellaneous items
			objectListing.miscItemsCount = this.rawBytes.readShort();
			//-- (3 unused words)
			this.rawBytes.readShort();
			this.rawBytes.readShort();
			this.rawBytes.readShort();
			//-- missiles
			objectListing.missilesCount = this.rawBytes.readShort();
			//-- clouds
			objectListing.cloudsCount = this.rawBytes.readShort();
			trace(objectListing);
			
			//- MAPS
			maps = [ nbMaps ];
			for(var m:int; m < nbMaps; m++)
			{
				maps[ m ] = new MapData();
				var map:MapData = maps[ m ];
				
				map.globalOffset = this.rawBytes.readShort();
				map.mapComponents = this.rawBytes.readShort();
				//-- (1 unused word)
				this.rawBytes.readShort();
				
				map.xOffset = this.rawBytes.readByte();
				map.yOffset = this.rawBytes.readByte();
				
				var mapSize:String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				map.height = BinaryHelper.getDecFromBinaryRange( mapSize, 11, 15);
				map.width = BinaryHelper.getDecFromBinaryRange( mapSize, 6, 10);
				map.level = BinaryHelper.getDecFromBinaryRange( mapSize, 0, 5);
				
				var nbGfx:String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				map.nbFloorGfxRndDeco = BinaryHelper.getDecFromBinaryRange( nbGfx, 12, 15);
				map.nbFloorGfxAvailMap = BinaryHelper.getDecFromBinaryRange( nbGfx, 8, 11);
				map.nbWallGfxRndDeco = BinaryHelper.getDecFromBinaryRange( nbGfx, 4, 7);
				map.nbWallGfxAvailMap = BinaryHelper.getDecFromBinaryRange( nbGfx, 0, 3);
				
				var d:String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				map.difficulty = BinaryHelper.getDecFromBinaryRange( d, 12, 15);
				/* Bits 11-8: These bits are not used by the games, but there are some non zero values:
				Dungeon Master: Value 4 for map 3, Value 1 for map 5, Value 3 for map 12
				Chaos Strikes Back: Value 3 for map 0, Value 1 for map 1, Value 3 for map 2, Value 4 for map 3, Value 2 for map 4, Value 3 for map 5, Value 3 for map 6, Value 3 for map 7, Value 2 for map 8, Value 2 for map 9
				Dungeon Master II: Values 1 to 5
				*/
				map.nbCreaturesAllowed = BinaryHelper.getDecFromBinaryRange( d, 4, 7);
				map.nbDoorDecoGfx = BinaryHelper.getDecFromBinaryRange( d, 0, 3);
				
				var doors:String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				map.doorTypeOne = BinaryHelper.getDecFromBinaryRange( doors, 12, 15);
				map.doorTypeZero = BinaryHelper.getDecFromBinaryRange( doors, 8, 11);
				map.gfxStyle = BinaryHelper.getDecFromBinaryRange( doors, 4, 7);
				map.floorAndCeilingGfxStyle = BinaryHelper.getDecFromBinaryRange( doors, 0, 3);
				
				//trace(m + " -> " + map.width + " x " + map.height + " / " + map.level);
			}
			traceV2(maps[7], true, 4);
		}
	}
}