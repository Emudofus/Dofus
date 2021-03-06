﻿package com.ankamagames.dofus.logic.connection.messages
{
    import com.ankamagames.dofus.network.messages.server.basic.SystemMessageDisplayMessage;
    import com.ankamagames.jerakine.messages.Message;
    import __AS3__.vec.Vector;

    public class DelayedSystemMessageDisplayMessage extends SystemMessageDisplayMessage implements Message 
    {


        public function initDelayedSystemMessageDisplayMessage(hangUp:Boolean=false, msgId:uint=0, parameters:Vector.<String>=null):DelayedSystemMessageDisplayMessage
        {
            this.hangUp = hangUp;
            this.msgId = msgId;
            this.parameters = parameters;
            return (this);
        }


    }
}//package com.ankamagames.dofus.logic.connection.messages

