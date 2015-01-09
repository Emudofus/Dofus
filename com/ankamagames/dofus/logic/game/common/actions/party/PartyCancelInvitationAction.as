package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PartyCancelInvitationAction implements Action 
    {

        public var guestId:int;
        public var partyId:int;


        public static function create(partyId:int, guestId:int):PartyCancelInvitationAction
        {
            var a:PartyCancelInvitationAction = new (PartyCancelInvitationAction)();
            a.partyId = partyId;
            a.guestId = guestId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

