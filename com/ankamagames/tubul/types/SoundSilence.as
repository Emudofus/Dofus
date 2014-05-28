package com.ankamagames.tubul.types
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import com.ankamagames.tubul.events.SoundSilenceEvent;
   
   public class SoundSilence extends EventDispatcher
   {
      
      public function SoundSilence(pSilenceMin:Number, pSilenceMax:Number) {
         super();
         this.setSilence(pSilenceMin,pSilenceMax);
      }
      
      protected static const _log:Logger;
      
      private var _silenceMin:Number;
      
      private var _silenceMax:Number;
      
      private var _timer:Timer;
      
      public function get silenceMin() : Number {
         return this._silenceMin;
      }
      
      public function get silenceMax() : Number {
         return this._silenceMax;
      }
      
      public function get running() : Boolean {
         if((this._timer) && (this._timer.running))
         {
            return true;
         }
         return false;
      }
      
      public function start() : void {
         if((this._timer) && (this._timer.running))
         {
            return;
         }
         var silenceRandom:uint = (Math.random() * (this._silenceMax - this._silenceMin) + this._silenceMin) * 1000 * 60;
         this._timer = new Timer(silenceRandom,1);
         if(!this._timer.hasEventListener(TimerEvent.TIMER))
         {
            this._timer.addEventListener(TimerEvent.TIMER,this.onTimerEnd);
         }
         this._timer.start();
         var e:SoundSilenceEvent = new SoundSilenceEvent(SoundSilenceEvent.START);
         dispatchEvent(e);
      }
      
      public function stop() : void {
         if(!this.running)
         {
            return;
         }
         this._timer.stop();
      }
      
      public function clean() : void {
         this.stop();
         if(this._timer == null)
         {
            return;
         }
         this._timer.removeEventListener(TimerEvent.TIMER,this.onTimerEnd);
         this._timer = null;
      }
      
      public function setSilence(pSilenceMin:Number, pSilenceMax:Number) : void {
         this._silenceMin = Math.min(pSilenceMin,pSilenceMax);
         this._silenceMax = Math.max(pSilenceMin,pSilenceMax);
      }
      
      private function onTimerEnd(pEvent:TimerEvent) : void {
         this.clean();
         var e:SoundSilenceEvent = new SoundSilenceEvent(SoundSilenceEvent.COMPLETE);
         dispatchEvent(e);
      }
   }
}
