package com.ankamagames.jerakine.logger.targets
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.LogEvent;
   
   public interface LoggingTarget
   {
      
      function set filters(param1:Array) : void;
      
      function get filters() : Array;
      
      function addLogger(param1:Logger) : void;
      
      function removeLogger(param1:Logger) : void;
      
      function onLog(param1:LogEvent) : void;
   }
}
