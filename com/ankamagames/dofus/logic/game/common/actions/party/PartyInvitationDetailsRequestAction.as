package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PartyInvitationDetailsRequestAction extends Object implements Action
    {
        public var partyId:int;

        public function PartyInvitationDetailsRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int) : PartyInvitationDetailsRequestAction
        {
            var _loc_2:* = new PartyInvitationDetailsRequestAction;
            _loc_2.partyId = param1;
            return _loc_2;
        }// end function

    }
}
