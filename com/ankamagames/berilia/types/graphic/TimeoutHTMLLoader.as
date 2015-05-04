package com.ankamagames.berilia.types.graphic
{
   import flash.html.HTMLLoader;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.events.HTMLUncaughtScriptExceptionEvent;
   import com.ankamagames.jerakine.logger.Log;
   import avmplus.getQualifiedClassName;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import flash.events.Event;
   
   public class TimeoutHTMLLoader extends HTMLLoader
   {
      
      public function TimeoutHTMLLoader()
      {
         super();
         addEventListener(Event["LOCATION_CHANGE"],this.onLocationChange);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TimeoutHTMLLoader));
      
      private static var INSTANCE_CACHE:Dictionary = new Dictionary();
      
      public static const TIMEOUT:String = "TimeoutHTMLLoader_timeout";
      
      public static function getLoader(param1:String = null) : TimeoutHTMLLoader
      {
         var _loc2_:TimeoutHTMLLoader = null;
         if(!(param1 == null) && (INSTANCE_CACHE[param1]))
         {
            _loc2_ = INSTANCE_CACHE[param1];
            _loc2_._fromCache = true;
            _loc2_._timer.reset();
            _loc2_._timer.start();
            return _loc2_;
         }
         _loc2_ = new TimeoutHTMLLoader();
         _loc2_._uid = param1;
         _loc2_.addEventListener(HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION,onJsError);
         if(param1)
         {
            INSTANCE_CACHE[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public static function resetCache() : void
      {
         INSTANCE_CACHE = new Dictionary();
      }
      
      private static function onJsError(param1:HTMLUncaughtScriptExceptionEvent) : void
      {
         var _loc2_:* = "Javascript exception \"" + param1.exceptionValue.message + "\"";
         var _loc3_:uint = 0;
         while(_loc3_ < param1.stackTrace.length)
         {
            _loc2_ = _loc2_ + ("\n" + param1.stackTrace[_loc3_].functionName + " at line " + param1.stackTrace[_loc3_].line);
            _loc3_++;
         }
         _log.error(_loc2_);
      }
      
      private var _fromCache:Boolean;
      
      private var _timer:Timer;
      
      private var _uid:String;
      
      public function set life(param1:Number) : void
      {
         this._timer = new Timer(param1 * 60 * 1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimeOut);
      }
      
      public function get fromCache() : Boolean
      {
         return this._fromCache;
      }
      
      private function onLocationChange(param1:Event) : void
      {
         if(this._timer)
         {
            this._timer.reset();
            this._timer.start();
         }
      }
      
      private function onTimeOut(param1:Event) : void
      {
         this._timer.stop();
         dispatchEvent(new Event(TIMEOUT));
         if(!this._timer.running && (this._uid))
         {
            delete INSTANCE_CACHE[this._uid];
            true;
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimeOut);
         }
      }
   }
}
