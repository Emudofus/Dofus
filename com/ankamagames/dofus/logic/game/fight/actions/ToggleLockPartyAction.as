package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ToggleLockPartyAction extends Object implements Action
    {

        public function ToggleLockPartyAction()
        {
            return;
        }// end function

        public static function create() : ToggleLockPartyAction
        {
            var _loc_1:* = new ToggleLockPartyAction;
            return _loc_1;
        }// end function

    }
}
