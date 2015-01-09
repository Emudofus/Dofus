package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PartyFollowMemberAction implements Action 
    {

        public var playerId:uint;
        public var partyId:int;


        public static function create(partyId:int, pPlayerId:uint):PartyFollowMemberAction
        {
            var a:PartyFollowMemberAction = new (PartyFollowMemberAction)();
            a.partyId = partyId;
            a.playerId = pPlayerId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

