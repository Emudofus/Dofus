package com.ankamagames.dofus.logic.connection.managers
{
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.misc.interClient.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.hurlant.util.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;

    public class StoreUserDataManager extends Object
    {
        private var _so:CustomSharedObject;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(StoreUserDataManager));
        private static var BASE_URL:String = "http://api.ankama.";
        private static var _self:StoreUserDataManager;

        public function StoreUserDataManager()
        {
            if (_self != null)
            {
                throw new SingletonError("StoreUserDataManager is a singleton and should not be instanciated directly.");
            }
            if (BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE || BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA || BuildInfos.BUILD_TYPE == BuildTypeEnum.ALPHA)
            {
                BASE_URL = BASE_URL + "com";
            }
            else
            {
                BASE_URL = BASE_URL + "lan";
            }
            return;
        }// end function

        public function savePlayerData() : void
        {
            var _loc_4:String = null;
            var _loc_5:Array = null;
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_9:Array = null;
            var _loc_10:String = null;
            var _loc_11:Object = null;
            var _loc_12:String = null;
            var _loc_15:Array = null;
            var _loc_16:String = null;
            var _loc_17:RpcServiceManager = null;
            arguments = false;
            arguments = Dofus.getInstance().invokeArgs;
            var _loc_3:String = "";
            for each (_loc_4 in arguments)
            {
                
                if (_loc_4.search("sysinfos") != -1)
                {
                    _loc_3 = Base64.decode(_loc_4.replace("--sysinfos=", ""));
                    arguments = true;
                    break;
                }
            }
            _loc_5 = _loc_3.split("\n");
            _loc_9 = new Array();
            for each (_loc_6 in _loc_5)
            {
                
                _loc_6 = _loc_6.replace("\n", "");
                if (_loc_6 == "" || _loc_6.search(":") == -1)
                {
                    continue;
                }
                _loc_15 = _loc_6.split(":");
                _loc_7 = _loc_15[0];
                _loc_8 = _loc_15[1];
                if (_loc_8 == "" || _loc_7 == "")
                {
                    continue;
                }
                switch(_loc_7)
                {
                    case "RAM_FREE":
                    case "DISK_FREE":
                    {
                        break;
                    }
                    case "VIDEO_DRIVER_INSTALLATION_DATE":
                    {
                        _loc_8 = _loc_8.substr(0, 6);
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
                _loc_9.push({key:_loc_7, value:_loc_8});
            }
            _loc_9.sortOn("key");
            _loc_10 = "";
            for each (_loc_11 in _loc_9)
            {
                
                _loc_10 = _loc_10 + (_loc_11.key + ":" + _loc_11.value + ";");
            }
            _loc_10 = _loc_10 + ("isAbo:" + (PlayerManager.getInstance().subscriptionEndDate > 0 || PlayerManager.getInstance().hasRights) + ";");
            _loc_10 = _loc_10 + ("creationAbo:" + PlayerManager.getInstance().accountCreation + ";");
            _loc_10 = _loc_10 + ("flashKey:" + InterClientManager.getInstance().flashKey + ";");
            _loc_10 = _loc_10 + ("screenResolution:" + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + ";");
            _loc_12 = Capabilities.os.toLowerCase();
            _loc_10 = _loc_10 + "os:";
            if (_loc_12.search("windows") != -1)
            {
                _loc_10 = _loc_10 + "windows";
            }
            else if (_loc_12.search("mac") != -1)
            {
                _loc_10 = _loc_10 + "mac";
            }
            else if (_loc_12.search("linux") != -1)
            {
                _loc_10 = _loc_10 + "linux";
            }
            else
            {
                _loc_10 = _loc_10 + "other";
            }
            _loc_10 = _loc_10 + ";";
            _loc_10 = _loc_10 + "supports:";
            if (Capabilities.supports32BitProcesses && !Capabilities.supports64BitProcesses)
            {
                _loc_10 = _loc_10 + "32Bits";
            }
            else if (Capabilities.supports64BitProcesses)
            {
                _loc_10 = _loc_10 + "64Bits";
            }
            else
            {
                _loc_10 = _loc_10 + "none";
            }
            _loc_10 = _loc_10 + ";";
            _loc_10 = _loc_10 + ("isUsingUpdater:" + arguments + ";");
            var _loc_13:* = MD5.hash(_loc_10);
            var _loc_14:* = PlayerManager.getInstance().accountId;
            this._so = CustomSharedObject.getLocal("playerData_" + _loc_14);
            if (this._so.data && (this._so.data == _loc_13 || arguments.length == 0 && this._so.data.length != 0))
            {
                return;
            }
            this._so.data = _loc_13;
            _loc_16 = BASE_URL + "/dofus/logger.json";
            _loc_17 = new RpcServiceManager(_loc_16, "json");
            _loc_17.addEventListener(Event.COMPLETE, this.onDataSavedComplete);
            _loc_17.addEventListener(IOErrorEvent.IO_ERROR, this.onDataSavedError);
            _loc_17.addEventListener(RpcServiceManager.SERVER_ERROR, this.onDataSavedError);
            _loc_17.callMethod("Log", {sUid:MD5.hash(_loc_14.toString()), aValues:{config:_loc_10}});
            return;
        }// end function

        private function onDataSavedComplete(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as RpcServiceManager;
            if (this._so != null)
            {
                _log.debug("User data saved.");
                this._so.flush();
            }
            this.clearService(_loc_2);
            return;
        }// end function

        private function onDataSavedError(event:Event) : void
        {
            _log.error("Can\'t send player\'s data to server !");
            var _loc_2:* = event.currentTarget as RpcServiceManager;
            this.clearService(_loc_2);
            return;
        }// end function

        private function clearService(param1:RpcServiceManager) : void
        {
            param1.removeEventListener(Event.COMPLETE, this.onDataSavedComplete);
            param1.removeEventListener(IOErrorEvent.IO_ERROR, this.onDataSavedError);
            param1.removeEventListener(RpcServiceManager.SERVER_ERROR, this.onDataSavedError);
            param1.destroy();
            return;
        }// end function

        public static function getInstance() : StoreUserDataManager
        {
            if (_self == null)
            {
                _self = new StoreUserDataManager;
            }
            return _self;
        }// end function

    }
}
