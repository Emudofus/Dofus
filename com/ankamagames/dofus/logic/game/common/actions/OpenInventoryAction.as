package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class OpenInventoryAction extends Object implements Action
    {
        public var behavior:String;

        public function OpenInventoryAction()
        {
            return;
        }// end function

        public static function create(param1:String = "bag") : OpenInventoryAction
        {
            var _loc_2:* = new OpenInventoryAction;
            _loc_2.behavior = param1;
            return _loc_2;
        }// end function

    }
}
