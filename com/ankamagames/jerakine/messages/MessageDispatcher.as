package com.ankamagames.jerakine.messages
{
    import com.ankamagames.jerakine.messages.*;

    public class MessageDispatcher extends Object implements IMessageDispatcher
    {

        public function MessageDispatcher()
        {
            return;
        }// end function

        public function dispatchMessage(param1:MessageHandler, param2:Message) : void
        {
            param1.process(param2);
            return;
        }// end function

    }
}
