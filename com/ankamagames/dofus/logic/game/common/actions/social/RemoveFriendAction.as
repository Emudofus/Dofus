package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class RemoveFriendAction implements Action 
    {

        public var accountId:int;


        public static function create(accountId:int):RemoveFriendAction
        {
            var a:RemoveFriendAction = new (RemoveFriendAction)();
            a.accountId = accountId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

