package data.objects
{
	public class Door extends GenericObject
	{
		private var _unused:int;
		private var _bashable:Boolean;
		private var _destroyable:Boolean;
		private var _button:Boolean;
		private var _vertical:Boolean;
		private var _ornate:int; //(0 no ornate)
		private var _type:int;
		
		public function Door()
		{
		}

		public function get unused():int
		{
			return _unused;
		}

		public function set unused(value:int):void
		{
			_unused = value;
		}

		public function get bashable():Boolean
		{
			return _bashable;
		}

		public function set bashable(value:Boolean):void
		{
			_bashable = value;
		}

		public function get destroyable():Boolean
		{
			return _destroyable;
		}

		public function set destroyable(value:Boolean):void
		{
			_destroyable = value;
		}

		public function get button():Boolean
		{
			return _button;
		}

		public function set button(value:Boolean):void
		{
			_button = value;
		}

		public function get vertical():Boolean
		{
			return _vertical;
		}

		public function set vertical(value:Boolean):void
		{
			_vertical = value;
		}

		public function get ornate():int
		{
			return _ornate;
		}

		public function set ornate(value:int):void
		{
			_ornate = value;
		}

		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
		}


	}
}