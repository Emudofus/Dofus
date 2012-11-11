package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class OpenTeamSearchAction extends Object implements Action
    {

        public function OpenTeamSearchAction()
        {
            return;
        }// end function

        public static function create() : OpenTeamSearchAction
        {
            var _loc_1:* = new OpenTeamSearchAction;
            return _loc_1;
        }// end function

    }
}
