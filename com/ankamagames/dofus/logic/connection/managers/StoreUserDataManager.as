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
      
      public function savePlayerData() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
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
