package com.ankamagames.dofus.logic.connection.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import com.ankamagames.dofus.misc.utils.RpcServiceManager;
   import com.ankamagames.jerakine.utils.system.CommandLineArguments;
   import com.hurlant.util.Base64;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.misc.interClient.InterClientManager;
   import flash.system.Capabilities;
   import by.blooddy.crypto.MD5;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.dofus.BuildInfos;
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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StoreUserDataManager));
      
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
      
      public function savePlayerData() : void {
         var data:String = null;
         var key:String = null;
         var value:String = null;
         var newValue:String = null;
         var obj:Object = null;
         var osNoFormate:String = null;
         var tmp:Array = null;
         var url:String = null;
         var rpcService:RpcServiceManager = null;
         var isUsingUpdater:Boolean = false;
         var val:String = "";
         if(CommandLineArguments.getInstance().hasArgument("sysinfos"))
         {
            val = Base64.decode(CommandLineArguments.getInstance().getArgument("sysinfos"));
            isUsingUpdater = true;
         }
         var datas:Array = val.split("\n");
         var dict:Array = new Array();
         for each (data in datas)
         {
            data = data.replace("\n","");
            if(!((data == "") || (data.search(":") == -1)))
            {
               tmp = data.split(":");
               key = tmp[0];
               value = tmp[1];
               if(!((value == "") || (key == "")))
               {
                  switch(key)
                  {
                     case "RAM_FREE":
                     case "DISK_FREE":
                        continue;
                     case "VIDEO_DRIVER_INSTALLATION_DATE":
                        value = value.substr(0,6);
                        break;
                  }
                  dict.push(
                     {
                        "key":key,
                        "value":value
                     });
               }
            }
         }
         dict.sortOn("key");
         newValue = "";
         for each (obj in dict)
         {
            newValue = newValue + (obj.key + ":" + obj.value + ";");
         }
         newValue = newValue + ("isAbo:" + (PlayerManager.getInstance().subscriptionEndDate > 0 || PlayerManager.getInstance().hasRights) + ";");
         newValue = newValue + ("creationAbo:" + PlayerManager.getInstance().accountCreation + ";");
         newValue = newValue + ("flashKey:" + InterClientManager.getInstance().flashKey + ";");
         newValue = newValue + ("screenResolution:" + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + ";");
         osNoFormate = Capabilities.os.toLowerCase();
         newValue = newValue + "os:";
         if(osNoFormate.search("windows") != -1)
         {
            newValue = newValue + "windows";
         }
         else
         {
            if(osNoFormate.search("mac") != -1)
            {
               newValue = newValue + "mac";
            }
            else
            {
               if(osNoFormate.search("linux") != -1)
               {
                  newValue = newValue + "linux";
               }
               else
               {
                  newValue = newValue + "other";
               }
            }
         }
         newValue = newValue + ";";
         newValue = newValue + "supports:";
         if((Capabilities.supports32BitProcesses) && (!Capabilities.supports64BitProcesses))
         {
            newValue = newValue + "32Bits";
         }
         else
         {
            if(Capabilities.supports64BitProcesses)
            {
               newValue = newValue + "64Bits";
            }
            else
            {
               newValue = newValue + "none";
            }
         }
         newValue = newValue + ";";
         newValue = newValue + ("isUsingUpdater:" + isUsingUpdater + ";");
         var md5value:String = MD5.hash(newValue);
         var playerId:uint = PlayerManager.getInstance().accountId;
         this._so = CustomSharedObject.getLocal("playerData_" + playerId);
         if((this._so.data) && ((this._so.data == md5value) || (((arguments) && (arguments.length == 0)) && (!(this._so.data.length == 0)))))
         {
            return;
         }
         this._so.data = md5value;
         url = BASE_URL + "/dofus/logger.json";
         rpcService = new RpcServiceManager(url,"json");
         rpcService.addEventListener(Event.COMPLETE,this.onDataSavedComplete);
         rpcService.addEventListener(IOErrorEvent.IO_ERROR,this.onDataSavedError);
         rpcService.addEventListener(RpcServiceManager.SERVER_ERROR,this.onDataSavedError);
         rpcService.callMethod("Log",
            {
               "sUid":MD5.hash(playerId.toString()),
               "aValues":{"config":newValue}
            });
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
   }
}
