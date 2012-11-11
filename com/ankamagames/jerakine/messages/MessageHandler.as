package com.ankamagames.jerakine.messages
{

    public interface MessageHandler
    {

        public function MessageHandler();

        function process(param1:Message) : Boolean;

    }
}
