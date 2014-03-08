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
      
      override public function logEvent(param1:LogEvent) : void {
         if(param1 is TextLogEvent && (logLevels[param1.level]))
         {
            LogFrame.log(LogTypeEnum.TEXT,param1);
         }
      }
      
      public function configure(param1:XML) : void {
         var _loc2_:XML = null;
         for each (_loc2_ in param1..level)
         {
            if(LogLevel[_loc2_.@name.toString().toUpperCase()])
            {
               logLevels[LogLevel[_loc2_.@name.toString().toUpperCase()]] = _loc2_.@log.toString() == "true";
            }
         }
      }
   }
}
