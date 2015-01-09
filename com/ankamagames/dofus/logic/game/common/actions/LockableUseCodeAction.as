package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class LockableUseCodeAction implements Action 
    {

        public var code:String;


        public static function create(code:String):LockableUseCodeAction
        {
            var action:LockableUseCodeAction = new (LockableUseCodeAction)();
            action.code = code;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

