package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PartyAcceptInvitationAction implements Action 
    {

        public var partyId:int;


        public static function create(partyId:int):PartyAcceptInvitationAction
        {
            var a:PartyAcceptInvitationAction = new (PartyAcceptInvitationAction)();
            a.partyId = partyId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

