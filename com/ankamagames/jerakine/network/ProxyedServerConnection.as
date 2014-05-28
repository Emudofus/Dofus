package com.ankamagames.jerakine.network
{
   import flash.utils.IDataInput;
   
   public class ProxyedServerConnection extends ServerConnection
   {
      
      public function ProxyedServerConnection(proxy:IConnectionProxy, host:String = null, port:int = 0) {
         super(host,port);
         this._proxy = proxy;
      }
      
      private var _proxy:IConnectionProxy;
      
      public function get proxy() : IConnectionProxy {
         return this._proxy;
      }
      
      public function set proxy(value:IConnectionProxy) : void {
         this._proxy = value;
      }
      
      override protected function lowSend(msg:INetworkMessage, autoFlush:Boolean = true) : void {
         this._proxy.processAndSend(msg,this);
         if(autoFlush)
         {
            flush();
         }
      }
      
      override protected function lowReceive(src:IDataInput) : INetworkMessage {
         return this._proxy.processAndReceive(src);
      }
   }
}
