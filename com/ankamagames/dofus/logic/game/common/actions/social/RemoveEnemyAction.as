package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class RemoveEnemyAction implements Action 
    {

        public var accountId:int;


        public static function create(accountId:int):RemoveEnemyAction
        {
            var a:RemoveEnemyAction = new (RemoveEnemyAction)();
            a.accountId = accountId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

