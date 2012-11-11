package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class DungeonPartyFinderAvailableDungeonsAction extends Object implements Action
    {

        public function DungeonPartyFinderAvailableDungeonsAction()
        {
            return;
        }// end function

        public static function create() : DungeonPartyFinderAvailableDungeonsAction
        {
            var _loc_1:* = new DungeonPartyFinderAvailableDungeonsAction;
            return _loc_1;
        }// end function

    }
}
