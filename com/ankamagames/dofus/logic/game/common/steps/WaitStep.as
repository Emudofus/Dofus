package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   
   public class WaitStep extends AbstractSequencable
   {
      
      public function WaitStep(param1:int) {
         super();
         this._ms = param1;
         timeout = this._ms + 1000;
      }
      
      private var _ms:int;
      
      private var _timer:Timer;
      
      override public function start() : void {
         this._timer = new Timer(this._ms);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this._timer.start();
      }
      
      override public function pause() : void {
         this._timer.stop();
      }
      
      override public function resume() : void {
         this._timer.start();
      }
      
      override public function clear() : void {
         if(this._timer)
         {
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         }
      }
      
      private function onTimer(param1:TimerEvent) : void {
         param1.currentTarget.removeEventListener(TimerEvent.TIMER,this.onTimer);
         executeCallbacks();
      }
      
      override public function toString() : String {
         return "Wait " + this._ms + " ms";
      }
   }
}
