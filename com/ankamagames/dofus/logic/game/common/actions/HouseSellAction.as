package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class HouseSellAction implements Action 
    {

        public var amount:uint;


        public static function create(amount:uint):HouseSellAction
        {
            var action:HouseSellAction = new (HouseSellAction)();
            action.amount = amount;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

