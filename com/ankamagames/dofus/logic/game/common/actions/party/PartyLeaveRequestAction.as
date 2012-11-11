package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PartyLeaveRequestAction extends Object implements Action
    {
        public var partyId:int;

        public function PartyLeaveRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int) : PartyLeaveRequestAction
        {
            var _loc_2:* = new PartyLeaveRequestAction;
            _loc_2.partyId = param1;
            return _loc_2;
        }// end function

    }
}
