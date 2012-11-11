package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class CloseInventoryAction extends Object implements Action
    {

        public function CloseInventoryAction()
        {
            return;
        }// end function

        public static function create() : CloseInventoryAction
        {
            var _loc_1:* = new CloseInventoryAction;
            return _loc_1;
        }// end function

    }
}
