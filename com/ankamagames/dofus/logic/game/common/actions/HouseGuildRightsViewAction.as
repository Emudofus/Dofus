package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class HouseGuildRightsViewAction extends Object implements Action
    {

        public function HouseGuildRightsViewAction()
        {
            return;
        }// end function

        public static function create() : HouseGuildRightsViewAction
        {
            var _loc_1:* = new HouseGuildRightsViewAction;
            return _loc_1;
        }// end function

    }
}
