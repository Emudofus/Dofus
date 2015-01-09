package com.ankamagames.dofus.logic.game.common.actions.jobs
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class JobCrafterContactLookRequestAction implements Action 
    {

        public var crafterId:uint;


        public static function create(crafterId:uint):JobCrafterContactLookRequestAction
        {
            var act:JobCrafterContactLookRequestAction = new (JobCrafterContactLookRequestAction)();
            act.crafterId = crafterId;
            return (act);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.jobs

