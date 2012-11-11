package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ArenaUnregisterAction extends Object implements Action
    {

        public function ArenaUnregisterAction()
        {
            return;
        }// end function

        public static function create() : ArenaUnregisterAction
        {
            var _loc_1:* = new ArenaUnregisterAction;
            return _loc_1;
        }// end function

    }
}
