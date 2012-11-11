package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PlayerFightRequestAction extends Object implements Action
    {
        public var targetedPlayerId:uint;
        public var cellId:int;
        public var friendly:Boolean;
        public var launch:Boolean;

        public function PlayerFightRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:Boolean = true, param3:Boolean = false, param4:int = -1) : PlayerFightRequestAction
        {
            var _loc_5:* = new PlayerFightRequestAction;
            new PlayerFightRequestAction.friendly = param2;
            _loc_5.cellId = param4;
            _loc_5.targetedPlayerId = param1;
            _loc_5.launch = param3;
            return _loc_5;
        }// end function

    }
}
