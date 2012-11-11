package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class LockableChangeCodeAction extends Object implements Action
    {
        public var code:String;

        public function LockableChangeCodeAction()
        {
            return;
        }// end function

        public static function create(param1:String) : LockableChangeCodeAction
        {
            var _loc_2:* = new LockableChangeCodeAction;
            _loc_2.code = param1;
            return _loc_2;
        }// end function

    }
}
