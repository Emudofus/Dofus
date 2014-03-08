package com.ankamagames.jerakine.network
{
   import flash.events.Event;
   
   public class SnifferServerConnection extends ServerConnection implements IServerConnection
   {
      
      public function SnifferServerConnection(host:String=null, port:int=0) {
         super(null,0);
         if((!(host == null)) && (!(port == 0)))
         {
            this.connect(host,port);
         }
      }
      
      private static var _snifferHost:String;
      
      private static var _snifferPort:int;
      
      public static function get snifferHost() : String {
         return _snifferHost;
      }
      
      public static function set snifferHost(host:String) : void {
         _snifferHost = host;
      }
      
      public static function get snifferPort() : int {
         return _snifferPort;
      }
      
      public static function set snifferPort(port:int) : void {
         _snifferPort = port;
      }
      
      private var _targetHost:String;
      
      private var _targetPort:int;
      
      override public function connect(host:String, port:int) : void {
         if((_snifferHost == null) || (_snifferPort == 0))
         {
            throw new NetworkError("Can\'t connect using an analyzer-proxy without host and port for this proxy.");
         }
         else
         {
            this._targetHost = host;
            this._targetPort = port;
            super.connect(_snifferHost,_snifferPort);
            return;
         }
      }
      
      override protected function onConnect(e:Event) : void {
         writeUTF(this._targetHost);
         writeUnsignedInt(this._targetPort);
         super.onConnect(e);
      }
   }
}
