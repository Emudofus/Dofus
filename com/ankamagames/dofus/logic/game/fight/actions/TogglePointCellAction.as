package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class TogglePointCellAction extends Object implements Action
    {

        public function TogglePointCellAction()
        {
            return;
        }// end function

        public static function create() : TogglePointCellAction
        {
            var _loc_1:* = new TogglePointCellAction;
            return _loc_1;
        }// end function

    }
}
