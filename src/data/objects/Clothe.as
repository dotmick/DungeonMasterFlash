package data.objects
{
	import data.objects.GenericObject;

	/**
	 * @author dotmick
	 */
	public class Clothe extends GenericObject
	{
		private var _broken:Boolean;
		private var _nbOfCharges:int; //(Luminous Power for Torches)
		private var _cursed:Boolean; //(in CSB not in DM)
		private var _important:Boolean;
		private var _type:int;
		
		public function Clothe()
		{
		}

		public function get broken() : Boolean
		{
			return _broken;
		}

		public function set broken(broken : Boolean) : void
		{
			_broken = broken;
		}

		public function get nbOfCharges() : int
		{
			return _nbOfCharges;
		}

		public function set nbOfCharges(nbOfCharges : int) : void
		{
			_nbOfCharges = nbOfCharges;
		}

		public function get cursed() : Boolean
		{
			return _cursed;
		}

		public function set cursed(cursed : Boolean) : void
		{
			_cursed = cursed;
		}

		public function get important() : Boolean
		{
			return _important;
		}

		public function set important(important : Boolean) : void
		{
			_important = important;
		}

		public function get type() : int
		{
			return _type;
		}

		public function set type(type : int) : void
		{
			_type = type;
		}
	}
}
