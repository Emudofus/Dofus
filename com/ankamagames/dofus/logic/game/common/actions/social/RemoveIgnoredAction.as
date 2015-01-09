package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class RemoveIgnoredAction implements Action 
    {

        public var accountId:int;


        public static function create(accountId:int):RemoveIgnoredAction
        {
            var a:RemoveIgnoredAction = new (RemoveIgnoredAction)();
            a.accountId = accountId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

