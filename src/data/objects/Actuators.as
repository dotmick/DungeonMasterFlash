package data.objects
{
	import data.objects.GenericObject;

	/**
	 * @author dotmick
	 */
	public class Actuators extends GenericObject
	{
		public static const ACTION_TYPE:Array = ["set", "clear", "toggle", "hold"];
		
		private var _data:int;
		private var _type:int;
		private var _gfxNumber:int; //(0 no decoration)
		private var _isActionTargetTypeLocal:Boolean;
		private var _delayBeforeAction:int;
		private var _hasSoundEffect:Boolean;
		private var _hasRevertEffect:Boolean;
		private var _actionType:String;
		private var _isOnceOnly:Boolean; //(if true > type = 0 after 1st use)
		
		//Remote target only
		private var _targetTileX:int;
		private var _targetTileY:int;
		private var _direction:String;
		
		//Local target only
		private var _actionToExecute:int; //('1-2': rotation of actuators in the same tile, current to beginning, '10': xp gain in ninja skill nb 8, floor -> all champions, wall -> leader only, '0 or other': no action)
		
		public function Actuators()
		{
		}

		public function get data() : int
		{
			return _data;
		}

		public function set data(data : int) : void
		{
			_data = data;
		}

		public function get type() : int
		{
			return _type;
		}

		public function set type(type : int) : void
		{
			_type = type;
		}

		public function get gfxNumber() : int
		{
			return _gfxNumber;
		}

		public function set gfxNumber(gfxNumber : int) : void
		{
			_gfxNumber = gfxNumber;
		}

		public function get isActionTargetTypeLocal() : Boolean
		{
			return _isActionTargetTypeLocal;
		}

		public function set isActionTargetTypeLocal(actionTargetType : Boolean) : void
		{
			_isActionTargetTypeLocal = actionTargetType;
		}

		public function get delayBeforeAction() : int
		{
			return _delayBeforeAction;
		}

		public function set delayBeforeAction(delayBeforeAction : int) : void
		{
			_delayBeforeAction = delayBeforeAction;
		}

		public function get hasSoundEffect() : Boolean
		{
			return _hasSoundEffect;
		}

		public function set hasSoundEffect(soundEffect : Boolean) : void
		{
			_hasSoundEffect = soundEffect;
		}

		public function get hasRevertEffect() : Boolean
		{
			return _hasRevertEffect;
		}

		public function set hasRevertEffect(revertEffect : Boolean) : void
		{
			_hasRevertEffect = revertEffect;
		}

		public function get isOnceOnly() : Boolean
		{
			return _isOnceOnly;
		}

		public function set isOnceOnly(onceOnly : Boolean) : void
		{
			_isOnceOnly = onceOnly;
		}

		public function get targetTileX() : int
		{
			return _targetTileX;
		}

		public function set targetTileX(targetTileX : int) : void
		{
			_targetTileX = targetTileX;
		}

		public function get targetTileY() : int
		{
			return _targetTileY;
		}

		public function set targetTileY(targetTileY : int) : void
		{
			_targetTileY = targetTileY;
		}

		public function get direction() : String
		{
			return _direction;
		}

		public function set direction(direction : String) : void
		{
			_direction = direction;
		}

		public function get actionToExecute() : int
		{
			return _actionToExecute;
		}

		public function set actionToExecute(actionToExecute : int) : void
		{
			_actionToExecute = actionToExecute;
		}

		public function get actionType() : String
		{
			return _actionType;
		}

		public function set actionType(actionType : String) : void
		{
			_actionType = actionType;
		}
	}
}
