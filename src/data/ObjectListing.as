package data
{
	public class ObjectListing
	{
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
	}
}