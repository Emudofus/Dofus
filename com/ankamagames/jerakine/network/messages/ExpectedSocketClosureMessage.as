package com.ankamagames.jerakine.network.messages
{
    import com.ankamagames.jerakine.messages.*;

    public class ExpectedSocketClosureMessage extends Object implements Message, ILogableMessage
    {
        public var reason:uint;

        public function ExpectedSocketClosureMessage(param1:uint = 0)
        {
            this.reason = param1;
            return;
        }// end function

    }
}
