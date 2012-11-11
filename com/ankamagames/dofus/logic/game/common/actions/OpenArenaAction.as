package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class OpenArenaAction extends Object implements Action
    {

        public function OpenArenaAction()
        {
            return;
        }// end function

        public static function create() : OpenArenaAction
        {
            var _loc_1:* = new OpenArenaAction;
            return _loc_1;
        }// end function

    }
}
