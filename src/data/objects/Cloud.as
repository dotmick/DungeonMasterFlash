package data.objects
{
	import data.objects.GenericObject;

	/**
	 * @author dotmick
	 */
	public class Cloud extends GenericObject
	{
		/*
			Used for Waterskin / Compass / Bones

		    '00' Empty / North / Champion #1
		    '01' Almost empty / East / Champion #2
		    '10' Almost full / South / Champion #3
		    '11' Full / West / Champion #4
		
			Also used by Illumulet & Jewel Symal (worn / not worn).
		*/
		private var _mainValue:int;
		
		private var _type:int;
		private var _unknow:Boolean;
		
		public function Cloud()
		{
		}

		public function get mainValue() : int
		{
			return _mainValue;
		}

		public function set mainValue(mainValue : int) : void
		{
			_mainValue = mainValue;
		}

		public function get type() : int
		{
			return _type;
		}

		public function set type(type : int) : void
		{
			_type = type;
		}

		public function get unknow() : Boolean
		{
			return _unknow;
		}

		public function set unknow(unknow : Boolean) : void
		{
			_unknow = unknow;
		}
	}
}
