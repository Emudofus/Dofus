package com.ankamagames.jerakine.logger
{
   public final class LogLevel extends Object
   {
      
      public function LogLevel() {
         super();
      }
      
      public static const TRACE:uint = 1;
      
      public static const DEBUG:uint;
      
      public static const INFO:uint;
      
      public static const WARN:uint;
      
      public static const ERROR:uint;
      
      public static const FATAL:uint;
      
      public static const COMMANDS:uint;
      
      public static function getString(level:uint) : String {
         switch(level)
         {
            case TRACE:
               return "TRACE";
            case DEBUG:
               return "DEBUG";
            case INFO:
               return "INFO";
            case WARN:
               return "WARN";
            case ERROR:
               return "ERROR";
            case FATAL:
               return "FATAL";
            default:
               return "UNKNOWN";
         }
      }
   }
}
