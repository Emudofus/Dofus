package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeObjectUseInWorkshopAction implements Action 
    {

        public var objectUID:uint;
        public var quantity:uint;


        public static function create(pObjectUID:uint, pQuantity:uint):ExchangeObjectUseInWorkshopAction
        {
            var action:ExchangeObjectUseInWorkshopAction = new (ExchangeObjectUseInWorkshopAction)();
            action.objectUID = pObjectUID;
            action.quantity = pQuantity;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.craft

