package com.ankamagames.jerakine.network
{
    import flash.utils.*;

    public class ProxyedServerConnection extends ServerConnection
    {
        private var _proxy:IConnectionProxy;

        public function ProxyedServerConnection(param1:IConnectionProxy, param2:String = null, param3:int = 0)
        {
            super(param2, param3);
            this._proxy = param1;
            return;
        }// end function

        public function get proxy() : IConnectionProxy
        {
            return this._proxy;
        }// end function

        public function set proxy(param1:IConnectionProxy) : void
        {
            this._proxy = param1;
            return;
        }// end function

        override protected function lowSend(param1:INetworkMessage, param2:Boolean = true) : void
        {
            this._proxy.processAndSend(param1, this);
            if (param2)
            {
                flush();
            }
            return;
        }// end function

        override protected function lowReceive(param1:IDataInput) : INetworkMessage
        {
            return this._proxy.processAndReceive(param1);
        }// end function

    }
}
