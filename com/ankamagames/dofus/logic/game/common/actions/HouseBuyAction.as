package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class HouseBuyAction implements Action 
    {

        public var proposedPrice:uint;


        public static function create(proposedPrice:uint):HouseBuyAction
        {
            var action:HouseBuyAction = new (HouseBuyAction)();
            action.proposedPrice = proposedPrice;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

