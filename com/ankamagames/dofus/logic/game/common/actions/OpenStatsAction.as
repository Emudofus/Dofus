package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class OpenStatsAction extends Object implements Action
    {

        public function OpenStatsAction()
        {
            return;
        }// end function

        public static function create() : OpenStatsAction
        {
            var _loc_1:* = new OpenStatsAction;
            return _loc_1;
        }// end function

    }
}
