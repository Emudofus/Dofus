package com.ankamagames.jerakine.logger.targets
{
   import flash.net.XMLSocket;
   import flash.filesystem.FileStream;
   import com.ankamagames.jerakine.logger.LogLevel;
   import flash.events.Event;
   import com.ankamagames.jerakine.logger.LogEvent;
   import com.ankamagames.jerakine.logger.TextLogEvent;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   
   public class FileTarget extends AbstractTarget implements ConfigurableLoggingTarget
   {
      
      public function FileTarget() {
         super();
         var date:Date = new Date();
         this._name = CustomSharedObject.getCustomSharedObjectDirectory() + "/logs/log_" + date.fullYear + "-" + date.month + "-" + date.day + "_" + date.hours + "h" + date.minutes + "m" + date.seconds + "s" + date.milliseconds + ".log";
         var file:File = new File(this._name);
         _fileStream.openAsync(file,FileMode.WRITE);
      }
      
      private static var _socket:XMLSocket;
      
      private static var _history:Array;
      
      private static var _connecting:Boolean = false;
      
      private static var _fileStream:FileStream;
      
      private static function send(level:int, message:String) : void {
         _fileStream.writeUTFBytes("[" + level + "] " + message);
      }
      
      private static function getKeyName(level:int) : String {
         switch(level)
         {
            case LogLevel.TRACE:
               return "trace";
            case LogLevel.DEBUG:
               return "debug";
            case LogLevel.INFO:
               return "info";
            case LogLevel.WARN:
               return "warning";
            case LogLevel.ERROR:
               return "error";
            case LogLevel.FATAL:
               return "fatal";
            default:
               return "severe";
         }
      }
      
      private static function onSocket(e:Event) : void {
         var o:LoggerHistoryElement = null;
         _connecting = false;
         for each(o in _history)
         {
            send(o.level,o.message);
         }
         _history = new Array();
      }
      
      private static function onSocketError(e:Event) : void {
         _connecting = false;
      }
      
      private var _name:String;
      
      override public function logEvent(event:LogEvent) : void {
         if(event is TextLogEvent)
         {
            send(event.level,event.message + "\n");
         }
      }
      
      public function configure(config:XML) : void {
      }
      
      public function get name() : String {
         return this._name;
      }
   }
}
