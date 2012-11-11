package com.ankamagames.jerakine.sequencer
{
    import com.ankamagames.jerakine.sequencer.*;

    public class DebugStep extends AbstractSequencable implements ISequencableListener
    {
        private var _message:String;
        private var _subStep:ISequencable;

        public function DebugStep(param1:String, param2:ISequencable = null)
        {
            this._message = param1;
            this._subStep = param2;
            return;
        }// end function

        override public function start() : void
        {
            _log.debug(this._message);
            if (this._subStep)
            {
                this._subStep.addListener(this);
                this._subStep.start();
            }
            else
            {
                executeCallbacks();
            }
            return;
        }// end function

        public function stepFinished() : void
        {
            if (this._subStep)
            {
                this._subStep.removeListener(this);
            }
            executeCallbacks();
            return;
        }// end function

    }
}
