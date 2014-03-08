package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class TimeApi extends Object implements IApi
   {
      
      public function TimeApi() {
         this._log = Log.getLogger(getQualifiedClassName(TimeApi));
         super();
      }
      
      private var _module:UiModule;
      
      protected var _log:Logger;
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getTimestamp() : Number {
         return TimeManager.getInstance().getTimestamp();
      }
      
      public function getUtcTimestamp() : Number {
         return TimeManager.getInstance().getUtcTimestamp();
      }
      
      public function getClock(param1:Number=0, param2:Boolean=false, param3:Boolean=false) : String {
         return TimeManager.getInstance().formatClock(param1,param2,param3);
      }
      
      public function getClockNumbers() : Object {
         var _loc1_:Array = TimeManager.getInstance().getDateFromTime(0);
         return [_loc1_[0],_loc1_[1]];
      }
      
      public function getDate(param1:Number=0, param2:Boolean=false) : String {
         return TimeManager.getInstance().formatDateIRL(param1,param2);
      }
      
      public function getDofusDate(param1:Number=0) : String {
         return TimeManager.getInstance().formatDateIG(param1);
      }
      
      public function getDofusDay(param1:Number=0) : int {
         return TimeManager.getInstance().getDateIG(param1)[0];
      }
      
      public function getDofusMonth(param1:Number=0) : String {
         return TimeManager.getInstance().getDateIG(param1)[1];
      }
      
      public function getDofusYear(param1:Number=0) : String {
         return TimeManager.getInstance().getDateIG(param1)[2];
      }
      
      public function getDurationTimeSinceEpoch(param1:Number=0) : Number {
         var _loc2_:Date = new Date();
         var _loc3_:Number = _loc2_.getTime() / 1000;
         var _loc4_:Number = TimeManager.getInstance().timezoneOffset / 1000;
         var _loc5_:Number = TimeManager.getInstance().serverTimeLag / 1000;
         return Math.floor(_loc3_ - param1 + _loc4_ - _loc5_);
      }
      
      public function getDuration(param1:Number, param2:Boolean=false) : String {
         return TimeManager.getInstance().getDuration(param1,param2);
      }
      
      public function getShortDuration(param1:Number, param2:Boolean=false) : String {
         return TimeManager.getInstance().getDuration(param1,true,param2);
      }
      
      public function getTimezoneOffset() : Number {
         return TimeManager.getInstance().timezoneOffset;
      }
   }
}
