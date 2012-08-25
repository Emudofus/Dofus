package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.logger.targets.*;
    import com.ankamagames.jerakine.replay.*;
    import flash.filesystem.*;

    public class DebugTarget extends AbstractTarget implements ConfigurableLoggingTarget
    {
        public static const LOG_FOLDER:File = File.applicationStorageDirectory.resolvePath("logs");
        public static var logLevels:Array = [];

        public function DebugTarget() : void
        {
            logLevels[LogLevel.COMMANDS] = false;
            logLevels[LogLevel.DEBUG] = true;
            logLevels[LogLevel.ERROR] = true;
            logLevels[LogLevel.FATAL] = true;
            logLevels[LogLevel.INFO] = true;
            logLevels[LogLevel.TRACE] = true;
            logLevels[LogLevel.WARN] = true;
            return;
        }// end function

        override public function logEvent(event:LogEvent) : void
        {
            if (event is TextLogEvent && logLevels[event.level])
            {
                LogFrame.log(LogTypeEnum.TEXT, event);
            }
            return;
        }// end function

        public function configure(param1:XML) : void
        {
            var _loc_2:XML = null;
            for each (_loc_2 in param1..level)
            {
                
                if (LogLevel[_loc_2.@name.toString().toUpperCase()])
                {
                    logLevels[LogLevel[_loc_2.@name.toString().toUpperCase()]] = _loc_2.@log.toString() == "true";
                }
            }
            return;
        }// end function

    }
}
