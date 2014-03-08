package com.ankamagames.jerakine.logger.targets
{
   import flash.net.XMLSocket;
   import com.ankamagames.jerakine.logger.LogLevel;
   import flash.events.Event;
   import com.ankamagames.jerakine.logger.LogEvent;
   import com.ankamagames.jerakine.logger.TextLogEvent;
   
   public class SOSTarget extends AbstractTarget implements ConfigurableLoggingTarget
   {
      
      public function SOSTarget() {
         super();
      }
      
      private static var _socket:XMLSocket = new XMLSocket();
      
      private static var _history:Array = new Array();
      
      private static var _connecting:Boolean = false;
      
      public static var enabled:Boolean = true;
      
      public static var serverHost:String = "localhost";
      
      public static var serverPort:int = 4444;
      
      private static function send(param1:int, param2:String) : void {
         var _loc3_:LoggerHistoryElement = null;
         if(_socket.connected)
         {
            if(param1 != LogLevel.COMMANDS)
            {
               _socket.send("!SOS<showMessage key=\"" + getKeyName(param1) + "\"><![CDATA[" + param2 + "]]></showMessage>");
            }
            else
            {
               _socket.send("!SOS<" + param2 + "/>");
            }
         }
         else
         {
            if(!_socket.hasEventListener("connect"))
            {
               _socket.addEventListener("connect",onSocket);
               _socket.addEventListener("ioError",onSocketError);
               _socket.addEventListener("securityError",onSocketError);
            }
            if(!_connecting)
            {
               _socket.connect(serverHost,serverPort);
               _connecting = true;
            }
            _loc3_ = new LoggerHistoryElement(param1,param2);
            _history.push(_loc3_);
         }
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
      
      public function get socket() : XMLSocket {
         return _socket;
      }
      
      public function get connected() : Boolean {
         return _connecting;
      }
      
      override public function logEvent(param1:LogEvent) : void {
         var _loc2_:String = null;
         if((enabled) && param1 is TextLogEvent)
         {
            _loc2_ = param1.message;
            if(param1.level == LogLevel.COMMANDS)
            {
               switch(_loc2_)
               {
                  case "clear":
                     _loc2_ = "<clear/>";
                     break;
               }
            }
            send(param1.level,param1.message);
         }
      }
      
      public function configure(param1:XML) : void {
         if(param1..server.@host != undefined)
         {
            serverHost = String(param1..server.@host);
         }
         if(param1..server.@port != undefined)
         {
            serverPort = int(param1..server.@port);
         }
      }
   }
}
