package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class NumericWhoIsRequestAction extends Object implements Action
    {
        public var playerId:uint;

        public function NumericWhoIsRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : NumericWhoIsRequestAction
        {
            var _loc_2:* = new NumericWhoIsRequestAction;
            _loc_2.playerId = param1;
            return _loc_2;
        }// end function

    }
}
