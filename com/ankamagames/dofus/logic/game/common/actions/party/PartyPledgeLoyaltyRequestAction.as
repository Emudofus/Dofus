package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PartyPledgeLoyaltyRequestAction extends Object implements Action
    {
        public var loyal:Boolean;
        public var partyId:int;

        public function PartyPledgeLoyaltyRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:Boolean) : PartyPledgeLoyaltyRequestAction
        {
            var _loc_3:* = new PartyPledgeLoyaltyRequestAction;
            _loc_3.partyId = param1;
            _loc_3.loyal = param2;
            return _loc_3;
        }// end function

    }
}
