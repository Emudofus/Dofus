package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PartyCancelInvitationAction extends Object implements Action
    {
        public var guestId:int;
        public var partyId:int;

        public function PartyCancelInvitationAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:int) : PartyCancelInvitationAction
        {
            var _loc_3:* = new PartyCancelInvitationAction;
            _loc_3.partyId = param1;
            _loc_3.guestId = param2;
            return _loc_3;
        }// end function

    }
}
