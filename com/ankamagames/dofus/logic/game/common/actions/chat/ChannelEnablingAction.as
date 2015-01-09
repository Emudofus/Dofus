package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ChannelEnablingAction implements Action 
    {

        public var channel:uint;
        public var enable:Boolean;


        public static function create(channel:uint, enable:Boolean=true):ChannelEnablingAction
        {
            var a:ChannelEnablingAction = new (ChannelEnablingAction)();
            a.channel = channel;
            a.enable = enable;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.chat

