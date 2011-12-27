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
		private var _actuators : Array = [];
		private var _creatures : Array = [];
		private var _weapons : Array = [];
		private var _clothes : Array = [];
		private var _scrolls : Array = [];
		private var _potions : Array = [];
		private var _containers : Array = [];
		private var _misc : Array = [];
		private var _missiles : Array = [];
		private var _clouds : Array = [];
		
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

		public function get creatures() : Array
		{
			return _creatures;
		}

		public function set creatures(creatures : Array) : void
		{
			_creatures = creatures;
		}

		public function get weapons() : Array
		{
			return _weapons;
		}

		public function set weapons(weapons : Array) : void
		{
			_weapons = weapons;
		}

		public function get clothes() : Array
		{
			return _clothes;
		}

		public function set clothes(clothes : Array) : void
		{
			_clothes = clothes;
		}

		public function get scrolls() : Array
		{
			return _scrolls;
		}

		public function set scrolls(scrolls : Array) : void
		{
			_scrolls = scrolls;
		}

		public function get potions() : Array
		{
			return _potions;
		}

		public function set potions(potions : Array) : void
		{
			_potions = potions;
		}

		public function get containers() : Array
		{
			return _containers;
		}

		public function set containers(containers : Array) : void
		{
			_containers = containers;
		}

		public function get misc() : Array
		{
			return _misc;
		}

		public function set misc(misc : Array) : void
		{
			_misc = misc;
		}

		public function get missiles() : Array
		{
			return _missiles;
		}

		public function set missiles(missiles : Array) : void
		{
			_missiles = missiles;
		}

		public function get clouds() : Array
		{
			return _clouds;
		}

		public function set clouds(clouds : Array) : void
		{
			_clouds = clouds;
		}


	}
}