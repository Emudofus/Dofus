package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PaddockBuyRequestAction implements Action 
    {

        public var proposedPrice:uint;


        public static function create(proposedPrice:uint):PaddockBuyRequestAction
        {
            var action:PaddockBuyRequestAction = new (PaddockBuyRequestAction)();
            action.proposedPrice = proposedPrice;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.mount

