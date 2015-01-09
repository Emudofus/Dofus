package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PartyRefuseInvitationAction implements Action 
    {

        public var partyId:int;


        public static function create(partyId:int):PartyRefuseInvitationAction
        {
            var a:PartyRefuseInvitationAction = new (PartyRefuseInvitationAction)();
            a.partyId = partyId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

