package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import flash.external.ExternalInterface;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import __AS3__.vec.*;

    public class RpcServiceCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RpcServiceCenter));
        private static const WEB_API_BASE_URL:String = "http://api.ankama.";
        private static const AUTHORIZED_DOMAIN_EXTENSION:Array = ["com", "lan", "tst"];
        private static var _self:RpcServiceCenter;
        private static var _rpcServices:Vector.<RpcServiceManager>;

        private var _mainRpcServiceManager:RpcServiceManager;
        private var _currentApiDomain:String;


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

        public function get apiDomain():String
        {
            var domainExtension:String;
            var url:String;
            var serverName:String;
            var tmpArr:Array;
            if (!(this._currentApiDomain))
            {
                domainExtension = "";
                if (ExternalInterface.available)
                {
                    url = (ExternalInterface.call("eval", "document.URL") as String);
                    serverName = url.split("/")[2];
                    tmpArr = serverName.split(".");
                    if (tmpArr.length > 1)
                    {
                        domainExtension = tmpArr.pop();
                    };
                };
                if (((AirScanner.isStreamingVersion()) && (!((AUTHORIZED_DOMAIN_EXTENSION.indexOf(domainExtension) == -1)))))
                {
                    this._currentApiDomain = (WEB_API_BASE_URL + domainExtension);
                }
                else
                {
                    if (BuildInfos.BUILD_TYPE <= BuildTypeEnum.ALPHA)
                    {
                        this._currentApiDomain = (WEB_API_BASE_URL + "com");
                    }
                    else
                    {
                        this._currentApiDomain = (WEB_API_BASE_URL + "lan");
                    };
                };
            };
            return (this._currentApiDomain);
        }

        public function get secureApiDomain():String
        {
            return (this.apiDomain.replace("http:", "https:"));
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

