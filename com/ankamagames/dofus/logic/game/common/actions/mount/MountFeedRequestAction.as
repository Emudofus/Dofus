package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class MountFeedRequestAction implements Action 
    {

        public var mountId:uint;
        public var mountLocation:uint;
        public var mountFoodUid:uint;
        public var quantity:uint;


        public static function create(mountId:uint, mountLocation:uint, mountFoodUid:uint, quantity:uint):MountFeedRequestAction
        {
            var a:MountFeedRequestAction = new (MountFeedRequestAction)();
            a.mountId = mountId;
            a.mountLocation = (mountLocation + 1);
            a.mountFoodUid = mountFoodUid;
            a.quantity = quantity;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.mount

