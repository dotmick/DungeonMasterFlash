package data.champions
{
	import com.doesflash.utils.toStr;
	
	import data.champions.skills.HiddenSkills;
	import data.TextData;

	public class ChampionData
	{
		public var name:String;
		public var title:String;
		public var gender:String;
		public var health:int;
		public var stamina:int;
		public var mana:int;
		public var luck:int;
		public var strength:int;
		public var dexterity:int;
		public var wisdom:int;
		public var vitality:int;
		public var antiMagic:int;
		public var antiFire:int;
		public var hiddenSkills:HiddenSkills;
		
		public function ChampionData(_data:String)
		{
			var d:Array = _data.split(TextData.CODE[28]);
			
			if( d.length != 7 ) return; 
			
			name 	= d[0];
			title 	= d[1];
			gender 	= d[3];
			
			health	= (d[4] != "")?TextData.backToCode( (d[4] as String).substr(0, 4), true):-1;
			stamina	= (d[4] != "")?TextData.backToCode( (d[4] as String).substr(4, 4), true):-1;
			mana	= (d[4] != "")?TextData.backToCode( (d[4] as String).substr(8, 4), true):-1;
			
			luck	= (d[5] != "")?TextData.backToCode( (d[5] as String).substr(0, 2), true):-1;
			strength= (d[5] != "")?TextData.backToCode( (d[5] as String).substr(2, 2), true):-1;
			dexterity= (d[5] != "")?TextData.backToCode( (d[5] as String).substr(4, 2), true):-1;
			wisdom	= (d[5] != "")?TextData.backToCode( (d[5] as String).substr(6, 2), true):-1;
			vitality= (d[5] != "")?TextData.backToCode( (d[5] as String).substr(8, 2), true):-1;
			antiMagic= (d[5] != "")?TextData.backToCode( (d[5] as String).substr(10, 2), true):-1;
			antiFire= (d[5] != "")?TextData.backToCode( (d[5] as String).substr(12, 2), true):-1;
			
			hiddenSkills = new HiddenSkills();
			
			hiddenSkills.fighter.swing = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(0, 1), true):-1;
			hiddenSkills.fighter.thrust = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(1, 1), true):-1;
			hiddenSkills.fighter.club = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(2, 1), true):-1;
			hiddenSkills.fighter.parry = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(3, 1), true):-1;
			
			hiddenSkills.ninja.steal = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(4, 1), true):-1;
			hiddenSkills.ninja.fight = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(5, 1), true):-1;
			hiddenSkills.ninja.throww = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(6, 1), true):-1;
			hiddenSkills.ninja.shoot = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(7, 1), true):-1;
			
			hiddenSkills.wizard.identify = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(8, 1), true):-1;
			hiddenSkills.wizard.heal = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(9, 1), true):-1;
			hiddenSkills.wizard.influence = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(10, 1), true):-1;
			hiddenSkills.wizard.defend = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(11, 1), true):-1;
			
			hiddenSkills.priest.fire = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(12, 1), true):-1;
			hiddenSkills.priest.air = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(13, 1), true):-1;
			hiddenSkills.priest.earth = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(14, 1), true):-1;
			hiddenSkills.priest.water = (d[6] != "")?TextData.backToCode( (d[6] as String).substr(15, 1), true):-1;
		}
		
		public function toString() : String
		{
			return toStr(this);
		}
	}
}