package com.ankamagames.jerakine.network.messages
{
    import com.ankamagames.jerakine.messages.*;

    public class WrongSocketClosureReasonMessage extends Object implements Message
    {
        private var _expectedReason:uint;
        private var _gotReason:uint;

        public function WrongSocketClosureReasonMessage(param1:uint, param2:uint)
        {
            this._expectedReason = param1;
            this._gotReason = param2;
            return;
        }// end function

        public function get expectedReason() : uint
        {
            return this._expectedReason;
        }// end function

        public function get gotReason() : uint
        {
            return this._gotReason;
        }// end function

    }
}
