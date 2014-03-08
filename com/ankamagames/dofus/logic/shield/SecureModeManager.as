package com.ankamagames.dofus.logic.shield
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Timer;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.misc.utils.RpcServiceManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.types.secure.TrustCertificate;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.types.events.RpcEvent;
   import com.ankamagames.jerakine.data.I18n;
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import by.blooddy.crypto.MD5;
   import flash.filesystem.FileMode;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class SecureModeManager extends Object
   {
      
      public function SecureModeManager() {
         this._timeout = new Timer(30000);
         this._methodsCallback = new Dictionary();
         this.shieldLevel = StoreDataManager.getInstance().getSetData(Constants.DATASTORE_COMPUTER_OPTIONS,"shieldLevel",ShieldSecureLevel.MEDIUM);
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            this.initRPC();
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SecureModeManager));
      
      private static const VALIDATECODE_CODEEXPIRE:String = "CODEEXPIRE";
      
      private static const VALIDATECODE_CODEBADCODE:String = "CODEBADCODE";
      
      private static const VALIDATECODE_CODENOTFOUND:String = "CODENOTFOUND";
      
      private static const VALIDATECODE_SECURITY:String = "SECURITY";
      
      private static const VALIDATECODE_TOOMANYCERTIFICATE:String = "TOOMANYCERTIFICATE";
      
      private static const VALIDATECODE_NOTAVAILABLE:String = "NOTAVAILABLE";
      
      private static const ACCOUNT_AUTHENTIFICATION_FAILED:String = "ACCOUNT_AUTHENTIFICATION_FAILED";
      
      private static var RPC_URL:String;
      
      private static const RPC_METHOD_SECURITY_CODE:String = "SecurityCode";
      
      private static const RPC_METHOD_VALIDATE_CODE:String = "ValidateCode";
      
      private static const RPC_METHOD_MIGRATE:String = "Migrate";
      
      private static var _self:SecureModeManager;
      
      public static function getInstance() : SecureModeManager {
         if(!_self)
         {
            _self = new SecureModeManager();
         }
         return _self;
      }
      
      private var _timeout:Timer;
      
      private var _active:Boolean;
      
      private var _computerName:String;
      
      private var _methodsCallback:Dictionary;
      
      private var _hasV1Certif:Boolean;
      
      private var _rpcManager:RpcServiceManager;
      
      public function get active() : Boolean {
         return this._active;
      }
      
      public function set active(param1:Boolean) : void {
         this._active = param1;
         KernelEventsManager.getInstance().processCallback(HookList.SecureModeChange,param1);
      }
      
      public function get computerName() : String {
         return this._computerName;
      }
      
      public function set computerName(param1:String) : void {
         this._computerName = param1;
      }
      
      public function get certificate() : TrustCertificate {
         return this.retreiveCertificate();
      }
      
      public var shieldLevel:uint;
      
      public function askCode(param1:Function) : void {
         this._methodsCallback[RPC_METHOD_SECURITY_CODE] = param1;
         this._rpcManager.callMethod(RPC_METHOD_SECURITY_CODE,[this.getUsername(),AuthentificationManager.getInstance().ankamaPortalKey,1]);
      }
      
      public function sendCode(param1:String, param2:Function) : void {
         var _loc3_:ShieldCertifcate = new ShieldCertifcate();
         _loc3_.secureLevel = this.shieldLevel;
         this._methodsCallback[RPC_METHOD_VALIDATE_CODE] = param2;
         this._rpcManager.callMethod(RPC_METHOD_VALIDATE_CODE,[this.getUsername(),AuthentificationManager.getInstance().ankamaPortalKey,1,param1.toUpperCase(),_loc3_.hash,_loc3_.reverseHash,this._computerName?true:false,this._computerName?this._computerName:""]);
      }
      
      private function initRPC() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function getUsername() : String {
         var _loc1_:* = false;
         var _loc2_:* = true;
         if(_loc2_)
         {
         }
         return AuthentificationManager.getInstance().username.toLowerCase().split("|")[0];
      }
      
      private function parseRpcValidateResponse(param1:Object, param2:String) : Object {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function parseRpcASkCodeResponse(param1:Object, param2:String) : Object {
         var _loc5_:* = true;
         var _loc3_:Object = new Object();
         _loc3_.error = !_loc3_.error;
         if(!_loc5_)
         {
            while(true)
            {
               _loc3_.retry = false;
               if(_loc5_)
               {
                  break;
               }
               break;
            }
            _loc3_.text = "";
            if(_loc5_)
            {
            }
            if(!param1.error)
            {
               _loc3_.domain = param1.domain;
               _loc3_.error = false;
               if(_loc6_)
               {
               }
            }
            else
            {
               if(_loc5_)
               {
                  if(VALIDATECODE_CODEEXPIRE !== _loc4_)
                  {
                     if(_loc6_)
                     {
                     }
                  }
                  if(VALIDATECODE_CODEEXPIRE === _loc4_)
                  {
                  }
               }
               if(_loc6_)
               {
               }
               if(_loc5_)
               {
               }
            }
            if(!param1.error)
            {
               return _loc3_;
            }
            return _loc3_;
         }
         while(true)
         {
            _loc3_.fatal = false;
            if(_loc5_)
            {
               _loc3_.retry = false;
               if(!_loc5_)
               {
                  continue;
               }
            }
            _loc3_.text = "";
            if(_loc5_)
            {
            }
            if(!param1.error)
            {
               _loc3_.domain = param1.domain;
               _loc3_.error = false;
               if(_loc6_)
               {
               }
            }
            else
            {
               if(_loc5_)
               {
                  if(VALIDATECODE_CODEEXPIRE !== _loc4_)
                  {
                     if(_loc6_)
                     {
                     }
                  }
                  if(VALIDATECODE_CODEEXPIRE === _loc4_)
                  {
                  }
               }
               if(_loc6_)
               {
               }
               if(_loc5_)
               {
               }
            }
            if(!param1.error)
            {
               return _loc3_;
            }
            return _loc3_;
         }
      }
      
      private function getCertifFolder(param1:uint) : File {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function addCertificate(param1:uint, param2:String, param3:uint=2) : Boolean {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function checkMigrate() : void {
         if(!this._hasV1Certif)
         {
            return;
         }
         var _loc1_:TrustCertificate = this.retreiveCertificate();
         this.migrate(_loc1_.id,_loc1_.hash);
      }
      
      private function getCertificateFile() : File {
         var _loc3_:* = true;
         var _loc4_:* = false;
         if(!_loc4_)
         {
            userName = null;
            if(_loc3_)
            {
            }
            try
            {
               if(_loc4_)
               {
               }
               userName = this.getUsername();
               if(_loc3_)
               {
                  if(_loc4_)
                  {
                  }
                  f = this.getCertifFolder(2).resolvePath(MD5.hash(userName));
                  if(_loc4_)
                  {
                  }
                  if(f.exists)
                  {
                     return f;
                  }
               }
               if(!f.exists)
               {
                  if(_loc3_)
                  {
                     if(_loc3_)
                     {
                     }
                     f = this.getCertifFolder(1).resolvePath(MD5.hash(userName));
                     if(_loc3_)
                     {
                     }
                     return f;
                  }
               }
               if(f.exists)
               {
                  return f;
               }
            }
            catch(e:Error)
            {
               if(!_loc4_)
               {
                  if(_loc4_)
                  {
                  }
                  _log.error("Erreur lors de la recherche du certifcat : ");
               }
            }
            return null;
         }
         if(!_loc4_)
         {
            f = null;
            if(_loc4_)
            {
            }
            userName = this.getUsername();
            if(_loc3_)
            {
               if(_loc4_)
               {
               }
               f = this.getCertifFolder(2).resolvePath(MD5.hash(userName));
               if(_loc4_)
               {
               }
               if(f.exists)
               {
                  return f;
               }
               return null;
            }
            if(!f.exists)
            {
               if(_loc3_)
               {
                  if(_loc3_)
                  {
                  }
                  f = this.getCertifFolder(1).resolvePath(MD5.hash(userName));
                  if(_loc3_)
                  {
                  }
                  return f;
               }
            }
            if(f.exists)
            {
               return f;
            }
            return null;
         }
         var f:File = null;
         if(_loc4_)
         {
         }
         var userName:String = this.getUsername();
         if(_loc3_)
         {
            if(_loc4_)
            {
            }
            f = this.getCertifFolder(2).resolvePath(MD5.hash(userName));
            if(_loc4_)
            {
            }
            if(f.exists)
            {
               return f;
            }
            return null;
         }
         if(!f.exists)
         {
            if(_loc3_)
            {
               if(_loc3_)
               {
               }
               f = this.getCertifFolder(1).resolvePath(MD5.hash(userName));
               if(_loc3_)
               {
               }
               return f;
            }
         }
         if(f.exists)
         {
            return f;
         }
         return null;
      }
      
      public function retreiveCertificate() : TrustCertificate {
         var f:File = null;
         var fs:FileStream = null;
         var certif:ShieldCertifcate = null;
         try
         {
            this._hasV1Certif = false;
            f = this.getCertificateFile();
            if(f)
            {
               fs = new FileStream();
               fs.open(f,FileMode.READ);
               certif = ShieldCertifcate.fromRaw(fs);
               fs.close();
               return certif.toNetwork();
            }
         }
         catch(e:Error)
         {
            ErrorManager.addError("Impossible de lire le fichier de certificat.",e);
         }
         return null;
      }
      
      private function onRpcData(param1:RpcEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function migrate(param1:uint, param2:String) : void {
         var _loc4_:* = true;
         var _loc5_:* = false;
         var _loc3_:ShieldCertifcate = new ShieldCertifcate();
         if(_loc4_)
         {
            _loc3_.secureLevel = this.shieldLevel;
            if(_loc4_)
            {
               if(_loc4_)
               {
               }
               this._rpcManager.callMethod(RPC_METHOD_MIGRATE,[this.getUsername(),AuthentificationManager.getInstance().ankamaPortalKey,1,2,param1,param2,_loc3_.hash,_loc3_.reverseHash]);
            }
         }
      }
      
      private function migrationSuccess(param1:Object) : void {
         var _loc3_:* = true;
         var _loc4_:* = false;
         if(_loc3_)
         {
            if(_loc2_.exists)
            {
               if(_loc3_)
               {
               }
               return;
            }
         }
         this.addCertificate(param1.id,param1.certificate);
      }
   }
}
