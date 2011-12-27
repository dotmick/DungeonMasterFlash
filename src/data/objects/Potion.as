package data.objects
{
	import data.objects.GenericObject;

	/**
	 * @author dotmick
	 */
	public class Potion extends GenericObject
	{
		private var _isPowerVisible : Boolean; //(int(n / 40) = visible level)
		private var _type : int;
		private var _power : int;

		public function Potion()
		{
		}

		public function get isPowerVisible() : Boolean
		{
			return _isPowerVisible;
		}

		public function set isPowerVisible(isPowerVisible : Boolean) : void
		{
			_isPowerVisible = isPowerVisible;
		}

		public function get type() : int
		{
			return _type;
		}

		public function set type(type : int) : void
		{
			_type = type;
		}

		public function get power() : int
		{
			return _power;
		}

		public function set power(power : int) : void
		{
			_power = power;
		}
	}
}
