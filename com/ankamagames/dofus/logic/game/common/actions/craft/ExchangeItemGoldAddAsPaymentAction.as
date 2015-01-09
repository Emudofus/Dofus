package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeItemGoldAddAsPaymentAction implements Action 
    {

        public var onlySuccess:Boolean;
        public var kamas:uint;


        public static function create(pOnlySuccess:Boolean, pKamas:uint):ExchangeItemGoldAddAsPaymentAction
        {
            var action:ExchangeItemGoldAddAsPaymentAction = new (ExchangeItemGoldAddAsPaymentAction)();
            action.onlySuccess = pOnlySuccess;
            action.kamas = pKamas;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.craft

