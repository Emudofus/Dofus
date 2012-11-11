package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ChatTextOutputAction extends Object implements Action
    {
        public var content:String;
        public var channel:uint;
        public var receiverName:String;
        public var objects:Array;

        public function ChatTextOutputAction()
        {
            return;
        }// end function

        public static function create(param1:String, param2:uint = 0, param3:String = "", param4:Array = null) : ChatTextOutputAction
        {
            var _loc_5:* = new ChatTextOutputAction;
            new ChatTextOutputAction.content = param1;
            _loc_5.channel = param2;
            _loc_5.receiverName = param3;
            _loc_5.objects = param4;
            return _loc_5;
        }// end function

    }
}
