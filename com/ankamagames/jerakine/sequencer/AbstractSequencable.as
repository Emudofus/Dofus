package com.ankamagames.jerakine.sequencer
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import com.ankamagames.jerakine.utils.misc.FightProfiler;


   public class AbstractSequencable extends EventDispatcher implements ISequencable
   {
         

      public function AbstractSequencable() {
         this._aListener=new Array();
         super();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractSequencable));

      private var _aListener:Array;

      private var _timeOut:Timer;

      private var _castingSpellId:int = -1;

      public function start() : void {
         
      }

      public function addListener(listener:ISequencableListener) : void {
         if(!this._timeOut)
         {
            this._timeOut=new Timer(5000,1);
            this._timeOut.addEventListener(TimerEvent.TIMER,this.onTimeOut);
            this._timeOut.start();
         }
         this._aListener.push(listener);
      }

      protected function executeCallbacks() : void {
         var listener:ISequencableListener = null;
         FightProfiler.getInstance().stop();
         if(this._timeOut)
         {
            this._timeOut.removeEventListener(TimerEvent.TIMER,this.onTimeOut);
            this._timeOut.reset();
            this._timeOut=null;
         }
         for each (listener in this._aListener)
         {
            if(listener)
            {
               listener.stepFinished();
            }
         }
      }

      public function removeListener(listener:ISequencableListener) : void {
         var i:uint = 0;
         while(i<this._aListener.length)
         {
            if(this._aListener[i]==listener)
            {
               this._aListener=this._aListener.slice(0,i).concat(this._aListener.slice(i+1,this._aListener.length));
            }
            else
            {
               i++;
               continue;
            }
         }
      }

      override public function toString() : String {
         return getQualifiedClassName(this);
      }

      public function clear() : void {
         if(this._timeOut)
         {
            this._timeOut.stop();
         }
         this._timeOut=null;
         this._aListener=null;
      }

      public function get castingSpellId() : int {
         return this._castingSpellId;
      }

      public function set castingSpellId(val:int) : void {
         this._castingSpellId=val;
      }

      protected function onTimeOut(e:TimerEvent) : void {
         this.executeCallbacks();
         _log.error("Time out sur la step "+this);
      }
   }

}