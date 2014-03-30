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
      
      public function set active(b:Boolean) : void {
         this._active = b;
         KernelEventsManager.getInstance().processCallback(HookList.SecureModeChange,b);
      }
      
      public function get computerName() : String {
         return this._computerName;
      }
      
      public function set computerName(name:String) : void {
         this._computerName = name;
      }
      
      public function get certificate() : TrustCertificate {
         return this.retreiveCertificate();
      }
      
      public var shieldLevel:uint;
      
      public function askCode(callback:Function) : void {
         this._methodsCallback[RPC_METHOD_SECURITY_CODE] = callback;
         this._rpcManager.callMethod(RPC_METHOD_SECURITY_CODE,[this.getUsername(),AuthentificationManager.getInstance().ankamaPortalKey,1]);
      }
      
      public function sendCode(code:String, callback:Function) : void {
         var fooCertif:ShieldCertifcate = new ShieldCertifcate();
         fooCertif.secureLevel = this.shieldLevel;
         this._methodsCallback[RPC_METHOD_VALIDATE_CODE] = callback;
         this._rpcManager.callMethod(RPC_METHOD_VALIDATE_CODE,[this.getUsername(),AuthentificationManager.getInstance().ankamaPortalKey,1,code.toUpperCase(),fooCertif.hash,fooCertif.reverseHash,this._computerName?true:false,this._computerName?this._computerName:""]);
      }
      
      private function initRPC() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
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
      
      private function parseRpcValidateResponse(response:Object, method:String) : Object {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function parseRpcASkCodeResponse(response:Object, method:String) : Object {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function getCertifFolder(version:uint) : File {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function addCertificate(id:uint, content:String, secureLevel:uint=2) : Boolean {
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
         var certif:TrustCertificate = this.retreiveCertificate();
         this.migrate(certif.id,certif.hash);
      }
      
      private function getCertificateFile() : File {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
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
      
      private function onRpcData(e:RpcEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function migrate(iCertificateId:uint, oldCertif:String) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function migrationSuccess(result:Object) : void {
         var f:File = this.getCertificateFile();
         if(!_loc4_)
         {
            if(f.exists)
            {
               if(_loc3_)
               {
                  if(_loc4_)
                  {
                     while(_loc4_)
                     {
                        break;
                     }
                     return;
                  }
               }
            }
            while(true)
            {
               this.addCertificate(result.id,result.certificate);
            }
         }
         while(true)
         {
            if(!_loc4_)
            {
               if(_loc4_)
               {
                  this.addCertificate(result.id,result.certificate);
                  continue;
               }
            }
            return;
         }
      }
   }
}
