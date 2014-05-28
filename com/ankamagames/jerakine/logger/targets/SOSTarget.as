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
      
      private static var _socket:XMLSocket;
      
      private static var _history:Array;
      
      private static var _connecting:Boolean = false;
      
      public static var enabled:Boolean = true;
      
      public static var serverHost:String = "localhost";
      
      public static var serverPort:int = 4444;
      
      private static function send(level:int, message:String) : void {
         var he:LoggerHistoryElement = null;
         if(_socket.connected)
         {
            if(level != LogLevel.COMMANDS)
            {
               _socket.send("!SOS<showMessage key=\"" + getKeyName(level) + "\"><![CDATA[" + message + "]]></showMessage>");
            }
            else
            {
               _socket.send("!SOS<" + message + "/>");
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
            he = new LoggerHistoryElement(level,message);
            _history.push(he);
         }
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
      
      public function get socket() : XMLSocket {
         return _socket;
      }
      
      public function get connected() : Boolean {
         return _connecting;
      }
      
      override public function logEvent(event:LogEvent) : void {
         var msg:String = null;
         if((enabled) && (event is TextLogEvent))
         {
            msg = event.message;
            if(event.level == LogLevel.COMMANDS)
            {
               switch(msg)
               {
                  case "clear":
                     msg = "<clear/>";
                     break;
               }
            }
            send(event.level,event.message);
         }
      }
      
      public function configure(config:XML) : void {
         if(config..server.@host != undefined)
         {
            serverHost = String(config..server.@host);
         }
         if(config..server.@port != undefined)
         {
            serverPort = int(config..server.@port);
         }
      }
   }
}
