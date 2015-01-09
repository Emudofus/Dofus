package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class LeaveDialogAction implements Action 
    {


        public static function create():LeaveDialogAction
        {
            var action:LeaveDialogAction = new (LeaveDialogAction)();
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

