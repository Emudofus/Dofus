package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ToggleWitnessForbiddenAction extends Object implements Action
    {

        public function ToggleWitnessForbiddenAction()
        {
            return;
        }// end function

        public static function create() : ToggleWitnessForbiddenAction
        {
            var _loc_1:* = new ToggleWitnessForbiddenAction;
            return _loc_1;
        }// end function

    }
}
