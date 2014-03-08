package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.jerakine.logger.targets.AbstractTarget;
   import com.ankamagames.jerakine.logger.targets.ConfigurableLoggingTarget;
   import flash.filesystem.File;
   import com.ankamagames.jerakine.logger.LogEvent;
   import com.ankamagames.jerakine.logger.TextLogEvent;
   import com.ankamagames.jerakine.replay.LogFrame;
   import com.ankamagames.jerakine.replay.LogTypeEnum;
   import com.ankamagames.jerakine.logger.LogLevel;
   
   public class DebugTarget extends AbstractTarget implements ConfigurableLoggingTarget
   {
      
      public function DebugTarget() {
         super();
         logLevels[LogLevel.COMMANDS] = false;
         logLevels[LogLevel.DEBUG] = true;
         logLevels[LogLevel.ERROR] = true;
         logLevels[LogLevel.FATAL] = true;
         logLevels[LogLevel.INFO] = true;
         logLevels[LogLevel.TRACE] = true;
         logLevels[LogLevel.WARN] = true;
      }
      
      public static const LOG_FOLDER:File = File.applicationStorageDirectory.resolvePath("logs");
      
      public static var logLevels:Array = [];
      
      override public function logEvent(event:LogEvent) : void {
         if((event is TextLogEvent) && (logLevels[event.level]))
         {
            LogFrame.log(LogTypeEnum.TEXT,event);
         }
      }
      
      public function configure(config:XML) : void {
         var level:XML = null;
         for each (level in config..level)
         {
            if(LogLevel[level.@name.toString().toUpperCase()])
            {
               logLevels[LogLevel[level.@name.toString().toUpperCase()]] = level.@log.toString() == "true";
            }
         }
      }
   }
}
