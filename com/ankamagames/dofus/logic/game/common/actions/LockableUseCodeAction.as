package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class LockableUseCodeAction extends Object implements Action
    {
        public var code:String;

        public function LockableUseCodeAction()
        {
            return;
        }// end function

        public static function create(param1:String) : LockableUseCodeAction
        {
            var _loc_2:* = new LockableUseCodeAction;
            _loc_2.code = param1;
            return _loc_2;
        }// end function

    }
}
