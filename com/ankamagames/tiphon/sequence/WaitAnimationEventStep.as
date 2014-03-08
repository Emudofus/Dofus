package com.ankamagames.tiphon.sequence
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.tiphon.events.TiphonEvent;
   
   public class WaitAnimationEventStep extends AbstractSequencable
   {
      
      public function WaitAnimationEventStep(param1:PlayAnimationStep, param2:String="animation_event_end") {
         super();
         param1.target.addEventListener(TiphonEvent.ANIMATION_EVENT,this.onEvent);
         this._waitedEvent = param2;
         this._targetStep = param1;
         this._initOk = true;
      }
      
      private var _targetStep:PlayAnimationStep;
      
      private var _initOk:Boolean;
      
      private var _waitedEvent:String;
      
      private var _released:Boolean;
      
      private var _waiting:Boolean;
      
      override public function start() : void {
         if(!this._targetStep || !this._targetStep.target)
         {
            executeCallbacks();
            return;
         }
         if(!this._initOk || (this._released) || !(this._targetStep.animation == this._targetStep.target.getAnimation()))
         {
            this._targetStep.target.removeEventListener(TiphonEvent.ANIMATION_EVENT,this.onEvent);
            this._targetStep = null;
            executeCallbacks();
         }
         else
         {
            this._waiting = true;
         }
      }
      
      private function onEvent(param1:TiphonEvent) : void {
         if((param1) && (param1.type == this._waitedEvent) || !(this._targetStep.animation == this._targetStep.target.getAnimation()))
         {
            this._released = true;
            if(this._targetStep)
            {
               this._targetStep.target.removeEventListener(TiphonEvent.ANIMATION_EVENT,this.onEvent);
            }
            this._targetStep = null;
            if(this._waiting)
            {
               executeCallbacks();
            }
         }
      }
      
      override public function toString() : String {
         return "Waiting event [" + this._waitedEvent + "] for " + this._targetStep;
      }
   }
}
