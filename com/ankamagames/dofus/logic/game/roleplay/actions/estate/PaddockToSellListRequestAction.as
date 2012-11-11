package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PaddockToSellListRequestAction extends Object implements Action
    {
        public var pageIndex:uint;

        public function PaddockToSellListRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : PaddockToSellListRequestAction
        {
            var _loc_2:* = new PaddockToSellListRequestAction;
            _loc_2.pageIndex = param1;
            return _loc_2;
        }// end function

    }
}
