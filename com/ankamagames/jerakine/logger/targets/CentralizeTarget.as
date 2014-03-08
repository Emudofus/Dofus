package com.ankamagames.jerakine.logger.targets
{
   import flash.net.Socket;
   import com.ankamagames.jerakine.logger.LogEvent;
   import com.ankamagames.jerakine.logger.LogLevel;
   import flash.events.Event;
   
   public class CentralizeTarget extends AbstractTarget
   {
      
      public function CentralizeTarget() {
         super();
      }
      
      private static var _socket:Socket = new Socket();
      
      private static var _history:Array = new Array();
      
      private static var _connecting:Boolean = false;
      
      public static var serverHost:String = "chacha.ankama.lan";
      
      public static var serverPort:int = 6666;
      
      override public function logEvent(param1:LogEvent) : void {
         this.send(param1.level,param1.message);
      }
      
      private function send(param1:uint, param2:String) : void {
         var _loc3_:LoggerHistoryElement = null;
         if(_socket.connected)
         {
            _socket.writeUTF("(" + LogLevel.getString(param1) + ") " + param2);
         }
         else
         {
            if(!_socket.hasEventListener("connect"))
            {
               _socket.addEventListener("connect",this.onSocket);
               _socket.addEventListener("ioError",this.onSocketError);
               _socket.addEventListener("securityError",this.onSocketError);
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
      
      private function onSocket(param1:Event) : void {
         var _loc2_:LoggerHistoryElement = null;
         _connecting = false;
         for each (_loc2_ in _history)
         {
            this.send(_loc2_.level,_loc2_.message);
         }
         _history = new Array();
      }
      
      private function onSocketError(param1:Event) : void {
         _connecting = false;
      }
   }
}
