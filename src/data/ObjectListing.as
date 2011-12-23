package data
{
	public class ObjectListing
	{
		public static const POSITION:Array = ["north/top left", "east/top right", "south/bottom left", "west/bottom right"];
		public static const CATEGORY:Array = ["doors", "teleporters", "wall texts", "actuators", "creatures", "weapons", "clothes", "scrolls", "potions", "containers", "misc", "unused", "unused", "unused", "missiles", "clouds"];
		
		public var doorsCount:int;
		public var teleportersCount:int;
		public var textsCount:int;
		public var actuatorsCount:int;
		public var creaturesCount:int;
		public var weaponsCount:int;
		public var clothesCount:int;
		public var scrollsCount:int;
		public var potionsCount:int;
		public var containersCount:int;
		public var miscItemsCount:int;
		public var missilesCount:int;
		public var cloudsCount:int;
		
		private var _doors:Array = [];
		private var _teleporters:Array = [];
		private var _texts:Array = [];
		private var _actuators:Array = [];
		
		public function ObjectListing()
		{
		}
		
		public function toString():String
		{
			return "doors(" + doorsCount
					+"), teleporters(" + teleportersCount
					+"), texts(" + textsCount
					+"), actuators(" + actuatorsCount
					+"), creatures(" + creaturesCount
					+"), weapons(" + weaponsCount
					+"), clothes(" + clothesCount
					+"), scrolls(" + scrollsCount
					+"), potions(" + potionsCount
					+"), containers(" + containersCount
					+"), misc items(" + miscItemsCount
					+"), missiles(" + missilesCount
					+"), clouds(" + cloudsCount
					+")";
		}
		
		public function getTotal():int
		{
			return (doorsCount+
					teleportersCount+
					textsCount+
					actuatorsCount+
					creaturesCount+
					weaponsCount+
					clothesCount+
					scrollsCount+
					potionsCount+
					containersCount+
					miscItemsCount+
					missilesCount+
					cloudsCount
			);
		}

		public function get doors():Array
		{
			return _doors;
		}

		public function set doors(value:Array):void
		{
			_doors = value;
		}

		public function get teleporters():Array
		{
			return _teleporters;
		}

		public function set teleporters(value:Array):void
		{
			_teleporters = value;
		}

		public function get texts() : Array {
			return _texts;
		}

		public function set texts(texts : Array) : void {
			_texts = texts;
		}

		public function get actuators() : Array {
			return _actuators;
		}

		public function set actuators(actuators : Array) : void {
			_actuators = actuators;
		}


	}
}