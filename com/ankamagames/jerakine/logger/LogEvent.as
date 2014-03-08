package com.ankamagames.jerakine.logger
{
   import flash.events.Event;
   
   public class LogEvent extends Event
   {
      
      public function LogEvent(category:String=null, message:String=null, logLevel:uint=0) {
         super(LOG_EVENT,false,false);
         this.category = category;
         this.message = message;
         this.level = logLevel;
      }
      
      public static const LOG_EVENT:String = "logEvent";
      
      public var message:String;
      
      public var level:uint;
      
      public var category:String;
      
      override public function clone() : Event {
         return new LogEvent(this.category,this.message,this.level);
      }
   }
}
