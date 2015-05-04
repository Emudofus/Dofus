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
   import com.ankamagames.dofus.misc.utils.RpcServiceCenter;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class StoreUserDataManager extends Object
   {
      
      public function StoreUserDataManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("StoreUserDataManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            return;
         }
      }
      
      private static const INFOS_EXCLUDED_FROM_MD5CHECK:Array = ["CPUFrequencies","FreeSystemMemory"];
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StoreUserDataManager));
      
      private static var _self:StoreUserDataManager;
      
      public static function getInstance() : StoreUserDataManager
      {
         if(_self == null)
         {
            _self = new StoreUserDataManager();
         }
         return _self;
      }
      
      private var _so:CustomSharedObject;
      
      private var _postMd5CheckInfos:String;
      
      public function savePlayerData() : void
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc9_:Object = null;
         var _loc10_:Array = null;
         if(AirScanner.isStreamingVersion())
         {
            this.savePlayerStreamingData();
            return;
         }
         var _loc1_:* = false;
         var _loc2_:* = "";
         var _loc3_:* = "";
         if(CommandLineArguments.getInstance().hasArgument("sysinfos"))
         {
            _loc3_ = Base64.decode(CommandLineArguments.getInstance().getArgument("sysinfos"));
            _loc4_ = _loc3_.split("\n");
            _loc8_ = new Array();
            for each(_loc5_ in _loc4_)
            {
               _loc5_ = _loc5_.replace("\n","");
               if(!(_loc5_ == "" || _loc5_.search(":") == -1))
               {
                  _loc10_ = _loc5_.split(":");
                  _loc6_ = _loc10_[0];
                  _loc7_ = _loc10_[1];
                  if(!(_loc7_ == "" || _loc6_ == ""))
                  {
                     switch(_loc6_)
                     {
                        case "RAM_FREE":
                        case "DISK_FREE":
                           continue;
                        case "VIDEO_DRIVER_INSTALLATION_DATE":
                           _loc7_ = _loc7_.substr(0,6);
                           break;
                     }
                     _loc8_.push({
                        "key":_loc6_,
                        "value":_loc7_
                     });
                  }
               }
            }
            _loc8_.sortOn("key");
            for each(_loc9_ in _loc8_)
            {
               _loc2_ = _loc2_ + (_loc9_.key + ":" + _loc9_.value + ";");
            }
            _loc1_ = true;
         }
         else if((CommandLineArguments.getInstance().hasArgument("updater_version")) && CommandLineArguments.getInstance().getArgument("updater_version") == "v2")
         {
            PartManagerV2.getInstance().getSystemConfiguration();
            _loc1_ = true;
            return;
         }
         
         this.savePlayerAirData(_loc2_,_loc1_);
      }
      
      private function savePlayerAirData(param1:String, param2:Boolean) : void
      {
         var param1:* = param1 + "envType:air;";
         param1 = param1 + ("isAbo:" + (PlayerManager.getInstance().subscriptionEndDate > 0 || PlayerManager.getInstance().hasRights) + ";");
         param1 = param1 + ("creationAbo:" + PlayerManager.getInstance().accountCreation + ";");
         param1 = param1 + ("flashKey:" + InterClientManager.getInstance().flashKey + ";");
         param1 = param1 + ("screenResolution:" + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + ";");
         var _loc3_:String = Capabilities.os.toLowerCase();
         param1 = param1 + "os:";
         if(_loc3_.search("windows") != -1)
         {
            param1 = param1 + "windows";
         }
         else if(_loc3_.search("mac") != -1)
         {
            param1 = param1 + "mac";
         }
         else if(_loc3_.search("linux") != -1)
         {
            param1 = param1 + "linux";
         }
         else
         {
            param1 = param1 + "other";
         }
         
         
         param1 = param1 + ";";
         param1 = param1 + ("osVersion:" + SystemManager.getSingleton().version + ";");
         param1 = param1 + "supports:";
         if((Capabilities.supports32BitProcesses) && !Capabilities.supports64BitProcesses)
         {
            param1 = param1 + "32Bits";
         }
         else if(Capabilities.supports64BitProcesses)
         {
            param1 = param1 + "64Bits";
         }
         else
         {
            param1 = param1 + "none";
         }
         
         param1 = param1 + ";";
         param1 = param1 + ("isUsingUpdater:" + param2 + ";");
         this.submitData(param1);
      }
      
      private function savePlayerStreamingData() : void
      {
         var _loc1_:* = "";
         _loc1_ = _loc1_ + "envType:streaming;";
         _loc1_ = _loc1_ + ("isAbo:" + (PlayerManager.getInstance().subscriptionEndDate > 0 || PlayerManager.getInstance().hasRights) + ";");
         _loc1_ = _loc1_ + ("creationAbo:" + PlayerManager.getInstance().accountCreation + ";");
         _loc1_ = _loc1_ + ("screenResolution:" + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + ";");
         var _loc2_:String = Capabilities.os.toLowerCase();
         _loc1_ = _loc1_ + "os:";
         if(_loc2_.search("windows") != -1)
         {
            _loc1_ = _loc1_ + "windows";
         }
         else if(_loc2_.search("mac") != -1)
         {
            _loc1_ = _loc1_ + "mac";
         }
         else if(Capabilities.manufacturer.toLowerCase().search("android") != -1)
         {
            _loc1_ = _loc1_ + "android";
         }
         else if(_loc2_.search("linux") != -1)
         {
            _loc1_ = _loc1_ + "linux";
         }
         else if(!(_loc2_.search("ipad") == -1) || !(_loc2_.search("iphone") == -1))
         {
            _loc1_ = _loc1_ + "ios";
         }
         else
         {
            _loc1_ = _loc1_ + "other";
         }
         
         
         
         
         _loc1_ = _loc1_ + ";";
         _loc1_ = _loc1_ + ("osVersion:" + SystemManager.getSingleton().version + ";");
         _loc1_ = _loc1_ + "supports:";
         if((Capabilities.supports32BitProcesses) && !Capabilities.supports64BitProcesses)
         {
            _loc1_ = _loc1_ + "32Bits";
         }
         else if(Capabilities.supports64BitProcesses)
         {
            _loc1_ = _loc1_ + "64Bits";
         }
         else
         {
            _loc1_ = _loc1_ + "none";
         }
         
         _loc1_ = _loc1_ + ";";
         _loc1_ = _loc1_ + ("browser:" + SystemManager.getSingleton().browser + ";");
         _loc1_ = _loc1_ + ("browserVersion:" + SystemManager.getSingleton().browserVersion + ";");
         _loc1_ = _loc1_ + ("fpVersion:" + Capabilities.version + ";");
         _loc1_ = _loc1_ + ("fpManufacturer:" + Capabilities.manufacturer + ";");
         this.submitData(_loc1_);
      }
      
      private function submitData(param1:String) : void
      {
         var _loc4_:RpcServiceManager = null;
         var _loc5_:Object = null;
         var _loc2_:String = MD5.hash(param1);
         var param1:String = param1 + this._postMd5CheckInfos;
         this._postMd5CheckInfos = "";
         var _loc3_:uint = PlayerManager.getInstance().accountId;
         this._so = CustomSharedObject.getLocal("playerData_" + _loc3_);
         if((this._so.data && this._so.data.hasOwnProperty("version") && this._so.data.md5 == _loc2_) && (this._so.data.version.major >= 2 && this._so.data.version.minor >= 23) && (Benchmark.hasCachedResults))
         {
            return;
         }
         this._so.data = new Object();
         this._so.data.md5 = _loc2_;
         this._so.data.version = {
            "major":BuildInfos.BUILD_VERSION.major,
            "minor":BuildInfos.BUILD_VERSION.minor
         };
         this._so.flush();
         _loc4_ = new RpcServiceManager(RpcServiceCenter.getInstance().apiDomain + "/dofus/logger.json","json");
         _loc4_.addEventListener(Event.COMPLETE,this.onDataSavedComplete);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.onDataSavedError);
         _loc4_.addEventListener(RpcServiceManager.SERVER_ERROR,this.onDataSavedError);
         _loc5_ = {
            "sUid":MD5.hash(_loc3_.toString()),
            "aValues":{
               "config":param1,
               "benchmark":Benchmark.getResults(true)
            }
         };
         _loc4_.callMethod("Log",_loc5_);
      }
      
      private function onDataSavedComplete(param1:Event) : void
      {
         var _loc2_:RpcServiceManager = param1.currentTarget as RpcServiceManager;
         if(this._so != null)
         {
            _log.debug("User data saved.");
            this._so.flush();
         }
         this.clearService(_loc2_);
      }
      
      private function onDataSavedError(param1:Event) : void
      {
         _log.error("Can\'t send player\'s data to server !");
         var _loc2_:RpcServiceManager = param1.currentTarget as RpcServiceManager;
         this.clearService(_loc2_);
      }
      
      private function clearService(param1:RpcServiceManager) : void
      {
         param1.removeEventListener(Event.COMPLETE,this.onDataSavedComplete);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this.onDataSavedError);
         param1.removeEventListener(RpcServiceManager.SERVER_ERROR,this.onDataSavedError);
         param1.destroy();
      }
      
      public function onSystemConfiguration(param1:*) : void
      {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc2_:* = "";
         this._postMd5CheckInfos = "";
         var _loc3_:Array = new Array();
         if(param1)
         {
            for(_loc4_ in param1.config)
            {
               _loc3_.push({
                  "key":_loc4_,
                  "value":param1.config[_loc4_]
               });
            }
         }
         _loc3_.sortOn("key");
         for each(_loc5_ in _loc3_)
         {
            if(INFOS_EXCLUDED_FROM_MD5CHECK.indexOf(_loc5_.key) == -1)
            {
               _loc2_ = _loc2_ + (_loc5_.key + ":" + _loc5_.value + ";");
            }
            else
            {
               this._postMd5CheckInfos = this._postMd5CheckInfos + (_loc5_.key + ":" + _loc5_.value + ";");
            }
         }
         this.savePlayerAirData(_loc2_,true);
      }
   }
}
