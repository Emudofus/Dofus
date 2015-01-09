package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class NotificationResetAction implements Action 
    {


        public static function create():NotificationResetAction
        {
            var action:NotificationResetAction = new (NotificationResetAction)();
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

