package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class HouseGuildRightsChangeAction extends Object implements Action
    {
        public var rights:int;

        public function HouseGuildRightsChangeAction()
        {
            return;
        }// end function

        public static function create(param1:int) : HouseGuildRightsChangeAction
        {
            var _loc_2:* = new HouseGuildRightsChangeAction;
            _loc_2.rights = param1;
            return _loc_2;
        }// end function

    }
}
