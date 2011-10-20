package data.objects
{
	public class Text
	{
		private var _nextObjectID:int;
		private var _referredTextInTextData:int;
		private var _isComplex:Boolean;
		private var _actuator:Boolean;
		private var _visible:Boolean;
		
		public function Text()
		{
		}

		public function get nextObjectID():int
		{
			return _nextObjectID;
		}

		public function set nextObjectID(value:int):void
		{
			_nextObjectID = value;
		}

		public function get referredTextInTextData():int
		{
			return _referredTextInTextData;
		}

		public function set referredTextInTextData(value:int):void
		{
			_referredTextInTextData = value;
		}

		public function get isComplex():Boolean
		{
			return _isComplex;
		}

		public function set isComplex(value:Boolean):void
		{
			_isComplex = value;
		}

		public function get actuator():Boolean
		{
			return _actuator;
		}

		public function set actuator(value:Boolean):void
		{
			_actuator = value;
		}

		public function get visible():Boolean
		{
			return _visible;
		}

		public function set visible(value:Boolean):void
		{
			_visible = value;
		}


	}
}