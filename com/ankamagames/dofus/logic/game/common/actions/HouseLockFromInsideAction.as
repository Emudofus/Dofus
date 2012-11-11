package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class HouseLockFromInsideAction extends Object implements Action
    {
        public var code:String;

        public function HouseLockFromInsideAction()
        {
            return;
        }// end function

        public static function create(param1:String) : HouseLockFromInsideAction
        {
            var _loc_2:* = new HouseLockFromInsideAction;
            _loc_2.code = param1;
            return _loc_2;
        }// end function

    }
}
