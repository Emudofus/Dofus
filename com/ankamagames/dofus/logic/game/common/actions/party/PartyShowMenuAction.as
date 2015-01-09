package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PartyShowMenuAction implements Action 
    {

        public var playerId:uint;
        public var partyId:int;


        public static function create(pPlayerId:uint, pPartyId:int):PartyShowMenuAction
        {
            var a:PartyShowMenuAction = new (PartyShowMenuAction)();
            a.playerId = pPlayerId;
            a.partyId = pPartyId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

