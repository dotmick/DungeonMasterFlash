package data.objects
{
	import data.objects.GenericObject;

	/**
	 * @author dotmick
	 */
	public class Scroll extends GenericObject
	{
		private var _closed : Boolean; // (if not == in hand)
		private var _referredText : int; // (in texts list)
		
		
		public function Scroll()
		{
		}

		public function get closed() : Boolean
		{
			return _closed;
		}

		public function set closed(closed : Boolean) : void
		{
			_closed = closed;
		}

		public function get referredText() : int
		{
			return _referredText;
		}

		public function set referredText(referredText : int) : void
		{
			_referredText = referredText;
		}
	}
}
