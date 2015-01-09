package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class RpcServiceCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RpcServiceCenter));
        private static var _self:RpcServiceCenter;
        private static var _rpcServices:Vector.<RpcServiceManager>;

        private var _mainRpcServiceManager:RpcServiceManager;


        public static function getInstance():RpcServiceCenter
        {
            if (!(_self))
            {
                _self = new (RpcServiceCenter)();
            };
            return (_self);
        }


        public function makeRpcCall(serviceUrl:String, formatType:String, formatVersion:String, methodName:String, methodParams:*, callback:Function, newService:Boolean=true, retryOnTimedout:Boolean=true):void
        {
            var rpcs:RpcServiceManager;
            if (newService)
            {
                _log.debug("makeRpcCall on a new service");
                rpcs = this.getRpcService(serviceUrl, formatType, formatVersion);
            }
            else
            {
                _log.debug("makeRpcCall on the main service");
                if (!(this._mainRpcServiceManager))
                {
                    this._mainRpcServiceManager = new RpcServiceManager(serviceUrl, formatType, formatVersion);
                }
                else
                {
                    this._mainRpcServiceManager.type = formatType;
                    this._mainRpcServiceManager.service = serviceUrl;
                };
                rpcs = this._mainRpcServiceManager;
            };
            rpcs.callMethod(methodName, methodParams, callback, retryOnTimedout);
        }

        private function getRpcService(serviceUrl:String, formatType:String, formatVersion:String):RpcServiceManager
        {
            var rpcService:RpcServiceManager;
            var newServiceRcp:RpcServiceManager;
            if (!(_rpcServices))
            {
                _rpcServices = new Vector.<RpcServiceManager>();
            };
            for each (rpcService in _rpcServices)
            {
                if (!(rpcService.busy))
                {
                    rpcService.service = serviceUrl;
                    rpcService.type = formatType;
                    return (rpcService);
                };
            };
            newServiceRcp = new RpcServiceManager(serviceUrl, formatType, formatVersion);
            _rpcServices.push(newServiceRcp);
            return (newServiceRcp);
        }


    }
}//package com.ankamagames.dofus.misc.utils

