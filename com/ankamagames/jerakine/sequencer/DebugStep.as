package com.ankamagames.jerakine.sequencer
{
    public class DebugStep extends AbstractSequencable implements ISequencableListener 
    {

        private var _message:String;
        private var _subStep:ISequencable;

        public function DebugStep(message:String, subStep:ISequencable=null)
        {
            this._message = message;
            this._subStep = subStep;
        }

        override public function start():void
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
            };
        }

        public function stepFinished(step:ISequencable, withTimout:Boolean=false):void
        {
            if (this._subStep)
            {
                this._subStep.removeListener(this);
            };
            executeCallbacks();
        }


    }
}//package com.ankamagames.jerakine.sequencer

