package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class JobAllowMultiCraftRequestSetAction implements Action 
    {

        public var isPublic:Boolean;


        public static function create(pIsPublic:Boolean):JobAllowMultiCraftRequestSetAction
        {
            var action:JobAllowMultiCraftRequestSetAction = new (JobAllowMultiCraftRequestSetAction)();
            action.isPublic = pIsPublic;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.craft

