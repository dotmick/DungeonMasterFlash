package data
{
	import com.doesflash.utils.traceV2;
	import com.dotmick.utils.BinaryHelper;
	
	import data.champions.ChampionData;
	import data.objects.Door;
	import data.objects.Teleporter;
	import data.objects.Text;
	
	import flash.utils.ByteArray;
	import flash.utils.flash_proxy;
	
	import flashx.textLayout.utils.CharacterUtil;

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
		private var columns:Array;
		private var objects:Array;
		private var championDataList:Array;
		
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
			textDataSizeInWords = this.rawBytes.readUnsignedShort();
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
			
			//- 010Ch (268) 818 bytes - Index of tiles with objects on them (per column)
			columns = [];
			var total:int = 0;
			for(var n:int = 0; n < maps.length; n++)
			{
				var w:int = maps[n].width + 1;
				total += w;
				
				for(var c:int = 0; c < w; c++)
				{
					columns.push( {map: n,count: this.rawBytes.readUnsignedShort()} );
				}
			}
			trace("columns : " + total + " words (" + total*2 + " bytes)");
			
			//- 043Eh (1086) 3358 bytes - List of object IDs of first objects on tiles
			trace("Item list size : " + objectListSizeInWords);
			objects = [];
			for (var i:int = 0; i < objectListSizeInWords; i++) 
			{
				var objData:String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				objects.push( {position: ObjectListing.POSITION[ BinaryHelper.getDecFromBinaryRange(objData, 14, 15) ], category: ObjectListing.CATEGORY[ BinaryHelper.getDecFromBinaryRange(objData, 10, 13) ], nbInList: BinaryHelper.getDecFromBinaryRange(objData, 0, 9)} );
				
			}
			trace( objects.length );
			
			//- TEXTS
			var buffer:String = "";
			var rawBuffer:Array = [];
			championDataList = [];
			
			for (var t:int = 0; t < textDataSizeInWords; t++) 
			{
				var textWordData:String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				var code1:int = BinaryHelper.getDecFromBinaryRange(textWordData, 10, 14);
				var code2:int = BinaryHelper.getDecFromBinaryRange(textWordData, 5, 9);
				var code3:int = BinaryHelper.getDecFromBinaryRange(textWordData, 0, 4);
				
				rawBuffer.push( code1 );
				rawBuffer.push( code2 );
				rawBuffer.push( code3 );
				
				buffer += TextData.CODE[code1] + TextData.CODE[code2] + TextData.CODE[code3];
				
				if(code1 == 31 || code2 == 31 || code3 == 31)
				{
					buffer = buffer.split(TextData.CODE[31])[0];
					TextData.rawTextsList.push( {raw: rawBuffer, translated: buffer} );
					//- CHAMPIONS INIT DATA
					if(buffer.split(TextData.CODE[28])[3] == "M" || buffer.split(TextData.CODE[28])[3] == "F") championDataList.push( new ChampionData(buffer) );
					buffer = "";
					rawBuffer = []
				}
			}
			
			//- DOORS
			for (var doorIndex:int = 0; doorIndex < objectListing.doorsCount; doorIndex++) 
			{
				var tmpDoor:Door = new Door();
				tmpDoor.nextObjectID = this.rawBytes.readUnsignedShort();
				var tmpDoorData:String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpDoor.unused = BinaryHelper.getDecFromBinaryRange(tmpDoorData, 9, 15);
				tmpDoor.bashable = ( BinaryHelper.getDecFromBinaryRange(tmpDoorData, 8, 8) == 1)?true:false;
				tmpDoor.destroyable = ( BinaryHelper.getDecFromBinaryRange(tmpDoorData, 7, 7) == 1)?true:false;
				tmpDoor.button = ( BinaryHelper.getDecFromBinaryRange(tmpDoorData, 6, 6) == 1)?true:false;
				tmpDoor.vertical = ( BinaryHelper.getDecFromBinaryRange(tmpDoorData, 5, 5) == 1)?true:false;
				tmpDoor.ornate = BinaryHelper.getDecFromBinaryRange(tmpDoorData, 1, 4);
				tmpDoor.type = BinaryHelper.getDecFromBinaryRange(tmpDoorData, 0, 0);
				objectListing.doors.push( tmpDoor );
			}
			
			//- TELEPORTERS
			for (var teleIndex:int = 0; teleIndex < objectListing.teleportersCount; teleIndex++) 
			{
				var tmpTele:Teleporter = new Teleporter();
				tmpTele.nextObjectID = this.rawBytes.readUnsignedShort();
				var tmpTeleData:String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpTele.hasSound = ( BinaryHelper.getDecFromBinaryRange(tmpTeleData, 15, 15) == 1)?true:false;
				tmpTele.scope = Teleporter.SCOPE[ BinaryHelper.getDecFromBinaryRange(tmpTeleData, 13, 14) ];
				tmpTele.rotationTypeAbsoluteNorth = ( BinaryHelper.getDecFromBinaryRange(tmpTeleData, 12, 12) == 1)?true:false;
				tmpTele.rotation = Teleporter.ROTATION[ BinaryHelper.getDecFromBinaryRange(tmpTeleData, 10, 11) ];
				tmpTele.destinationY = BinaryHelper.getDecFromBinaryRange(tmpTeleData, 5, 9); //(without map offset)
				tmpTele.destinationX = BinaryHelper.getDecFromBinaryRange(tmpTeleData, 0, 4); //(without map offset)
				tmpTele.destinationMap = BinaryHelper.getDecFromBinaryRange( BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2)), 8, 15);
				objectListing.teleporters.push( tmpTele );
			}
			
			//- TEXTS
			for (var txtIndex:int = 0; txtIndex < objectListing.teleportersCount; txtIndex++) 
			{
				var tmpTxt:Text = new Text();
				tmpTxt.nextObjectID = this.rawBytes.readUnsignedShort();
				var tmpTxtData:String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpTele.hasSound = ( BinaryHelper.getDecFromBinaryRange(tmpTxtData, 15, 15) == 1)?true:false;
				tmpTele.scope = Teleporter.SCOPE[ BinaryHelper.getDecFromBinaryRange(tmpTxtData, 13, 14) ];
				tmpTele.rotationTypeAbsoluteNorth = ( BinaryHelper.getDecFromBinaryRange(tmpTxtData, 12, 12) == 1)?true:false;
				tmpTele.rotation = Teleporter.ROTATION[ BinaryHelper.getDecFromBinaryRange(tmpTxtData, 10, 11) ];
				tmpTele.destinationY = BinaryHelper.getDecFromBinaryRange(tmpTxtData, 5, 9); //(without map offset)
				tmpTele.destinationX = BinaryHelper.getDecFromBinaryRange(tmpTxtData, 0, 4); //(without map offset)
				tmpTele.destinationMap = BinaryHelper.getDecFromBinaryRange( BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2)), 8, 15);
				objectListing.teleporters.push( tmpTxt );
			}
			
			trace("ok");
			
		}
	}
}