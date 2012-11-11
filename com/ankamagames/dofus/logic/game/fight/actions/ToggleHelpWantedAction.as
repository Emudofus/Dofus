package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ToggleHelpWantedAction extends Object implements Action
    {

        public function ToggleHelpWantedAction()
        {
            return;
        }// end function

        public static function create() : ToggleHelpWantedAction
        {
            var _loc_1:* = new ToggleHelpWantedAction;
            return _loc_1;
        }// end function

    }
}
