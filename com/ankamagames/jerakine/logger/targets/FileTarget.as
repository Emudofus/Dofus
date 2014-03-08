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
         var _loc1_:Date = new Date();
         this._name = CustomSharedObject.getCustomSharedObjectDirectory() + "/logs/log_" + _loc1_.fullYear + "-" + _loc1_.month + "-" + _loc1_.day + "_" + _loc1_.hours + "h" + _loc1_.minutes + "m" + _loc1_.seconds + "s" + _loc1_.milliseconds + ".log";
         var _loc2_:File = new File(this._name);
         _fileStream.openAsync(_loc2_,FileMode.WRITE);
      }
      
      private static var _socket:XMLSocket = new XMLSocket();
      
      private static var _history:Array = new Array();
      
      private static var _connecting:Boolean = false;
      
      private static var _fileStream:FileStream = new FileStream();
      
      private static function send(param1:int, param2:String) : void {
         _fileStream.writeUTFBytes("[" + param1 + "] " + param2);
      }
      
      private static function getKeyName(param1:int) : String {
         switch(param1)
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
      
      private static function onSocket(param1:Event) : void {
         var _loc2_:LoggerHistoryElement = null;
         _connecting = false;
         for each (_loc2_ in _history)
         {
            send(_loc2_.level,_loc2_.message);
         }
         _history = new Array();
      }
      
      private static function onSocketError(param1:Event) : void {
         _connecting = false;
      }
      
      private var _name:String;
      
      override public function logEvent(param1:LogEvent) : void {
         if(param1 is TextLogEvent)
         {
            send(param1.level,param1.message + "\n");
         }
      }
      
      public function configure(param1:XML) : void {
      }
      
      public function get name() : String {
         return this._name;
      }
   }
}
