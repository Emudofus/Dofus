package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class SubscribersGiftListRequestAction implements Action 
    {


        public static function create():SubscribersGiftListRequestAction
        {
            var action:SubscribersGiftListRequestAction = new (SubscribersGiftListRequestAction)();
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions

