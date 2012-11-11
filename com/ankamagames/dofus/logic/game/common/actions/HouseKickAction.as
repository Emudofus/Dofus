package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class HouseKickAction extends Object implements Action
    {
        public var id:uint;

        public function HouseKickAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : HouseKickAction
        {
            var _loc_2:* = new HouseKickAction;
            _loc_2.id = param1;
            return _loc_2;
        }// end function

    }
}
