package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class SaveMessageAction extends Object implements Action
    {
        public var content:String;
        public var channel:uint;
        public var timestamp:Number;

        public function SaveMessageAction()
        {
            return;
        }// end function

        public static function create(param1:String, param2:uint, param3:Number) : SaveMessageAction
        {
            var _loc_4:* = new SaveMessageAction;
            new SaveMessageAction.content = param1;
            _loc_4.channel = param2;
            _loc_4.timestamp = param3;
            return _loc_4;
        }// end function

    }
}
