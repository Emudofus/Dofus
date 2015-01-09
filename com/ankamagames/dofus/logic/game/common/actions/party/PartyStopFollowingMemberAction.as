package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PartyStopFollowingMemberAction implements Action 
    {

        public var playerId:uint;
        public var partyId:int;


        public static function create(partyId:int, pPlayerId:uint):PartyStopFollowingMemberAction
        {
            var a:PartyStopFollowingMemberAction = new (PartyStopFollowingMemberAction)();
            a.partyId = partyId;
            a.playerId = pPlayerId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

