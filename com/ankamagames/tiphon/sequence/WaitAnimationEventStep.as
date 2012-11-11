package com.ankamagames.tiphon.sequence
{
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.tiphon.events.*;

    public class WaitAnimationEventStep extends AbstractSequencable
    {
        private var _targetStep:PlayAnimationStep;
        private var _initOk:Boolean;
        private var _waitedEvent:String;
        private var _released:Boolean;
        private var _waiting:Boolean;

        public function WaitAnimationEventStep(param1:PlayAnimationStep, param2:String = "animation_event_end")
        {
            param1.target.addEventListener(TiphonEvent.ANIMATION_EVENT, this.onEvent);
            this._waitedEvent = param2;
            this._targetStep = param1;
            this._initOk = true;
            return;
        }// end function

        override public function start() : void
        {
            if (!this._targetStep || !this._targetStep.target)
            {
                executeCallbacks();
                return;
            }
            if (!this._initOk || this._released || this._targetStep.animation != this._targetStep.target.getAnimation())
            {
                this._targetStep.target.removeEventListener(TiphonEvent.ANIMATION_EVENT, this.onEvent);
                this._targetStep = null;
                executeCallbacks();
            }
            else
            {
                this._waiting = true;
            }
            return;
        }// end function

        private function onEvent(event:TiphonEvent) : void
        {
            if (event && event.type == this._waitedEvent || this._targetStep.animation != this._targetStep.target.getAnimation())
            {
                this._released = true;
                if (this._targetStep)
                {
                    this._targetStep.target.removeEventListener(TiphonEvent.ANIMATION_EVENT, this.onEvent);
                }
                this._targetStep = null;
                if (this._waiting)
                {
                    executeCallbacks();
                }
            }
            return;
        }// end function

        override public function toString() : String
        {
            return "Waiting event [" + this._waitedEvent + "] for " + this._targetStep;
        }// end function

    }
}
