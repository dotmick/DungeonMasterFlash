package data.objects
{
	import data.objects.GenericObject;

	/**
	 * @author dotmick
	 */
	public class Creature extends GenericObject
	{
		private var _nextPossessionObjectID:int;
		private var _type:int;
		private var _positions:Array = [4];
		private var _hitPoints:Array = [4];
		private var _importantObject:Boolean;
		private var _direction:String;
		private var _number:int;
		private var _gameOnly1:int;
		private var _gameOnly2:int;
		
		public function Creature()
		{
		}

		public function get nextPossessionObjectID() : int
		{
			return _nextPossessionObjectID;
		}

		public function set nextPossessionObjectID(nextPossessionObjectID : int) : void
		{
			_nextPossessionObjectID = nextPossessionObjectID;
		}

		public function get type() : int
		{
			return _type;
		}

		public function set type(type : int) : void
		{
			_type = type;
		}

		public function get positions() : Array
		{
			return _positions;
		}

		public function set positions(positions : Array) : void
		{
			_positions = positions;
		}

		public function get hitPoints() : Array
		{
			return _hitPoints;
		}

		public function set hitPoints(hitPoints : Array) : void
		{
			_hitPoints = hitPoints;
		}

		public function get importantObject() : Boolean
		{
			return _importantObject;
		}

		public function set importantObject(importantObject : Boolean) : void
		{
			_importantObject = importantObject;
		}

		public function get direction() : String
		{
			return _direction;
		}

		public function set direction(direction : String) : void
		{
			_direction = direction;
		}

		public function get number() : int
		{
			return _number;
		}

		public function set number(number : int) : void
		{
			_number = number;
		}

		public function get gameOnly1() : int
		{
			return _gameOnly1;
		}

		public function set gameOnly1(gameOnly1 : int) : void
		{
			_gameOnly1 = gameOnly1;
		}

		public function get gameOnly2() : int
		{
			return _gameOnly2;
		}

		public function set gameOnly2(gameOnly2 : int) : void
		{
			_gameOnly2 = gameOnly2;
		}
	}
}
