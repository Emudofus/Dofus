package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PartyShowMenuAction extends Object implements Action
    {
        public var playerId:uint;
        public var partyId:int;

        public function PartyShowMenuAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:int) : PartyShowMenuAction
        {
            var _loc_3:* = new PartyShowMenuAction;
            _loc_3.playerId = param1;
            _loc_3.partyId = param2;
            return _loc_3;
        }// end function

    }
}
