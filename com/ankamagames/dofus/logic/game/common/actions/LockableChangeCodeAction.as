package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class LockableChangeCodeAction implements Action 
    {

        public var code:String;


        public static function create(code:String):LockableChangeCodeAction
        {
            var action:LockableChangeCodeAction = new (LockableChangeCodeAction)();
            action.code = code;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

