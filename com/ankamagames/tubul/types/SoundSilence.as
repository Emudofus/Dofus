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
      
      public function SoundSilence(param1:Number, param2:Number) {
         super();
         this.setSilence(param1,param2);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SoundSilence));
      
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
         var _loc1_:uint = (Math.random() * (this._silenceMax - this._silenceMin) + this._silenceMin) * 1000 * 60;
         this._timer = new Timer(_loc1_,1);
         if(!this._timer.hasEventListener(TimerEvent.TIMER))
         {
            this._timer.addEventListener(TimerEvent.TIMER,this.onTimerEnd);
         }
         this._timer.start();
         var _loc2_:SoundSilenceEvent = new SoundSilenceEvent(SoundSilenceEvent.START);
         dispatchEvent(_loc2_);
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
      
      public function setSilence(param1:Number, param2:Number) : void {
         this._silenceMin = Math.min(param1,param2);
         this._silenceMax = Math.max(param1,param2);
      }
      
      private function onTimerEnd(param1:TimerEvent) : void {
         this.clean();
         var _loc2_:SoundSilenceEvent = new SoundSilenceEvent(SoundSilenceEvent.COMPLETE);
         dispatchEvent(_loc2_);
      }
   }
}
