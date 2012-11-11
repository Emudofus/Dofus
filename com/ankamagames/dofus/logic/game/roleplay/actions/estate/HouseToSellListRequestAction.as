package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class HouseToSellListRequestAction extends Object implements Action
    {
        public var pageIndex:uint;

        public function HouseToSellListRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : HouseToSellListRequestAction
        {
            var _loc_2:* = new HouseToSellListRequestAction;
            _loc_2.pageIndex = param1;
            return _loc_2;
        }// end function

    }
}
