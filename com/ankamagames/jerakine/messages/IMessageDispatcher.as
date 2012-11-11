package com.ankamagames.jerakine.messages
{

    public interface IMessageDispatcher
    {

        public function IMessageDispatcher();

        function dispatchMessage(param1:MessageHandler, param2:Message) : void;

    }
}
