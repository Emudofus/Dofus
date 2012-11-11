package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class HouseKickIndoorMerchantAction extends Object implements Action
    {
        public var cellId:uint;

        public function HouseKickIndoorMerchantAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : HouseKickIndoorMerchantAction
        {
            var _loc_2:* = new HouseKickIndoorMerchantAction;
            _loc_2.cellId = param1;
            return _loc_2;
        }// end function

    }
}
