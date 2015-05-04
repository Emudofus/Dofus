package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class SynchroTimer extends Object
   {
      
      public function SynchroTimer(param1:Number)
      {
         super();
         this._maxValue = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SynchroTimer));
      
      private var _value:Number;
      
      private var _maxValue:Number;
      
      private var _time:Number;
      
      private var _callBack:Function;
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function start(param1:Function) : void
      {
         this._callBack = param1;
         this._value = TimeManager.getInstance().getTimestamp() % this._maxValue;
         this._time = this.getTimerValue();
         StageShareManager.stage.addEventListener(Event.ENTER_FRAME,this.tick);
      }
      
      public function stop() : void
      {
         StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,this.tick);
         this._callBack = null;
         this._value = this._maxValue = 0;
      }
      
      private function getTimerValue() : int
      {
         return getTimer() % int.MAX_VALUE;
      }
      
      private function tick(param1:Event) : void
      {
         var _loc2_:int = this.getTimerValue();
         this._value = this._value + (_loc2_ - this._time);
         if(this._value > this._maxValue)
         {
            this._value = 0;
         }
         this._time = _loc2_;
         if(this._callBack != null)
         {
            this._callBack.apply(this,[this]);
         }
      }
   }
}
