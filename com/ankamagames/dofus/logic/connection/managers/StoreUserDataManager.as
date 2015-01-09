package com.ankamagames.dofus.logic.connection.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.CustomSharedObject;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.jerakine.utils.system.CommandLineArguments;
    import com.hurlant.util.Base64;
    import com.ankamagames.dofus.logic.game.approach.managers.PartManagerV2;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.misc.interClient.InterClientManager;
    import flash.system.Capabilities;
    import com.ankamagames.jerakine.utils.system.SystemManager;
    import com.ankamagames.dofus.misc.utils.RpcServiceManager;
    import by.blooddy.crypto.MD5;
    import com.ankamagames.performance.Benchmark;
    import flash.events.Event;
    import flash.events.IOErrorEvent;

    public class StoreUserDataManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StoreUserDataManager));
        private static var BASE_URL:String = "http://api.ankama.";
        private static var _self:StoreUserDataManager;

        private var _so:CustomSharedObject;

        public function StoreUserDataManager()
        {
            if (_self != null)
            {
                throw (new SingletonError("StoreUserDataManager is a singleton and should not be instanciated directly."));
            };
            if ((((((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE)) || ((BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA)))) || ((BuildInfos.BUILD_TYPE == BuildTypeEnum.ALPHA))))
            {
                BASE_URL = (BASE_URL + "com");
            }
            else
            {
                BASE_URL = (BASE_URL + "lan");
            };
        }

        public static function getInstance():StoreUserDataManager
        {
            if (_self == null)
            {
                _self = new (StoreUserDataManager)();
            };
            return (_self);
        }


        public function savePlayerData():void
        {
            var datas:Array;
            var data:String;
            var key:String;
            var value:String;
            var dict:Array;
            var obj:Object;
            var tmp:Array;
            if (AirScanner.isStreamingVersion())
            {
                this.savePlayerStreamingData();
                return;
            };
            var isUsingUpdater:Boolean;
            var newValue:String = "";
            var val:String = "";
            if (CommandLineArguments.getInstance().hasArgument("sysinfos"))
            {
                val = Base64.decode(CommandLineArguments.getInstance().getArgument("sysinfos"));
                datas = val.split("\n");
                dict = new Array();
                for each (data in datas)
                {
                    data = data.replace("\n", "");
                    if ((((data == "")) || ((data.search(":") == -1))))
                    {
                    }
                    else
                    {
                        tmp = data.split(":");
                        key = tmp[0];
                        value = tmp[1];
                        if ((((value == "")) || ((key == ""))))
                        {
                        }
                        else
                        {
                            switch (key)
                            {
                                case "RAM_FREE":
                                case "DISK_FREE":
                                    continue;
                                case "VIDEO_DRIVER_INSTALLATION_DATE":
                                    value = value.substr(0, 6);
                                    break;
                            };
                            dict.push({
                                "key":key,
                                "value":value
                            });
                        };
                    };
                };
                dict.sortOn("key");
                for each (obj in dict)
                {
                    newValue = (newValue + (((obj.key + ":") + obj.value) + ";"));
                };
                isUsingUpdater = true;
            }
            else
            {
                if (((CommandLineArguments.getInstance().hasArgument("updater_version")) && ((CommandLineArguments.getInstance().getArgument("updater_version") == "v2"))))
                {
                    PartManagerV2.getInstance().getSystemConfiguration();
                    isUsingUpdater = true;
                    return;
                };
            };
            this.savePlayerAirData(newValue, isUsingUpdater);
        }

        private function savePlayerAirData(newValue:String, isUsingUpdater:Boolean):void
        {
            newValue = (newValue + "envType:air;");
            newValue = (newValue + (("isAbo:" + (((PlayerManager.getInstance().subscriptionEndDate > 0)) || (PlayerManager.getInstance().hasRights))) + ";"));
            newValue = (newValue + (("creationAbo:" + PlayerManager.getInstance().accountCreation) + ";"));
            newValue = (newValue + (("flashKey:" + InterClientManager.getInstance().flashKey) + ";"));
            newValue = (newValue + (((("screenResolution:" + Capabilities.screenResolutionX) + "x") + Capabilities.screenResolutionY) + ";"));
            var osNoFormate:String = Capabilities.os.toLowerCase();
            newValue = (newValue + "os:");
            if (osNoFormate.search("windows") != -1)
            {
                newValue = (newValue + "windows");
            }
            else
            {
                if (osNoFormate.search("mac") != -1)
                {
                    newValue = (newValue + "mac");
                }
                else
                {
                    if (osNoFormate.search("linux") != -1)
                    {
                        newValue = (newValue + "linux");
                    }
                    else
                    {
                        newValue = (newValue + "other");
                    };
                };
            };
            newValue = (newValue + ";");
            newValue = (newValue + (("osVersion:" + SystemManager.getSingleton().version) + ";"));
            newValue = (newValue + "supports:");
            if (((Capabilities.supports32BitProcesses) && (!(Capabilities.supports64BitProcesses))))
            {
                newValue = (newValue + "32Bits");
            }
            else
            {
                if (Capabilities.supports64BitProcesses)
                {
                    newValue = (newValue + "64Bits");
                }
                else
                {
                    newValue = (newValue + "none");
                };
            };
            newValue = (newValue + ";");
            newValue = (newValue + (("isUsingUpdater:" + isUsingUpdater) + ";"));
            this.submitData(newValue);
        }

        private function savePlayerStreamingData():void
        {
            var newValue:String = "";
            newValue = (newValue + "envType:streaming;");
            newValue = (newValue + (("isAbo:" + (((PlayerManager.getInstance().subscriptionEndDate > 0)) || (PlayerManager.getInstance().hasRights))) + ";"));
            newValue = (newValue + (("creationAbo:" + PlayerManager.getInstance().accountCreation) + ";"));
            newValue = (newValue + (((("screenResolution:" + Capabilities.screenResolutionX) + "x") + Capabilities.screenResolutionY) + ";"));
            var osNoFormate:String = Capabilities.os.toLowerCase();
            newValue = (newValue + "os:");
            if (osNoFormate.search("windows") != -1)
            {
                newValue = (newValue + "windows");
            }
            else
            {
                if (osNoFormate.search("mac") != -1)
                {
                    newValue = (newValue + "mac");
                }
                else
                {
                    if (Capabilities.manufacturer.toLowerCase().search("android") != -1)
                    {
                        newValue = (newValue + "android");
                    }
                    else
                    {
                        if (osNoFormate.search("linux") != -1)
                        {
                            newValue = (newValue + "linux");
                        }
                        else
                        {
                            if (((!((osNoFormate.search("ipad") == -1))) || (!((osNoFormate.search("iphone") == -1)))))
                            {
                                newValue = (newValue + "ios");
                            }
                            else
                            {
                                newValue = (newValue + "other");
                            };
                        };
                    };
                };
            };
            newValue = (newValue + ";");
            newValue = (newValue + (("osVersion:" + SystemManager.getSingleton().version) + ";"));
            newValue = (newValue + "supports:");
            if (((Capabilities.supports32BitProcesses) && (!(Capabilities.supports64BitProcesses))))
            {
                newValue = (newValue + "32Bits");
            }
            else
            {
                if (Capabilities.supports64BitProcesses)
                {
                    newValue = (newValue + "64Bits");
                }
                else
                {
                    newValue = (newValue + "none");
                };
            };
            newValue = (newValue + ";");
            newValue = (newValue + (("browser:" + SystemManager.getSingleton().browser) + ";"));
            newValue = (newValue + (("browserVersion:" + SystemManager.getSingleton().browserVersion) + ";"));
            newValue = (newValue + (("fpVersion:" + Capabilities.version) + ";"));
            newValue = (newValue + (("fpManufacturer:" + Capabilities.manufacturer) + ";"));
            this.submitData(newValue);
        }

        private function submitData(playerData:String):void
        {
            var _local_4:String;
            var _local_5:RpcServiceManager;
            var _local_6:Object;
            var md5value:String = MD5.hash(playerData);
            var playerId:uint = PlayerManager.getInstance().accountId;
            this._so = CustomSharedObject.getLocal(("playerData_" + playerId));
            if (((((((((this._so.data) && (this._so.data.hasOwnProperty("version")))) && ((this._so.data.md5 == md5value)))) && ((((this._so.data.version.major >= 2)) && ((this._so.data.version.minor >= 22)))))) && (Benchmark.hasCachedResults)))
            {
                return;
            };
            this._so.data = new Object();
            this._so.data.md5 = md5value;
            this._so.data.version = {
                "major":BuildInfos.BUILD_VERSION.major,
                "minor":BuildInfos.BUILD_VERSION.minor
            };
            this._so.flush();
            _local_4 = (BASE_URL + "/dofus/logger.json");
            _local_5 = new RpcServiceManager(_local_4, "json");
            _local_5.addEventListener(Event.COMPLETE, this.onDataSavedComplete);
            _local_5.addEventListener(IOErrorEvent.IO_ERROR, this.onDataSavedError);
            _local_5.addEventListener(RpcServiceManager.SERVER_ERROR, this.onDataSavedError);
            _local_6 = {
                "sUid":MD5.hash(playerId.toString()),
                "aValues":{
                    "config":playerData,
                    "benchmark":Benchmark.getResults(true)
                }
            };
            _local_5.callMethod("Log", _local_6);
        }

        private function onDataSavedComplete(pEvt:Event):void
        {
            var rpcService:RpcServiceManager = (pEvt.currentTarget as RpcServiceManager);
            if (this._so != null)
            {
                _log.debug("User data saved.");
                this._so.flush();
            };
            this.clearService(rpcService);
        }

        private function onDataSavedError(pEvt:Event):void
        {
            _log.error("Can't send player's data to server !");
            var rpcService:RpcServiceManager = (pEvt.currentTarget as RpcServiceManager);
            this.clearService(rpcService);
        }

        private function clearService(rpcService:RpcServiceManager):void
        {
            rpcService.removeEventListener(Event.COMPLETE, this.onDataSavedComplete);
            rpcService.removeEventListener(IOErrorEvent.IO_ERROR, this.onDataSavedError);
            rpcService.removeEventListener(RpcServiceManager.SERVER_ERROR, this.onDataSavedError);
            rpcService.destroy();
        }

        public function onSystemConfiguration(config:*):void
        {
            var key:String;
            var newValue:String = "";
            if (config)
            {
                for (key in config.config)
                {
                    newValue = (newValue + (((key + ":") + config.config[key]) + ";"));
                };
            };
            this.savePlayerAirData(newValue, true);
        }


    }
}//package com.ankamagames.dofus.logic.connection.managers

