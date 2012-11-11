package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class DisableAfkAction extends Object implements Action
    {

        public function DisableAfkAction()
        {
            return;
        }// end function

        public static function create() : DisableAfkAction
        {
            var _loc_1:* = new DisableAfkAction;
            return _loc_1;
        }// end function

    }
}
