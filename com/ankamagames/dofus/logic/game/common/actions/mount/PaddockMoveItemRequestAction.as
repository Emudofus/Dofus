package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PaddockMoveItemRequestAction extends Object implements Action
    {
        public var object:Object;

        public function PaddockMoveItemRequestAction()
        {
            return;
        }// end function

        public static function create(param1:Object) : PaddockMoveItemRequestAction
        {
            var _loc_2:* = new PaddockMoveItemRequestAction;
            _loc_2.object = param1;
            return _loc_2;
        }// end function

    }
}
