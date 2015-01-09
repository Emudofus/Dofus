package com.ankamagames.jerakine.network.messages
{
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.messages.ILogableMessage;

    public class ExpectedSocketClosureMessage implements Message, ILogableMessage 
    {

        public var reason:uint;

        public function ExpectedSocketClosureMessage(reason:uint=0)
        {
            this.reason = reason;
        }

    }
}//package com.ankamagames.jerakine.network.messages

