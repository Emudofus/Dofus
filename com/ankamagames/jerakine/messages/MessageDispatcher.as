package com.ankamagames.jerakine.messages
{
    public class MessageDispatcher implements IMessageDispatcher 
    {


        public function dispatchMessage(handler:MessageHandler, message:Message):void
        {
            handler.process(message);
        }


    }
}//package com.ankamagames.jerakine.messages

