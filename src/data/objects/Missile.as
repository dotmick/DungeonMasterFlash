package data.objects
{
	import data.objects.GenericObject;

	/**
	 * @author dotmick
	 */
	public class Missile extends GenericObject
	{
		private var _object : int;
		private var _energyRemaining1 : int;
		private var _energyRemaining2 : int;
		private var _timer : int;

		public function Missile()
		{
		}

		public function get object() : int
		{
			return _object;
		}

		public function set object(object : int) : void
		{
			_object = object;
		}

		public function get energyRemaining1() : int
		{
			return _energyRemaining1;
		}

		public function set energyRemaining1(energyRemaining1 : int) : void
		{
			_energyRemaining1 = energyRemaining1;
		}

		public function get energyRemaining2() : int
		{
			return _energyRemaining2;
		}

		public function set energyRemaining2(energyRemaining2 : int) : void
		{
			_energyRemaining2 = energyRemaining2;
		}

		public function get timer() : int
		{
			return _timer;
		}

		public function set timer(timer : int) : void
		{
			_timer = timer;
		}
	}
}
