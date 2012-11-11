package com.ankamagames.dofus.logic.connection.messages
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.messages.server.basic.*;
    import com.ankamagames.jerakine.messages.*;

    public class DelayedSystemMessageDisplayMessage extends SystemMessageDisplayMessage implements Message
    {

        public function DelayedSystemMessageDisplayMessage()
        {
            return;
        }// end function

        public function initDelayedSystemMessageDisplayMessage(param1:Boolean = false, param2:uint = 0, param3:Vector.<String> = null) : DelayedSystemMessageDisplayMessage
        {
            this.hangUp = param1;
            this.msgId = param2;
            this.parameters = param3;
            return this;
        }// end function

    }
}
