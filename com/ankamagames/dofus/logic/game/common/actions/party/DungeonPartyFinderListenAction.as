package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class DungeonPartyFinderListenAction extends Object implements Action
    {
        public var dungeonId:uint;

        public function DungeonPartyFinderListenAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : DungeonPartyFinderListenAction
        {
            var _loc_2:* = new DungeonPartyFinderListenAction;
            _loc_2.dungeonId = param1;
            return _loc_2;
        }// end function

    }
}
