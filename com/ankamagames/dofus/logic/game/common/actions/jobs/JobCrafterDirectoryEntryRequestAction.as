package com.ankamagames.dofus.logic.game.common.actions.jobs
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class JobCrafterDirectoryEntryRequestAction extends Object implements Action
    {
        public var playerId:uint;

        public function JobCrafterDirectoryEntryRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : JobCrafterDirectoryEntryRequestAction
        {
            var _loc_2:* = new JobCrafterDirectoryEntryRequestAction;
            _loc_2.playerId = param1;
            return _loc_2;
        }// end function

    }
}
