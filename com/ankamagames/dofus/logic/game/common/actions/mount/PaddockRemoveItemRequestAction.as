package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PaddockRemoveItemRequestAction extends Object implements Action
    {
        public var cellId:uint;

        public function PaddockRemoveItemRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : PaddockRemoveItemRequestAction
        {
            var _loc_2:* = new PaddockRemoveItemRequestAction;
            _loc_2.cellId = param1;
            return _loc_2;
        }// end function

    }
}
