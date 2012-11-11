package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class MountFeedRequestAction extends Object implements Action
    {
        public var mountId:uint;
        public var mountLocation:uint;
        public var mountFoodUid:uint;
        public var quantity:uint;

        public function MountFeedRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint, param4:uint) : MountFeedRequestAction
        {
            var _loc_5:* = new MountFeedRequestAction;
            new MountFeedRequestAction.mountId = param1;
            _loc_5.mountLocation = param2 + 1;
            _loc_5.mountFoodUid = param3;
            _loc_5.quantity = param4;
            return _loc_5;
        }// end function

    }
}
