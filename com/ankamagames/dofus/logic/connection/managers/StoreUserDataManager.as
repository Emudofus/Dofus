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
            if(BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE || BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA || BuildInfos.BUILD_TYPE == BuildTypeEnum.ALPHA)
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
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc9_:String = null;
         var _loc10_:Object = null;
         var _loc11_:String = null;
         var _loc14_:Array = null;
         var _loc15_:String = null;
         var _loc16_:RpcServiceManager = null;
         var _loc2_:* = false;
         var _loc3_:* = "";
         if(CommandLineArguments.getInstance().hasArgument("sysinfos"))
         {
            _loc3_ = Base64.decode(CommandLineArguments.getInstance().getArgument("sysinfos"));
            _loc2_ = true;
         }
         var _loc4_:Array = _loc3_.split("\n");
         var _loc8_:Array = new Array();
         for each (_loc5_ in _loc4_)
         {
            _loc5_ = _loc5_.replace("\n","");
            if(!(_loc5_ == "" || _loc5_.search(":") == -1))
            {
               _loc14_ = _loc5_.split(":");
               _loc6_ = _loc14_[0];
               _loc7_ = _loc14_[1];
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
                  _loc8_.push(
                     {
                        "key":_loc6_,
                        "value":_loc7_
                     });
               }
            }
         }
         _loc8_.sortOn("key");
         _loc9_ = "";
         for each (_loc10_ in _loc8_)
         {
            _loc9_ = _loc9_ + (_loc10_.key + ":" + _loc10_.value + ";");
         }
         _loc9_ = _loc9_ + ("isAbo:" + (PlayerManager.getInstance().subscriptionEndDate > 0 || PlayerManager.getInstance().hasRights) + ";");
         _loc9_ = _loc9_ + ("creationAbo:" + PlayerManager.getInstance().accountCreation + ";");
         _loc9_ = _loc9_ + ("flashKey:" + InterClientManager.getInstance().flashKey + ";");
         _loc9_ = _loc9_ + ("screenResolution:" + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + ";");
         _loc11_ = Capabilities.os.toLowerCase();
         _loc9_ = _loc9_ + "os:";
         if(_loc11_.search("windows") != -1)
         {
            _loc9_ = _loc9_ + "windows";
         }
         else
         {
            if(_loc11_.search("mac") != -1)
            {
               _loc9_ = _loc9_ + "mac";
            }
            else
            {
               if(_loc11_.search("linux") != -1)
               {
                  _loc9_ = _loc9_ + "linux";
               }
               else
               {
                  _loc9_ = _loc9_ + "other";
               }
            }
         }
         _loc9_ = _loc9_ + ";";
         _loc9_ = _loc9_ + "supports:";
         if((Capabilities.supports32BitProcesses) && !Capabilities.supports64BitProcesses)
         {
            _loc9_ = _loc9_ + "32Bits";
         }
         else
         {
            if(Capabilities.supports64BitProcesses)
            {
               _loc9_ = _loc9_ + "64Bits";
            }
            else
            {
               _loc9_ = _loc9_ + "none";
            }
         }
         _loc9_ = _loc9_ + ";";
         _loc9_ = _loc9_ + ("isUsingUpdater:" + _loc2_ + ";");
         var _loc12_:String = MD5.hash(_loc9_);
         var _loc13_:uint = PlayerManager.getInstance().accountId;
         this._so = CustomSharedObject.getLocal("playerData_" + _loc13_);
         if((this._so.data) && ((this._so.data == _loc12_) || (((arguments) && (arguments.length == 0)) && (!(this._so.data.length == 0)))))
         {
            return;
         }
         this._so.data = _loc12_;
         _loc15_ = BASE_URL + "/dofus/logger.json";
         _loc16_ = new RpcServiceManager(_loc15_,"json");
         _loc16_.addEventListener(Event.COMPLETE,this.onDataSavedComplete);
         _loc16_.addEventListener(IOErrorEvent.IO_ERROR,this.onDataSavedError);
         _loc16_.addEventListener(RpcServiceManager.SERVER_ERROR,this.onDataSavedError);
         _loc16_.callMethod("Log",
            {
               "sUid":MD5.hash(_loc13_.toString()),
               "aValues":{"config":_loc9_}
            });
      }
      
      private function onDataSavedComplete(param1:Event) : void {
         var _loc2_:RpcServiceManager = param1.currentTarget as RpcServiceManager;
         if(this._so != null)
         {
            _log.debug("User data saved.");
            this._so.flush();
         }
         this.clearService(_loc2_);
      }
      
      private function onDataSavedError(param1:Event) : void {
         _log.error("Can\'t send player\'s data to server !");
         var _loc2_:RpcServiceManager = param1.currentTarget as RpcServiceManager;
         this.clearService(_loc2_);
      }
      
      private function clearService(param1:RpcServiceManager) : void {
         param1.removeEventListener(Event.COMPLETE,this.onDataSavedComplete);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this.onDataSavedError);
         param1.removeEventListener(RpcServiceManager.SERVER_ERROR,this.onDataSavedError);
         param1.destroy();
      }
   }
}
