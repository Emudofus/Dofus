package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class LivingObjectFeedAction implements Action 
    {

        public var objectUID:uint;
        public var foodUID:uint;
        public var foodQuantity:uint;


        public static function create(objectUID:uint, foodUID:uint, foodQuantity:uint):LivingObjectFeedAction
        {
            var action:LivingObjectFeedAction = new (LivingObjectFeedAction)();
            action.objectUID = objectUID;
            action.foodUID = foodUID;
            action.foodQuantity = foodQuantity;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.livingObject

