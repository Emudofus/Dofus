package com.ankamagames.jerakine.messages
{
    import com.ankamagames.jerakine.messages.*;

    public interface IdentifiedMessage extends Message
    {

        public function IdentifiedMessage();

        function getMessageId() : uint;

    }
}
