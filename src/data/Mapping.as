package data
{
	import org.myjerry.as3extensions.io.FileStreamWithLineReader;

	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.events.Event;
	import flash.filesystem.File;

	/**
	 * @author dotmick
	 */
	public class Mapping
	{
		private var _xmlData : XML;
		private var mappingFile : File;
		private var _bigEndian : Boolean;
		private var _type : String;
		private var objTypeTmp : Array;
		private var _nbOfIMG1 : int;
		private var _nbOfIMG2 : int;
		private var _nbOfIMG3 : int;
		private var _nbOfIMG4 : int;
		private var _nbOfIMG5 : int;
		private var _nbOfIMG6 : int;
		private var _nbOfIMG7 : int;
		private var _nbOfIMG8 : int;
		private var _nbOfSND1 : int;
		private var _nbOfSND2 : int;
		private var _nbOfSND3 : int;
		private var _nbOfSND4 : int;
		private var _nbOfSND5 : int;
		private var _nbOfSND6 : int;
		private var _nbOfSND7 : int;
		private var _nbOfSND8 : int;
		private var _nbOfSND9 : int;
		private var _nbOfSNDA : int;
		private var _nbOfTXT1 : int;
		private var _nbOfTXT2 : int;
		private var _nbOfMUS1 : int;
		private var _nbOfFNT1 : int;
		private var _nbOfP4B1 : int;
		private var _nbOfSEQ1 : int;
		private var _nbOfSEQ2 : int;
		private var _nbOfRAW1 : int;
		private var _nbOfRAW2 : int;
		private var _nbOfnull : int;
		private var _nbOfENT1 : int;

		public function Mapping(value : * = undefined)
		{
			_xmlData = new XML(value);
		}

		public function getMappingFileFromMD5(_md5 : String) : String
		{
			var searchRes : String = _xmlData..map.(@md5 == _md5.toUpperCase()).@path;

			mappingFile = new File(File.applicationDirectory.nativePath + "/data/map/" + searchRes);
			// mappingFile.addEventListener(Event.COMPLETE, mappingFileLoadedHandler);
			// mappingFile.load();
			loadFile();
			return searchRes;
		}

		private function loadFile() : void
		{
			var index : int = 0, i : int = 0;
			objTypeTmp = new Array;
			var fs : FileStreamWithLineReader = new FileStreamWithLineReader();
			fs.open(mappingFile, FileMode.READ);

			while (fs.bytesAvailable > 0)
			{
				var line : String = fs.readUTFLine();
				/** Little ou Big Endian */
				if ( line.indexOf("ENDIAN=LITTLE") > -1 )
				{
					this._bigEndian = false;
				}
				else if ( line.indexOf("ENDIAN=BIG") > -1 )
				{
					this._bigEndian = true;
				}

				/** Type d'entête */
				if ( line.indexOf("FORMAT=DMCSB1") > -1 )
				{
					this._type = "DMCSB1";
					continue;
				}
				else if ( line.indexOf("FORMAT=DMCSB2") > -1 )
				{
					this._type = "DMCSB2";
					continue;
				}
				else if ( line.indexOf("FORMAT=DMII") > -1 )
				{
					this._type = "DMII";
					continue;
				}

				/** Types d'objets */
				if ( line.indexOf("IMG1") > -1 )
				{
					this._nbOfIMG1++;
					objTypeTmp[index++] = "IMG1";
				}
				else if ( line.indexOf("IMG2") > -1 )
				{
					this._nbOfIMG2++;
					objTypeTmp[index++] = "IMG2";
				}
				else if ( line.indexOf("IMG3") > -1 )
				{
					this._nbOfIMG3++;
					objTypeTmp[index++] = "IMG3";
				}
				else if ( line.indexOf("IMG4") > -1 )
				{
					this._nbOfIMG4++;
					objTypeTmp[index++] = "IMG4";
				}
				else if ( line.indexOf("IMG5") > -1 )
				{
					this._nbOfIMG5++;
					objTypeTmp[index++] = "IMG5";
				}
				else if ( line.indexOf("IMG6") > -1 )
				{
					this._nbOfIMG6++;
					objTypeTmp[index++] = "IMG6";
				}
				else if ( line.indexOf("IMG7") > -1 )
				{
					this._nbOfIMG7++;
					objTypeTmp[index++] = "IMG7";
				}
				else if ( line.indexOf("IMG8") > -1 )
				{
					this._nbOfIMG8++;
					objTypeTmp[index++] = "IMG8";
				}
				else if ( line.indexOf("SND1") > -1 )
				{
					this._nbOfSND1++;
					objTypeTmp[index++] = "SND1";
				}
				else if ( line.indexOf("SND2") > -1 )
				{
					this._nbOfSND2++;
					objTypeTmp[index++] = "SND2";
				}
				else if ( line.indexOf("SND3") > -1 )
				{
					this._nbOfSND3++;
					objTypeTmp[index++] = "SND3";
				}
				else if ( line.indexOf("SND4") > -1 )
				{
					this._nbOfSND4++;
					objTypeTmp[index++] = "SND4";
				}
				else if ( line.indexOf("SND5") > -1 )
				{
					this._nbOfSND5++;
					objTypeTmp[index++] = "SND5";
				}
				else if ( line.indexOf("SND6") > -1 )
				{
					this._nbOfSND6++;
					objTypeTmp[index++] = "SND6";
				}
				else if ( line.indexOf("SND7") > -1 )
				{
					this._nbOfSND7++;
					objTypeTmp[index++] = "SND7";
				}
				else if ( line.indexOf("SND8") > -1 )
				{
					this._nbOfSND8++;
					objTypeTmp[index++] = "SND8";
				}
				else if ( line.indexOf("SND9") > -1 )
				{
					this._nbOfSND9++;
					objTypeTmp[index++] = "SND9";
				}
				else if ( line.indexOf("SNDA") > -1 )
				{
					this._nbOfSNDA++;
					objTypeTmp[index++] = "SNDA";
				}
				else if ( line.indexOf("MUS1") > -1 )
				{
					this._nbOfMUS1++;
					objTypeTmp[index++] = "MUS1";
				}
				else if ( line.indexOf("FNT1") > -1 )
				{
					this._nbOfFNT1++;
					objTypeTmp[index++] = "FNT1";
				}
				else if ( line.indexOf("TXT1") > -1 )
				{
					this._nbOfTXT1++;
					objTypeTmp[index++] = "TXT1";
				}
				else if ( line.indexOf("TXT2") > -1 )
				{
					this._nbOfTXT2++;
					objTypeTmp[index++] = "TXT2";
				}
				else if ( line.indexOf("P4B1") > -1 )
				{
					this._nbOfP4B1++;
					objTypeTmp[index++] = "P4B1";
				}
				else if ( line.indexOf("SEQ1") > -1 )
				{
					this._nbOfSEQ1++;
					objTypeTmp[index++] = "SEQ1";
				}
				else if ( line.indexOf("SEQ2") > -1 )
				{
					this._nbOfSEQ2++;
					objTypeTmp[index++] = "SEQ2";
				}
				else if ( line.indexOf("RAW1") > -1 )
				{
					this._nbOfRAW1++;
					objTypeTmp[index++] = "RAW1";
				}
				else if ( line.indexOf("RAW2") > -1 )
				{
					this._nbOfRAW2++;
					objTypeTmp[index++] = "RAW2";
				}
				else if ( line.indexOf("null") > -1 )
				{
					this._nbOfnull++;
					objTypeTmp[index++] = "NULL";
				}
				else if ( line.indexOf("ENT1") > -1 )
				{
					this._nbOfENT1++;
					objTypeTmp[index++] = "ENT1";
				}
			}

			/** 2.2 - Fermeture du fichier */
			fs.close();
		}

		public function get xmlData() : XML
		{
			return _xmlData;
		}

		public function set xmlData(xmlData : XML) : void
		{
			_xmlData = xmlData;
		}

		public function get bigEndian() : Boolean
		{
			return _bigEndian;
		}

		public function set bigEndian(bigEndian : Boolean) : void
		{
			_bigEndian = bigEndian;
		}
	}
}
