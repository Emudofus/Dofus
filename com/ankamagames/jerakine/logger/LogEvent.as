package com.ankamagames.jerakine.logger
{
   import flash.events.Event;
   
   public class LogEvent extends Event
   {
      
      public function LogEvent(param1:String=null, param2:String=null, param3:uint=0) {
         super(LOG_EVENT,false,false);
         this.category = param1;
         this.message = param2;
         this.level = param3;
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
