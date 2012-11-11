package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ChatReportAction extends Object implements Action
    {
        public var reportedId:uint;
        public var reason:uint;
        public var channel:uint;
        public var timestamp:Number;
        public var fingerprint:String;
        public var message:String;
        public var name:String;

        public function ChatReportAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:String, param4:uint, param5:String, param6:String, param7:Number) : ChatReportAction
        {
            var _loc_8:* = new ChatReportAction;
            new ChatReportAction.reportedId = param1;
            _loc_8.reason = param2;
            _loc_8.channel = param4;
            _loc_8.timestamp = param7;
            _loc_8.fingerprint = param5;
            _loc_8.message = param6;
            _loc_8.name = param3;
            return _loc_8;
        }// end function

    }
}
