package com.ankamagames.dofus.logic.connection.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.CustomSharedObject;
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
   import com.ankamagames.dofus.BuildInfos;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   
   public class StoreUserDataManager extends Object
   {
      
      public function StoreUserDataManager() {
         super();
         if(_self != null)
         {
            throw new SingletonError("StoreUserDataManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            if((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.ALPHA))
            {
               BASE_URL = BASE_URL + "com";
            }
            else
            {
               BASE_URL = BASE_URL + "lan";
            }
            return;
         }
      }
      
      private static const INFOS_EXCLUDED_FROM_MD5CHECK:Array;
      
      protected static const _log:Logger;
      
      private static var BASE_URL:String = "http://api.ankama.";
      
      private static var _self:StoreUserDataManager;
      
      public static function getInstance() : StoreUserDataManager {
         if(_self == null)
         {
            _self = new StoreUserDataManager();
         }
         return _self;
      }
      
      private var _so:CustomSharedObject;
      
      private var _postMd5CheckInfos:String;
      
      public function savePlayerData() : void {
         var data:String;
         var key:String;
         var value:String;
         var newValue:String;
         var obj:Object;
         var environnementType:String;
         var tmp:Array;
         if (AirScanner.isStreamingVersion()){
             this.savePlayerStreamingData();
             return;
         };
         var isUsingUpdater:Boolean;
         var val:String = "";
         if (CommandLineArguments.getInstance().hasArgument("sysinfos")){
             val = Base64.decode(CommandLineArguments.getInstance().getArgument("sysinfos"));
             isUsingUpdater = true;
         };
         var datas:Array = val.split("\n");
         var dict:Array = new Array();
         for each (data in datas) {
             data = data.replace("\n", "");
             if ((((data == "")) || ((data.search(":") == -1)))){
             } else {
                 tmp = data.split(":");
                 key = tmp[0];
                 value = tmp[1];
                 if ((((value == "")) || ((key == "")))){
                 } else {
                     switch (key){
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
         newValue = "";
         for each (obj in dict) {
             newValue = (newValue + (((obj.key + ":") + obj.value) + ";"));
         };
         environnementType = ((AirScanner.isStreamingVersion()) ? "streaming" : "air");
         newValue = (newValue + (("envType:" + environnementType) + ";"));
         newValue = (newValue + (("isAbo:" + (((PlayerManager.getInstance().subscriptionEndDate > 0)) || (PlayerManager.getInstance().hasRights))) + ";"));
         newValue = (newValue + (("creationAbo:" + PlayerManager.getInstance().accountCreation) + ";"));
         newValue = (newValue + (("flashKey:" + InterClientManager.getInstance().flashKey) + ";"));
         newValue = (newValue + (((("screenResolution:" + Capabilities.screenResolutionX) + "x") + Capabilities.screenResolutionY) + ";"));
         var osNoFormate:String = Capabilities.os.toLowerCase();
         newValue = newValue + "os:";
         if(osNoFormate.search("windows") != -1)
         {
            newValue = newValue + "windows";
         }
         else if(osNoFormate.search("mac") != -1)
         {
            newValue = newValue + "mac";
         }
         else if(osNoFormate.search("linux") != -1)
         {
            newValue = newValue + "linux";
         }
         else
         {
            newValue = newValue + "other";
         }
         
         
         newValue = newValue + ";";
         newValue = newValue + ("osVersion:" + SystemManager.getSingleton().version + ";");
         newValue = newValue + "supports:";
         if((Capabilities.supports32BitProcesses) && (!Capabilities.supports64BitProcesses))
         {
            newValue = newValue + "32Bits";
         }
         else if(Capabilities.supports64BitProcesses)
         {
            newValue = newValue + "64Bits";
         }
         else
         {
            newValue = newValue + "none";
         }
         
         newValue = newValue + ";";
         newValue = newValue + ("isUsingUpdater:" + isUsingUpdater + ";");
         this.submitData(newValue);
      }
      
      private function savePlayerStreamingData() : void {
         var newValue:String = "";
         newValue = newValue + "envType:streaming;";
         newValue = newValue + ("isAbo:" + (PlayerManager.getInstance().subscriptionEndDate > 0 || PlayerManager.getInstance().hasRights) + ";");
         newValue = newValue + ("creationAbo:" + PlayerManager.getInstance().accountCreation + ";");
         newValue = newValue + ("screenResolution:" + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + ";");
         var osNoFormate:String = Capabilities.os.toLowerCase();
         newValue = newValue + "os:";
         if(osNoFormate.search("windows") != -1)
         {
            newValue = newValue + "windows";
         }
         else if(osNoFormate.search("mac") != -1)
         {
            newValue = newValue + "mac";
         }
         else if(Capabilities.manufacturer.toLowerCase().search("android") != -1)
         {
            newValue = newValue + "android";
         }
         else if(osNoFormate.search("linux") != -1)
         {
            newValue = newValue + "linux";
         }
         else if((!(osNoFormate.search("ipad") == -1)) || (!(osNoFormate.search("iphone") == -1)))
         {
            newValue = newValue + "ios";
         }
         else
         {
            newValue = newValue + "other";
         }
         
         
         
         
         newValue = newValue + ";";
         newValue = newValue + ("osVersion:" + SystemManager.getSingleton().version + ";");
         newValue = newValue + "supports:";
         if((Capabilities.supports32BitProcesses) && (!Capabilities.supports64BitProcesses))
         {
            newValue = newValue + "32Bits";
         }
         else if(Capabilities.supports64BitProcesses)
         {
            newValue = newValue + "64Bits";
         }
         else
         {
            newValue = newValue + "none";
         }
         
         newValue = newValue + ";";
         newValue = newValue + ("browser:" + SystemManager.getSingleton().browser + ";");
         newValue = newValue + ("browserVersion:" + SystemManager.getSingleton().browserVersion + ";");
         newValue = newValue + ("fpVersion:" + Capabilities.version + ";");
         newValue = newValue + ("fpManufacturer:" + Capabilities.manufacturer + ";");
         this.submitData(newValue);
      }
      
      private function submitData(playerData:String) : void {
         var url:String = null;
         var rpcService:RpcServiceManager = null;
         var logObj:Object = null;
         var md5value:String = MD5.hash(playerData);
         var playerData:String = playerData + this._postMd5CheckInfos;
         this._postMd5CheckInfos = "";
         var playerId:uint = PlayerManager.getInstance().accountId;
         this._so = CustomSharedObject.getLocal("playerData_" + playerId);
         if((this._so.data && this._so.data.hasOwnProperty("version") && this._so.data.md5 == md5value) && (this._so.data.version.major >= 2 && this._so.data.version.minor >= 23) && (Benchmark.hasCachedResults))
         {
            return;
         }
         this._so.data = new Object();
         this._so.data.md5 = md5value;
         this._so.data.version = 
            {
               "major":BuildInfos.BUILD_VERSION.major,
               "minor":BuildInfos.BUILD_VERSION.minor
            };
         this._so.flush();
         url = BASE_URL + "/dofus/logger.json";
         rpcService = new RpcServiceManager(url,"json");
         rpcService.addEventListener(Event.COMPLETE,this.onDataSavedComplete);
         rpcService.addEventListener(IOErrorEvent.IO_ERROR,this.onDataSavedError);
         rpcService.addEventListener(RpcServiceManager.SERVER_ERROR,this.onDataSavedError);
         logObj = 
            {
               "sUid":MD5.hash(playerId.toString()),
               "aValues":
                  {
                     "config":playerData,
                     "benchmark":Benchmark.getResults(true)
                  }
            };
         rpcService.callMethod("Log",logObj);
      }
      
      private function onDataSavedComplete(pEvt:Event) : void {
         var rpcService:RpcServiceManager = pEvt.currentTarget as RpcServiceManager;
         if(this._so != null)
         {
            _log.debug("User data saved.");
            this._so.flush();
         }
         this.clearService(rpcService);
      }
      
      private function onDataSavedError(pEvt:Event) : void {
         _log.error("Can\'t send player\'s data to server !");
         var rpcService:RpcServiceManager = pEvt.currentTarget as RpcServiceManager;
         this.clearService(rpcService);
      }
      
      private function clearService(rpcService:RpcServiceManager) : void {
         rpcService.removeEventListener(Event.COMPLETE,this.onDataSavedComplete);
         rpcService.removeEventListener(IOErrorEvent.IO_ERROR,this.onDataSavedError);
         rpcService.removeEventListener(RpcServiceManager.SERVER_ERROR,this.onDataSavedError);
         rpcService.destroy();
      }
      
      public function onSystemConfiguration(config:*) : void {
         var key:String = null;
         var obj:Object = null;
         var newValue:String = "";
         this._postMd5CheckInfos = "";
         var dict:Array = new Array();
         if(config)
         {
            for(key in config.config)
            {
               dict.push(
                  {
                     "key":key,
                     "value":config.config[key]
                  });
            }
         }
         dict.sortOn("key");
         for each(obj in dict)
         {
            if(INFOS_EXCLUDED_FROM_MD5CHECK.indexOf(obj.key) == -1)
            {
               newValue = newValue + (obj.key + ":" + obj.value + ";");
            }
            else
            {
               this._postMd5CheckInfos = this._postMd5CheckInfos + (obj.key + ":" + obj.value + ";");
            }
         }
         this.savePlayerAirData(newValue,true);
      }
   }
}
