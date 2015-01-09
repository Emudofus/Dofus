package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class CloseInventoryAction implements Action 
    {


        public static function create():CloseInventoryAction
        {
            var a:CloseInventoryAction = new (CloseInventoryAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

