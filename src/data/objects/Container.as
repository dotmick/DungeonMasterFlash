package data.objects
{
	import data.objects.GenericObject;

	/**
	 * @author dotmick
	 */
	public class Container extends GenericObject
	{
		private var _nextContainedObjectID : int;
		private var _type : int; //(in DM and CBS only chests are allowed)
		private var _unknow1 : int;
		private var _unknow2 : int;

		public function Container()
		{
		}

		public function get nextContainedObjectID() : int
		{
			return _nextContainedObjectID;
		}

		public function set nextContainedObjectID(nextContainedObjectID : int) : void
		{
			_nextContainedObjectID = nextContainedObjectID;
		}

		public function get type() : int
		{
			return _type;
		}

		public function set type(type : int) : void
		{
			_type = type;
		}

		public function get unknow1() : int
		{
			return _unknow1;
		}

		public function set unknow1(unknow1 : int) : void
		{
			_unknow1 = unknow1;
		}

		public function get unknow2() : int
		{
			return _unknow2;
		}

		public function set unknow2(unknow2 : int) : void
		{
			_unknow2 = unknow2;
		}
	}
}
