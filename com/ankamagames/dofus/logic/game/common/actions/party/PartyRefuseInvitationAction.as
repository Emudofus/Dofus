package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PartyRefuseInvitationAction extends Object implements Action
    {
        public var partyId:int;

        public function PartyRefuseInvitationAction()
        {
            return;
        }// end function

        public static function create(param1:int) : PartyRefuseInvitationAction
        {
            var _loc_2:* = new PartyRefuseInvitationAction;
            _loc_2.partyId = param1;
            return _loc_2;
        }// end function

    }
}
