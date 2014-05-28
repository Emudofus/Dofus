package com.ankamagames.berilia.types.graphic
{
   import flash.html.HTMLLoader;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import flash.events.Event;
   
   public class TimeoutHTMLLoader extends HTMLLoader
   {
      
      public function TimeoutHTMLLoader() {
         super();
         addEventListener(Event["LOCATION_CHANGE"],this.onLocationChange);
      }
      
      private static var INSTANCE_CACHE:Dictionary;
      
      public static const TIMEOUT:String = "TimeoutHTMLLoader_timeout";
      
      public static function getLoader(uid:String = null) : TimeoutHTMLLoader {
         var instance:TimeoutHTMLLoader = null;
         if((!(uid == null)) && (INSTANCE_CACHE[uid]))
         {
            instance = INSTANCE_CACHE[uid];
            instance._fromCache = true;
            instance._timer.reset();
            instance._timer.start();
            return instance;
         }
         instance = new TimeoutHTMLLoader();
         instance._uid = uid;
         if(uid)
         {
            INSTANCE_CACHE[uid] = instance;
         }
         return instance;
      }
      
      public static function resetCache() : void {
         INSTANCE_CACHE = new Dictionary();
      }
      
      private var _fromCache:Boolean;
      
      private var _timer:Timer;
      
      private var _uid:String;
      
      public function set life(value:Number) : void {
         this._timer = new Timer(value * 60 * 1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimeOut);
      }
      
      public function get fromCache() : Boolean {
         return this._fromCache;
      }
      
      private function onLocationChange(e:Event) : void {
         if(this._timer)
         {
            this._timer.reset();
            this._timer.start();
         }
      }
      
      private function onTimeOut(e:Event) : void {
         this._timer.stop();
         dispatchEvent(new Event(TIMEOUT));
         if((!this._timer.running) && (this._uid))
         {
            delete INSTANCE_CACHE[this._uid];
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimeOut);
         }
      }
   }
}
