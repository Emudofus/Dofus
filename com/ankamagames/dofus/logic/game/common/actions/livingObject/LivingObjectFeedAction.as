package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class LivingObjectFeedAction extends Object implements Action
    {
        public var objectUID:uint;
        public var foodUID:uint;
        public var foodQuantity:uint;

        public function LivingObjectFeedAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint) : LivingObjectFeedAction
        {
            var _loc_4:* = new LivingObjectFeedAction;
            new LivingObjectFeedAction.objectUID = param1;
            _loc_4.foodUID = param2;
            _loc_4.foodQuantity = param3;
            return _loc_4;
        }// end function

    }
}
