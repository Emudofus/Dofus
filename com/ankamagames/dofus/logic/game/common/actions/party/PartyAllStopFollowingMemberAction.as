package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PartyAllStopFollowingMemberAction implements Action 
    {

        public var playerId:uint;
        public var partyId:int;


        public static function create(partyId:int, pPlayerId:uint):PartyAllStopFollowingMemberAction
        {
            var a:PartyAllStopFollowingMemberAction = new (PartyAllStopFollowingMemberAction)();
            a.partyId = partyId;
            a.playerId = pPlayerId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

