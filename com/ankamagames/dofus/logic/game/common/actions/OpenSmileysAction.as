package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class OpenSmileysAction extends Object implements Action
    {
        public var type:uint;
        public var forceOpen:String;

        public function OpenSmileysAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:String = "") : OpenSmileysAction
        {
            var _loc_3:* = new OpenSmileysAction;
            _loc_3.type = param1;
            _loc_3.forceOpen = param2;
            return _loc_3;
        }// end function

    }
}
