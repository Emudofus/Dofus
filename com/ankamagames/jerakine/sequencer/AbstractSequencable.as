package com.ankamagames.jerakine.sequencer
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import com.ankamagames.jerakine.utils.misc.FightProfiler;
   
   public class AbstractSequencable extends EventDispatcher implements IPausableSequencable
   {
      
      public function AbstractSequencable() {
         this._listeners = new Dictionary();
         super();
      }
      
      public static const DEFAULT_TIMEOUT:uint = 5000;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractSequencable));
      
      private var _listeners:Dictionary;
      
      private var _timeOut:Timer;
      
      private var _castingSpellId:int = -1;
      
      protected var _timeoutMax:int = 5000;
      
      private var _withTimeOut:Boolean = false;
      
      private var _paused:Boolean;
      
      public function get paused() : Boolean {
         return this._paused;
      }
      
      public function get timeout() : int {
         return this._timeoutMax;
      }
      
      public function set timeout(param1:int) : void {
         this._timeoutMax = param1;
         if((this._timeOut) && !(param1 == -1))
         {
            this._timeOut.delay = param1;
         }
      }
      
      public function get hasDefaultTimeout() : Boolean {
         return this._timeoutMax == DEFAULT_TIMEOUT;
      }
      
      public function pause() : void {
         if(this._timeOut)
         {
            this._timeOut.stop();
         }
         this._paused = true;
      }
      
      public function resume() : void {
         this._paused = false;
         if(this._timeOut)
         {
            this._timeOut.start();
         }
      }
      
      public function start() : void {
      }
      
      public function addListener(param1:ISequencableListener) : void {
         if(!this._timeOut && !(this._timeoutMax == -1))
         {
            this._timeOut = new Timer(this._timeoutMax,1);
            this._timeOut.addEventListener(TimerEvent.TIMER,this.onTimeOut);
            this._timeOut.start();
         }
         if(!this._listeners)
         {
            this._listeners = new Dictionary();
         }
         this._listeners[param1] = param1;
      }
      
      protected function executeCallbacks() : void {
         var _loc1_:ISequencableListener = null;
         FightProfiler.getInstance().stop();
         if(this._timeOut)
         {
            this._timeOut.removeEventListener(TimerEvent.TIMER,this.onTimeOut);
            this._timeOut.reset();
            this._timeOut = null;
         }
         for each (_loc1_ in this._listeners)
         {
            if(_loc1_)
            {
               _loc1_.stepFinished(this,this._withTimeOut);
            }
         }
      }
      
      public function removeListener(param1:ISequencableListener) : void {
         if(!this._listeners)
         {
            return;
         }
         delete this._listeners[[param1]];
      }
      
      override public function toString() : String {
         return getQualifiedClassName(this);
      }
      
      public function clear() : void {
         if(this._timeOut)
         {
            this._timeOut.stop();
         }
         this._timeOut = null;
         this._listeners = null;
      }
      
      public function get castingSpellId() : int {
         return this._castingSpellId;
      }
      
      public function set castingSpellId(param1:int) : void {
         this._castingSpellId = param1;
      }
      
      public function get isTimeout() : Boolean {
         return this._withTimeOut;
      }
      
      protected function onTimeOut(param1:TimerEvent) : void {
         _log.error("Time out sur la step " + this + " (" + this._timeOut.delay + ")");
         this._withTimeOut = true;
         if(this._timeOut)
         {
            this._timeOut.stop();
         }
         this._timeOut = null;
         this.executeCallbacks();
         this._listeners = null;
      }
   }
}
