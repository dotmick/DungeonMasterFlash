package data
{
	import data.champions.ChampionData;
	import data.objects.Actuators;
	import data.objects.Cloud;
	import data.objects.Container;
	import data.objects.Creature;
	import data.objects.Door;
	import data.objects.MiscItem;
	import data.objects.Missile;
	import data.objects.Potion;
	import data.objects.Scroll;
	import data.objects.Teleporter;
	import data.objects.Text;
	import data.objects.Weapon;

	import com.doesflash.utils.traceV2;
	import com.dotmick.utils.BinaryHelper;

	import flash.events.Event;
	import flash.utils.ByteArray;

	public class DungeonDATParser extends DATParser
	{
		public static const VERSION_DM		:String = "Dungeon Master";
		public static const VERSION_CSBP	:String = "Chaos Strikes Back Prison";
		public static const VERSION_CSBD	:String = "Chaos Strikes Back Dungeon";
		public static const VERSION_DMII	:String = "Dungeon Master II";
		
		private var globalMapDataSize:int;
		private var _nbMaps:int;
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

		}

		public function parse() : void
		{
			// - Random seed and Dungeon ID
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

			// - Size of global map data in bytes (total size of all maps)
			globalMapDataSize = this.rawBytes.readShort();
			trace("Size of global map data in bytes (total size of all maps) : " + globalMapDataSize);

			// - Number of maps (in Dungeon Master and Chaos Strikes Back, number of maps = number of levels)
			_nbMaps = this.rawBytes.readByte();
			trace("Number of maps (in Dungeon Master and Chaos Strikes Back, number of maps = number of levels) : " + _nbMaps);

			// - Unused, padding
			this.rawBytes.readByte();

			// - Text data size in words
			textDataSizeInWords = this.rawBytes.readUnsignedShort();
			trace("Text data size in words : " + textDataSizeInWords + " (" + textDataSizeInWords * 2 + "bytes)");

			// - Starting party position
			startingPartyPositionBinary = this.rawBytes.readShort().toString(2);
			startingPartyPosition = new PlayerPosition();
			startingPartyPosition.posX = BinaryHelper.getDecFromBinaryRange(startingPartyPositionBinary, 0, 4);
			startingPartyPosition.posY = BinaryHelper.getDecFromBinaryRange(startingPartyPositionBinary, 5, 9);
			startingPartyPosition.posFacing = PlayerPosition.FACING[ BinaryHelper.getDecFromBinaryRange(startingPartyPositionBinary, 10, 11) ];
			trace(startingPartyPosition);
			trace("(starting party position : " + startingPartyPositionBinary + ")");

			// - Object list size in words
			objectListSizeInWords = this.rawBytes.readShort();
			trace("Object list size in words : " + objectListSizeInWords + " (" + objectListSizeInWords * 2 + "bytes)");

			// - Number of objects of each type (16 words)
			objectListing = new ObjectListing();
			// -- doors
			objectListing.doorsCount = this.rawBytes.readShort();
			// -- teleporters
			objectListing.teleportersCount = this.rawBytes.readShort();
			// -- texts
			objectListing.textsCount = this.rawBytes.readShort();
			// -- actuators
			objectListing.actuatorsCount = this.rawBytes.readShort();
			// -- creatures
			objectListing.creaturesCount = this.rawBytes.readShort();
			// -- weapons
			objectListing.weaponsCount = this.rawBytes.readShort();
			// -- clothes
			objectListing.clothesCount = this.rawBytes.readShort();
			// -- scrolls
			objectListing.scrollsCount = this.rawBytes.readShort();
			// -- potions
			objectListing.potionsCount = this.rawBytes.readShort();
			// -- containers
			objectListing.containersCount = this.rawBytes.readShort();
			// -- miscellaneous items
			objectListing.miscItemsCount = this.rawBytes.readShort();
			// -- (3 unused words)
			this.rawBytes.readShort();
			this.rawBytes.readShort();
			this.rawBytes.readShort();
			// -- missiles
			objectListing.missilesCount = this.rawBytes.readShort();
			// -- clouds
			objectListing.cloudsCount = this.rawBytes.readShort();
			trace(objectListing);

			// - MAPS
			maps = [_nbMaps];
			for (var m : int; m < _nbMaps; m++)
			{
				maps[ m ] = new MapData();
				var map : MapData = maps[ m ];

				map.globalOffset = this.rawBytes.readShort();
				map.mapComponents = this.rawBytes.readShort();
				// -- (1 unused word)
				this.rawBytes.readShort();

				map.xOffset = this.rawBytes.readByte();
				map.yOffset = this.rawBytes.readByte();

				var mapSize : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				map.height = BinaryHelper.getDecFromBinaryRange(mapSize, 11, 15);
				map.width = BinaryHelper.getDecFromBinaryRange(mapSize, 6, 10);
				map.level = BinaryHelper.getDecFromBinaryRange(mapSize, 0, 5);

				var nbGfx : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				map.nbFloorGfxRndDeco = BinaryHelper.getDecFromBinaryRange(nbGfx, 12, 15);
				map.nbFloorGfxAvailMap = BinaryHelper.getDecFromBinaryRange(nbGfx, 8, 11);
				map.nbWallGfxRndDeco = BinaryHelper.getDecFromBinaryRange(nbGfx, 4, 7);
				map.nbWallGfxAvailMap = BinaryHelper.getDecFromBinaryRange(nbGfx, 0, 3);

				var d : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				map.difficulty = BinaryHelper.getDecFromBinaryRange(d, 12, 15);
				/* Bits 11-8: These bits are not used by the games, but there are some non zero values:
				Dungeon Master: Value 4 for map 3, Value 1 for map 5, Value 3 for map 12
				Chaos Strikes Back: Value 3 for map 0, Value 1 for map 1, Value 3 for map 2, Value 4 for map 3, Value 2 for map 4, Value 3 for map 5, Value 3 for map 6, Value 3 for map 7, Value 2 for map 8, Value 2 for map 9
				Dungeon Master II: Values 1 to 5
				 */
				map.nbCreaturesAllowed = BinaryHelper.getDecFromBinaryRange(d, 4, 7);
				map.nbDoorDecoGfx = BinaryHelper.getDecFromBinaryRange(d, 0, 3);

				var doors : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				map.doorTypeOne = BinaryHelper.getDecFromBinaryRange(doors, 12, 15);
				map.doorTypeZero = BinaryHelper.getDecFromBinaryRange(doors, 8, 11);
				map.gfxStyle = BinaryHelper.getDecFromBinaryRange(doors, 4, 7);
				map.floorAndCeilingGfxStyle = BinaryHelper.getDecFromBinaryRange(doors, 0, 3);

				// map.tiles = [map.width][map.height];
							
				// trace(m + " -> " + map.width + " x " + map.height + " / " + map.level);
			}

			// - 010Ch (268) 818 bytes - Index of tiles with objects on them (per column)
			columns = [];
			var total : int = 0;
			for (var n : int = 0; n < maps.length; n++)
			{
				var w : int = maps[n].width + 1;
				total += w;

				for (var c : int = 0; c < w; c++)
				{
					columns.push({map:n, count:this.rawBytes.readUnsignedShort()});
				}
			}
			trace("columns : " + total + " words (" + total * 2 + " bytes)");

			// traceV2(columns, true, 4);

			// - 043Eh (1086) 3358 bytes - List of object IDs of first objects on tiles
			trace("Item list size : " + objectListSizeInWords);
			objects = [];
			for (var i : int = 0; i < objectListSizeInWords; i++)
			{
				var objData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				objects.push({position:ObjectListing.POSITION[ BinaryHelper.getDecFromBinaryRange(objData, 14, 15) ], category:ObjectListing.CATEGORY[ BinaryHelper.getDecFromBinaryRange(objData, 10, 13) ], nbInList:BinaryHelper.getDecFromBinaryRange(objData, 0, 9)});
			}
			trace(objects.length);

			// - TEXTS
			var buffer : String = "";
			var rawBuffer : Array = [];
			championDataList = [];

			for (var t : int = 0; t < textDataSizeInWords; t++)
			{
				var textWordData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				var code1 : int = BinaryHelper.getDecFromBinaryRange(textWordData, 10, 14);
				var code2 : int = BinaryHelper.getDecFromBinaryRange(textWordData, 5, 9);
				var code3 : int = BinaryHelper.getDecFromBinaryRange(textWordData, 0, 4);

				rawBuffer.push(code1);
				rawBuffer.push(code2);
				rawBuffer.push(code3);

				buffer += TextData.CODE[code1] + TextData.CODE[code2] + TextData.CODE[code3];

				if (code1 == 31 || code2 == 31 || code3 == 31)
				{
					buffer = buffer.split(TextData.CODE[31])[0];
					TextData.rawTextsList.push({raw:rawBuffer, translated:buffer});
					// - CHAMPIONS INIT DATA
					if (buffer.split(TextData.CODE[28])[3] == "M" || buffer.split(TextData.CODE[28])[3] == "F") championDataList.push(new ChampionData(buffer));
					buffer = "";
					rawBuffer = []
				}
			}

			// - DOORS
			for (var doorIndex : int = 0; doorIndex < objectListing.doorsCount; doorIndex++)
			{
				var tmpDoor : Door = new Door();
				tmpDoor.nextObjectID = this.rawBytes.readUnsignedShort();
				var tmpDoorData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpDoor.unused = BinaryHelper.getDecFromBinaryRange(tmpDoorData, 9, 15);
				tmpDoor.bashable = ( BinaryHelper.getDecFromBinaryRange(tmpDoorData, 8, 8) == 1) ? true : false;
				tmpDoor.destroyable = ( BinaryHelper.getDecFromBinaryRange(tmpDoorData, 7, 7) == 1) ? true : false;
				tmpDoor.button = ( BinaryHelper.getDecFromBinaryRange(tmpDoorData, 6, 6) == 1) ? true : false;
				tmpDoor.vertical = ( BinaryHelper.getDecFromBinaryRange(tmpDoorData, 5, 5) == 1) ? true : false;
				tmpDoor.ornate = BinaryHelper.getDecFromBinaryRange(tmpDoorData, 1, 4);
				tmpDoor.type = BinaryHelper.getDecFromBinaryRange(tmpDoorData, 0, 0);
				objectListing.doors.push(tmpDoor);
			}

			// - TELEPORTERS
			for (var teleIndex : int = 0; teleIndex < objectListing.teleportersCount; teleIndex++)
			{
				var tmpTele : Teleporter = new Teleporter();
				tmpTele.nextObjectID = this.rawBytes.readUnsignedShort();
				var tmpTeleData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpTele.hasSound = ( BinaryHelper.getDecFromBinaryRange(tmpTeleData, 15, 15) == 1) ? true : false;
				tmpTele.scope = Teleporter.SCOPE[ BinaryHelper.getDecFromBinaryRange(tmpTeleData, 13, 14) ];
				tmpTele.rotationTypeAbsoluteNorth = ( BinaryHelper.getDecFromBinaryRange(tmpTeleData, 12, 12) == 1) ? true : false;
				tmpTele.rotation = Teleporter.ROTATION[ BinaryHelper.getDecFromBinaryRange(tmpTeleData, 10, 11) ];
				tmpTele.destinationY = BinaryHelper.getDecFromBinaryRange(tmpTeleData, 5, 9);
				// (without map offset)
				tmpTele.destinationX = BinaryHelper.getDecFromBinaryRange(tmpTeleData, 0, 4);
				// (without map offset)
				tmpTele.destinationMap = BinaryHelper.getDecFromBinaryRange(BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2)), 8, 15);
				objectListing.teleporters.push(tmpTele);
			}

			// - TEXTS
			for (var txtIndex : int = 0; txtIndex < objectListing.textsCount; txtIndex++)
			{
				var tmpTxt : Text = new Text();
				tmpTxt.nextObjectID = this.rawBytes.readUnsignedShort();
				var tmpTxtData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpTxt.referredTextInTextData = BinaryHelper.getDecFromBinaryRange(tmpTxtData, 3, 15);
				tmpTxt.isComplex = ( BinaryHelper.getDecFromBinaryRange(tmpTxtData, 2, 2) == 1) ? true : false;
				tmpTxt.actuator = ( BinaryHelper.getDecFromBinaryRange(tmpTxtData, 1, 1) == 1) ? true : false;
				tmpTxt.visible = ( BinaryHelper.getDecFromBinaryRange(tmpTxtData, 0, 0) == 1) ? true : false;
				objectListing.texts.push(tmpTxt);
			}

			// - ACTUATORS
			for (var actIndex : int = 0; actIndex < objectListing.actuatorsCount; actIndex++)
			{
				var tmpAct : Actuators = new Actuators();
				tmpAct.nextObjectID = this.rawBytes.readUnsignedShort();
				var tmpActData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpAct.data = BinaryHelper.getDecFromBinaryRange(tmpActData, 7, 15);
				tmpAct.type = BinaryHelper.getDecFromBinaryRange(tmpActData, 0, 6);

				tmpActData = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpAct.gfxNumber = BinaryHelper.getDecFromBinaryRange(tmpActData, 12, 15);
				tmpAct.isActionTargetTypeLocal = ( BinaryHelper.getDecFromBinaryRange(tmpActData, 11, 11) == 1) ? true : false;
				tmpAct.delayBeforeAction = BinaryHelper.getDecFromBinaryRange(tmpActData, 7, 10);
				tmpAct.hasSoundEffect = ( BinaryHelper.getDecFromBinaryRange(tmpActData, 6, 6) == 1) ? true : false;
				tmpAct.hasRevertEffect = ( BinaryHelper.getDecFromBinaryRange(tmpActData, 5, 5) == 1) ? true : false;
				tmpAct.actionType = Actuators.ACTION_TYPE[ BinaryHelper.getDecFromBinaryRange(tmpActData, 3, 4) ];
				tmpAct.isOnceOnly = ( BinaryHelper.getDecFromBinaryRange(tmpActData, 2, 2) == 1) ? true : false;

				tmpActData = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				if ( tmpAct.isActionTargetTypeLocal )
				{
					tmpAct.actionToExecute = BinaryHelper.getDecFromBinaryRange(tmpActData, 4, 15);
				}
				else
				{
					tmpAct.targetTileY = BinaryHelper.getDecFromBinaryRange(tmpActData, 11, 15);
					tmpAct.targetTileX = BinaryHelper.getDecFromBinaryRange(tmpActData, 6, 10);
					tmpAct.direction = PlayerPosition.FACING[ BinaryHelper.getDecFromBinaryRange(tmpActData, 4, 5) ];
				}

				objectListing.actuators.push(tmpAct);
			}

			// - CREATURES
			for (var creaIndex : int = 0; creaIndex < objectListing.creaturesCount; creaIndex++)
			{
				var tmpCrea : Creature = new Creature();
				tmpCrea.nextObjectID = this.rawBytes.readUnsignedShort();
				tmpCrea.nextPossessionObjectID = this.rawBytes.readUnsignedShort();
				tmpCrea.type = this.rawBytes.readUnsignedByte();
				var tmpCreaData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedByte().toString(2));
				tmpCrea.positions[3] = BinaryHelper.getDecFromBinaryRange(tmpCreaData, 6, 7);
				tmpCrea.positions[2] = BinaryHelper.getDecFromBinaryRange(tmpCreaData, 4, 5);
				tmpCrea.positions[1] = BinaryHelper.getDecFromBinaryRange(tmpCreaData, 2, 3);
				tmpCrea.positions[0] = BinaryHelper.getDecFromBinaryRange(tmpCreaData, 0, 1);

				tmpCrea.hitPoints[0] = this.rawBytes.readUnsignedShort();
				tmpCrea.hitPoints[1] = this.rawBytes.readUnsignedShort();
				tmpCrea.hitPoints[2] = this.rawBytes.readUnsignedShort();
				tmpCrea.hitPoints[3] = this.rawBytes.readUnsignedShort();

				tmpCreaData = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));

				tmpCrea.importantObject = ( BinaryHelper.getDecFromBinaryRange(tmpCreaData, 10, 10) == 1) ? true : false;
				tmpCrea.direction = PlayerPosition.FACING[ BinaryHelper.getDecFromBinaryRange(tmpCreaData, 8, 9) ];
				tmpCrea.number = BinaryHelper.getDecFromBinaryRange(tmpCreaData, 5, 6);
				// nb-1
				tmpCrea.gameOnly1 = BinaryHelper.getDecFromBinaryRange(tmpCreaData, 4, 4);
				tmpCrea.gameOnly2 = BinaryHelper.getDecFromBinaryRange(tmpCreaData, 0, 3);
				objectListing.creatures.push(tmpCrea);
			}

			// - WEAPONS
			for (var weapIndex : int = 0; weapIndex < objectListing.weaponsCount; weapIndex++)
			{
				var tmpWeap : Weapon = new Weapon();
				tmpWeap.nextObjectID = this.rawBytes.readUnsignedShort();
				var tmpWeapData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpWeap.usedAtRuntime = ( BinaryHelper.getDecFromBinaryRange(tmpWeapData, 15, 15) == 1) ? true : false;
				tmpWeap.broken = ( BinaryHelper.getDecFromBinaryRange(tmpWeapData, 14, 14) == 1) ? true : false;
				tmpWeap.nbOfCharges = BinaryHelper.getDecFromBinaryRange(tmpWeapData, 10, 13);
				tmpWeap.poisoned = ( BinaryHelper.getDecFromBinaryRange(tmpWeapData, 9, 9) == 1) ? true : false;
				tmpWeap.cursed = ( BinaryHelper.getDecFromBinaryRange(tmpWeapData, 8, 8) == 1) ? true : false;
				tmpWeap.important = ( BinaryHelper.getDecFromBinaryRange(tmpWeapData, 7, 7) == 1) ? true : false;
				tmpWeap.type = BinaryHelper.getDecFromBinaryRange(tmpWeapData, 0, 6);
				objectListing.weapons.push(tmpWeap);
			}

			// - CLOTHES
			for (var clotheIndex : int = 0; clotheIndex < objectListing.clothesCount; clotheIndex++)
			{
				var tmpClothe : Weapon = new Weapon();
				tmpClothe.nextObjectID = this.rawBytes.readUnsignedShort();
				var tmpClotheData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpClothe.broken = ( BinaryHelper.getDecFromBinaryRange(tmpClotheData, 13, 13) == 1) ? true : false;
				tmpClothe.nbOfCharges = BinaryHelper.getDecFromBinaryRange(tmpClotheData, 9, 12);
				tmpClothe.cursed = ( BinaryHelper.getDecFromBinaryRange(tmpClotheData, 8, 8) == 1) ? true : false;
				tmpClothe.important = ( BinaryHelper.getDecFromBinaryRange(tmpClotheData, 7, 7) == 1) ? true : false;
				tmpClothe.type = BinaryHelper.getDecFromBinaryRange(tmpClotheData, 0, 6);
				objectListing.clothes.push(tmpClothe);
			}

			// - SCROLLS
			for (var scrollIndex : int = 0; scrollIndex < objectListing.scrollsCount; scrollIndex++)
			{
				var tmpScroll : Scroll = new Scroll();
				tmpScroll.nextObjectID = this.rawBytes.readUnsignedShort();
				var tmpScrollData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpScroll.closed = ( BinaryHelper.getDecFromBinaryRange(tmpScrollData, 10, 15) == 1) ? true : false;
				tmpScroll.referredText = BinaryHelper.getDecFromBinaryRange(tmpScrollData, 0, 9);
				objectListing.scrolls.push(tmpScroll);
			}

			// - POTIONS
			for (var potIndex : int = 0; potIndex < objectListing.potionsCount; potIndex++)
			{
				var tmpPotion : Potion = new Potion();
				tmpPotion.nextObjectID = this.rawBytes.readUnsignedShort();
				var tmpPotionData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpPotion.isPowerVisible = ( BinaryHelper.getDecFromBinaryRange(tmpPotionData, 15, 15) == 1) ? true : false;
				tmpPotion.type = BinaryHelper.getDecFromBinaryRange(tmpPotionData, 8, 14);
				tmpPotion.power = BinaryHelper.getDecFromBinaryRange(tmpPotionData, 0, 7);
				objectListing.potions.push(tmpPotion);
			}

			// - CONTAINERS
			for (var contIndex : int = 0; contIndex < objectListing.containersCount; contIndex++)
			{
				var tmpCont : Container = new Container();
				tmpCont.nextObjectID = this.rawBytes.readUnsignedShort();
				tmpCont.nextContainedObjectID = this.rawBytes.readUnsignedShort();
				var tmpContData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpCont.unknow1 = BinaryHelper.getDecFromBinaryRange(tmpContData, 3, 15);
				tmpCont.type = BinaryHelper.getDecFromBinaryRange(tmpContData, 1, 2);
				tmpCont.unknow2 = BinaryHelper.getDecFromBinaryRange(tmpContData, 0, 0);
				this.rawBytes.readUnsignedShort();
				objectListing.containers.push(tmpCont);
			}

			// - MISCELLANEOUS ITEMS
			for (var miscIndex : int = 0; miscIndex < objectListing.miscItemsCount; miscIndex++)
			{
				var tmpMisc : MiscItem = new MiscItem();
				tmpMisc.nextObjectID = this.rawBytes.readUnsignedShort();
				var tmpMiscData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpMisc.mainValue = BinaryHelper.getDecFromBinaryRange(tmpMiscData, 14, 15);
				tmpMisc.important = ( BinaryHelper.getDecFromBinaryRange(tmpMiscData, 7, 7) == 1) ? true : false;
				tmpMisc.type = BinaryHelper.getDecFromBinaryRange(tmpMiscData, 0, 6);
				objectListing.misc.push(tmpMisc);
			}

			// - MISSILES
			for (var missIndex : int = 0; missIndex < objectListing.missilesCount; missIndex++)
			{
				var tmpMiss : Missile = new Missile();
				tmpMiss.nextObjectID = this.rawBytes.readUnsignedShort();
				tmpMiss.object = this.rawBytes.readUnsignedShort();
				tmpMiss.energyRemaining1 = this.rawBytes.readUnsignedByte();
				tmpMiss.energyRemaining2 = this.rawBytes.readUnsignedByte();
				tmpMiss.timer = this.rawBytes.readUnsignedShort();
				objectListing.missiles.push(tmpMiss);
			}

			// - CLOUDS
			for (var cloudIndex : int = 0; cloudIndex < objectListing.cloudsCount; cloudIndex++)
			{
				var tmpCloud : Cloud = new Cloud();
				tmpCloud.nextObjectID = this.rawBytes.readUnsignedShort();
				var tmpCloudData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedShort().toString(2));
				tmpCloud.mainValue = BinaryHelper.getDecFromBinaryRange(tmpCloudData, 8, 15);
				tmpCloud.unknow = ( BinaryHelper.getDecFromBinaryRange(tmpCloudData, 7, 7) == 1) ? true : false;
				tmpCloud.type = BinaryHelper.getDecFromBinaryRange(tmpCloudData, 0, 6);
				objectListing.clouds.push(tmpCloud);
			}

			// MAP DATA
			for (m = 0; m < _nbMaps; m++)
			{
				for (var col : int = 0; col < maps[m].width + 1; col++)
				{
					maps[m].tiles[col] = new Array();
					for (var row : int = 0; row < maps[m].height + 1; row++)
					{
						var tmpTileData : String = BinaryHelper.normalizeBinaryNumber(this.rawBytes.readUnsignedByte().toString(2));
						var tmpTile : Tile = new Tile();
						tmpTile.type = BinaryHelper.getDecFromBinaryRange(tmpTileData, 5, 7);
						maps[m].tiles[col][row] = tmpTile;
					}
				}
				
				for (var ii : int = 0; ii < maps[m].nbCreaturesAllowed; ii++)
				{
					maps[m].creatures[ii] = this.rawBytes.readUnsignedByte();
				}
				for (var ij : int = 0; ij < maps[m].nbWallGfxAvailMap; ij++)
				{
					maps[m].wallDecorations[ij] = this.rawBytes.readUnsignedByte();
				}
				for (var ik : int = 0; ik < maps[m].nbFloorGfxAvailMap; ik++)
				{
					maps[m].floorDecorations[ik] = this.rawBytes.readUnsignedByte();
				}
				for (var il : int = 0; il < maps[m].nbDoorDecoGfx; il++)
				{
					maps[m].doorDecorations[il] = this.rawBytes.readUnsignedByte();
				}
			}

			//traceV2(maps[0].tiles.length, true, 4);
			trace(maps[0].tiles[0].length);
			trace("ok");
			dispatchEvent(new Event("parse_complete"));
		}
		
		public function getMap(id:int):MapData
		{
			if(maps[id] != null) return maps[id];
			return null;
		}

		public function get nbMaps() : int
		{
			return _nbMaps;
		}

		public function set nbMaps(nbMaps : int) : void
		{
			_nbMaps = nbMaps;
		}
	}
}