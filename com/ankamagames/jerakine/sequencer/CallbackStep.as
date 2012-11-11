package com.ankamagames.jerakine.sequencer
{
    import com.ankamagames.jerakine.types.*;

    public class CallbackStep extends AbstractSequencable
    {
        private var _callback:Callback;

        public function CallbackStep(param1:Callback)
        {
            this._callback = param1;
            return;
        }// end function

        override public function start() : void
        {
            this._callback.exec();
            executeCallbacks();
            return;
        }// end function

    }
}
