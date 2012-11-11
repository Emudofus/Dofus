package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class JoinFightRequestAction extends Object implements Action
    {
        public var fightId:uint;
        public var teamLeaderId:uint;

        public function JoinFightRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : JoinFightRequestAction
        {
            var _loc_3:* = new JoinFightRequestAction;
            _loc_3.fightId = param1;
            _loc_3.teamLeaderId = param2;
            return _loc_3;
        }// end function

    }
}
