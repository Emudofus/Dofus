package com.ankamagames.jerakine.sequencer
{
    import com.ankamagames.jerakine.types.Callback;

    public class CallbackStep extends AbstractSequencable 
    {

        private var _callback:Callback;

        public function CallbackStep(callback:Callback)
        {
            this._callback = callback;
        }

        override public function start():void
        {
            this._callback.exec();
            executeCallbacks();
        }


    }
}//package com.ankamagames.jerakine.sequencer

