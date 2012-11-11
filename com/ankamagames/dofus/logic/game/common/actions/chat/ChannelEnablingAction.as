package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ChannelEnablingAction extends Object implements Action
    {
        public var channel:uint;
        public var enable:Boolean;

        public function ChannelEnablingAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:Boolean = true) : ChannelEnablingAction
        {
            var _loc_3:* = new ChannelEnablingAction;
            _loc_3.channel = param1;
            _loc_3.enable = param2;
            return _loc_3;
        }// end function

    }
}
