package com.ankamagames.jerakine.logger.targets
{
    import com.ankamagames.jerakine.logger.*;

    public class TemporaryBufferTarget extends AbstractTarget
    {
        private var _buffer:Array;

        public function TemporaryBufferTarget()
        {
            this._buffer = new Array();
            return;
        }// end function

        override public function logEvent(event:LogEvent) : void
        {
            this._buffer.push(event);
            return;
        }// end function

        public function getBuffer() : Array
        {
            return this._buffer;
        }// end function

        public function clearBuffer() : void
        {
            this._buffer = new Array();
            return;
        }// end function

    }
}
