package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class NotificationUpdateFlagAction implements Action 
    {

        public var index:uint;


        public static function create(index:uint):NotificationUpdateFlagAction
        {
            var action:NotificationUpdateFlagAction = new (NotificationUpdateFlagAction)();
            action.index = index;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

