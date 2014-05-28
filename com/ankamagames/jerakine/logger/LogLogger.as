package com.ankamagames.jerakine.logger
{
   public class LogLogger extends Object implements Logger
   {
      
      public function LogLogger(category:String) {
         super();
         this._category = category;
      }
      
      private static var _enabled:Boolean = true;
      
      private static var _useModuleLoggerHasOutputLog:Boolean = false;
      
      public static function useModuleLoggerHasOutputLog(value:Boolean) : void {
         _useModuleLoggerHasOutputLog = value;
      }
      
      public static function activeLog(active:Boolean) : void {
         _enabled = active;
      }
      
      public static function logIsActive() : Boolean {
         return _enabled;
      }
      
      private var _category:String;
      
      public function get category() : String {
         return this._category;
      }
      
      public function trace(message:Object) : void {
         this.log(LogLevel.TRACE,message);
      }
      
      public function debug(message:Object) : void {
         this.log(LogLevel.DEBUG,message);
      }
      
      public function info(message:Object) : void {
         this.log(LogLevel.INFO,message);
      }
      
      public function warn(message:Object) : void {
         this.log(LogLevel.WARN,message);
      }
      
      public function error(message:Object) : void {
         this.log(LogLevel.ERROR,message);
      }
      
      public function fatal(message:Object) : void {
         this.log(LogLevel.FATAL,message);
      }
      
      public function logDirectly(logEvent:LogEvent) : void {
         if(_enabled)
         {
            Log.broadcastToTargets(logEvent);
         }
      }
      
      public function log(level:uint, object:Object) : void {
         var message:String = null;
         var formatedMessage:String = null;
         if(_enabled)
         {
            message = object.toString();
            formatedMessage = this.getFormatedMessage(message);
            Log.broadcastToTargets(new TextLogEvent(this._category,!(level == LogLevel.COMMANDS)?formatedMessage:message,level));
            if(_useModuleLoggerHasOutputLog)
            {
               ModuleLogger.log(formatedMessage,level);
            }
         }
      }
      
      private function getFormatedMessage(message:String) : String {
         if(!message)
         {
            message = "";
         }
         var catSplit:Array = this._category.split("::");
         var head:String = "[" + catSplit[catSplit.length - 1] + "] ";
         var indent:String = "";
         var i:uint = 0;
         while(i < head.length)
         {
            indent = indent + " ";
            i++;
         }
         var message:String = message.replace("\n","\n" + indent);
         return head + message;
      }
      
      public function clear() : void {
         this.log(LogLevel.COMMANDS,"clear");
      }
   }
}
