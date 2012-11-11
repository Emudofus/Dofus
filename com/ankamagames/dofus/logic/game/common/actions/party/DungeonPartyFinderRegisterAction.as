package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class DungeonPartyFinderRegisterAction extends Object implements Action
    {
        public var dungeons:Array;

        public function DungeonPartyFinderRegisterAction()
        {
            return;
        }// end function

        public static function create(param1:Array) : DungeonPartyFinderRegisterAction
        {
            var _loc_2:* = new DungeonPartyFinderRegisterAction;
            _loc_2.dungeons = param1;
            return _loc_2;
        }// end function

    }
}
