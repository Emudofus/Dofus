package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ClearChatAction extends Object implements Action
    {
        public var channel:Array;

        public function ClearChatAction()
        {
            return;
        }// end function

        public static function create(param1:Array) : ClearChatAction
        {
            var _loc_2:* = new ClearChatAction;
            _loc_2.channel = param1;
            return _loc_2;
        }// end function

    }
}
