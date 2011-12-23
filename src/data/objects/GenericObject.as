package data.objects
{
	/**
	 * @author dotmick
	 */
	public class GenericObject
	{
		private var _nextObjectID:int;
		
		public function get nextObjectID():int
		{
			return _nextObjectID;
		}

		public function set nextObjectID(value:int):void
		{
			_nextObjectID = value;
		}
	}
}
