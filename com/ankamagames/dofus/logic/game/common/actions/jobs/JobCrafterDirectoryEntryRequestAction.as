package com.ankamagames.dofus.logic.game.common.actions.jobs
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class JobCrafterDirectoryEntryRequestAction implements Action 
    {

        public var playerId:uint;


        public static function create(playerId:uint):JobCrafterDirectoryEntryRequestAction
        {
            var act:JobCrafterDirectoryEntryRequestAction = new (JobCrafterDirectoryEntryRequestAction)();
            act.playerId = playerId;
            return (act);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.jobs

