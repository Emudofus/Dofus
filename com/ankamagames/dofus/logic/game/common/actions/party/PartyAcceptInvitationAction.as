package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PartyAcceptInvitationAction extends Object implements Action
    {
        public var partyId:int;

        public function PartyAcceptInvitationAction()
        {
            return;
        }// end function

        public static function create(param1:int) : PartyAcceptInvitationAction
        {
            var _loc_2:* = new PartyAcceptInvitationAction;
            _loc_2.partyId = param1;
            return _loc_2;
        }// end function

    }
}
