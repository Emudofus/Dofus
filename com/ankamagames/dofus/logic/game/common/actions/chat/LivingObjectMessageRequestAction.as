package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class LivingObjectMessageRequestAction extends Object implements Action
    {
        public var msgId:uint;
        public var livingObjectUID:uint;

        public function LivingObjectMessageRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : LivingObjectMessageRequestAction
        {
            var _loc_3:* = new LivingObjectMessageRequestAction;
            _loc_3.msgId = param1;
            _loc_3.livingObjectUID = param2;
            return _loc_3;
        }// end function

    }
}
