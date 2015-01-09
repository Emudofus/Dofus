package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PartyLeaveRequestAction implements Action 
    {

        public var partyId:int;


        public static function create(partyId:int):PartyLeaveRequestAction
        {
            var a:PartyLeaveRequestAction = new (PartyLeaveRequestAction)();
            a.partyId = partyId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

