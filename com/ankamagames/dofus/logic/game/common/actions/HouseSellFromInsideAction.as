package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class HouseSellFromInsideAction implements Action 
    {

        public var amount:uint;


        public static function create(amount:uint):HouseSellFromInsideAction
        {
            var action:HouseSellFromInsideAction = new (HouseSellFromInsideAction)();
            action.amount = amount;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

