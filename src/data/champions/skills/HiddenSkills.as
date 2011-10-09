package data.champions.skills
{
	public class HiddenSkills
	{
		private var _fighter	:FighterSkills;
		private var _ninja		:NinjaSkills;
		private var _wizard		:WizardSkills;
		private var _priest		:PriestSkills;
		
		public function HiddenSkills()
		{
			fighter = new FighterSkills();
			ninja = new NinjaSkills();
			wizard = new WizardSkills();
			priest = new PriestSkills();
		}

		public function get fighter():FighterSkills
		{
			return _fighter;
		}

		public function set fighter(value:FighterSkills):void
		{
			_fighter = value;
		}

		public function get ninja():NinjaSkills
		{
			return _ninja;
		}

		public function set ninja(value:NinjaSkills):void
		{
			_ninja = value;
		}

		public function get wizard():WizardSkills
		{
			return _wizard;
		}

		public function set wizard(value:WizardSkills):void
		{
			_wizard = value;
		}

		public function get priest():PriestSkills
		{
			return _priest;
		}

		public function set priest(value:PriestSkills):void
		{
			_priest = value;
		}


	}
}