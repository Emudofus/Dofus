package com.ankamagames.jerakine.logger
{
   import flash.events.Event;
   
   public class LogEvent extends Event
   {
      
      public function LogEvent(param1:String = null, param2:String = null, param3:uint = 0, param4:Date = null)
      {
         super(LOG_EVENT,false,false);
         this.category = param1;
         this.message = param2;
         this.level = param3;
         this.timestamp = param4?param4:new Date();
      }
      
      public static const LOG_EVENT:String = "logEvent";
      
      public var message:String;
      
      public var level:uint;
      
      public var category:String;
      
      public var timestamp:Date;
      
      public function get formattedTimestamp() : String
      {
         var _loc1_:String = this.timestamp.toTimeString().split(" ")[0];
         var _loc2_:String = this.timestamp.milliseconds.toString();
         while(_loc2_.length < 3)
         {
            _loc2_ = "0" + _loc2_;
         }
         _loc1_ = _loc1_ + (":" + _loc2_);
         return _loc1_;
      }
      
      override public function clone() : Event
      {
         return new LogEvent(this.category,this.message,this.level,this.timestamp);
      }
   }
}
