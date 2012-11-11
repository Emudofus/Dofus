package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ToggleDematerializationAction extends Object implements Action
    {

        public function ToggleDematerializationAction()
        {
            return;
        }// end function

        public static function create() : ToggleDematerializationAction
        {
            var _loc_1:* = new ToggleDematerializationAction;
            return _loc_1;
        }// end function

    }
}
