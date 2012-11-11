package com.ankamagames.jerakine.messages
{
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.utils.misc.*;

    public interface Frame extends MessageHandler, Prioritizable
    {

        public function Frame();

        function pushed() : Boolean;

        function pulled() : Boolean;

    }
}
