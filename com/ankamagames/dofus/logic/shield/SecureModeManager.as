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
      
      protected static const _log:Logger;
      
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
         var _loc1_:* = false;
         var _loc2_:* = true;
         if((BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.INTERNAL) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.TESTING))
         {
            RPC_URL = "http://api.ankama.lan/ankama/shield.json";
         }
         else
         {
            RPC_URL = "https://api.ankama.com/ankama/shield.json";
         }
         this._rpcManager = new RpcServiceManager(RPC_URL,"json");
         this._rpcManager.addEventListener(RpcEvent.EVENT_DATA,this.onRpcData);
         this._rpcManager.addEventListener(RpcEvent.EVENT_ERROR,this.onRpcData);
      }
      
      private function getUsername() : String {
         var _loc1_:* = true;
         var _loc2_:* = false;
         return AuthentificationManager.getInstance().username.toLowerCase().split("|")[0];
      }
      
      private function parseRpcValidateResponse(response:Object, method:String) : Object {
         var _loc6_:* = false;
         var _loc7_:* = true;
         var success:* = false;
         var result:Object = new Object();
         result.error = response.error;
         result.fatal = false;
         result.retry = false;
         result.text = "";
         switch(response.error)
         {
            case VALIDATECODE_CODEEXPIRE:
               result.text = I18n.getUiText("ui.secureMode.error.checkCode.expire");
               result.fatal = true;
               break;
            case VALIDATECODE_CODEBADCODE:
               result.text = I18n.getUiText("ui.secureMode.error.checkCode.403");
               result.retry = true;
               break;
            case VALIDATECODE_CODENOTFOUND:
               result.text = I18n.getUiText("ui.secureMode.error.checkCode.404") + " (1)";
               result.fatal = true;
               break;
            case VALIDATECODE_SECURITY:
               result.text = I18n.getUiText("ui.secureMode.error.checkCode.security");
               result.fatal = true;
               break;
            case VALIDATECODE_TOOMANYCERTIFICATE:
               result.text = I18n.getUiText("ui.secureMode.error.checkCode.413");
               result.fatal = true;
               break;
            case VALIDATECODE_NOTAVAILABLE:
               result.text = I18n.getUiText("ui.secureMode.error.checkCode.202");
               result.fatal = true;
               break;
            case ACCOUNT_AUTHENTIFICATION_FAILED:
               result.text = I18n.getUiText("ui.secureMode.error.checkCode.404") + " (2)";
               result.fatal = true;
               break;
            default:
               result.text = response.error;
               result.fatal = true;
         }
         if((response.certificate) && (response.id))
         {
            success = this.addCertificate(response.id,response.certificate,this.shieldLevel);
            if(!success)
            {
               result.text = I18n.getUiText("ui.secureMode.error.checkCode.202.fatal");
               result.fatal = true;
            }
         }
         return result;
      }
      
      private function parseRpcASkCodeResponse(response:Object, method:String) : Object {
         var _loc5_:* = false;
         var _loc6_:* = true;
         var result:Object = new Object();
         result.error = !result.error;
         result.fatal = false;
         result.retry = false;
         result.text = "";
         if(!response.error)
         {
            result.domain = response.domain;
            result.error = false;
         }
         if(!response.error)
         {
            return result;
         }
         return result;
      }
      
      private function getCertifFolder(version:uint) : File {
         var _loc5_:* = true;
         var _loc6_:* = false;
         var f:File = null;
         var tmp:Array = File.applicationStorageDirectory.nativePath.split(File.separator);
         tmp.pop();
         tmp.pop();
         var parentDir:String = tmp.join(File.separator);
         if(version == 1)
         {
            f = new File(parentDir + File.separator + "AnkamaCertificates/");
         }
         if(version == 2)
         {
            f = new File(parentDir + File.separator + "AnkamaCertificates/v2-RELEASE");
         }
         f.createDirectory();
         return f;
      }
      
      private function addCertificate(id:uint, content:String, secureLevel:uint = 2) : Boolean {
         var _loc6_:* = false;
         var _loc7_:* = true;
         var f:File = null;
         var fs:FileStream = null;
         var cert:ShieldCertifcate = null;
         try
         {
            f = this.getCertifFolder(2);
            f = f.resolvePath(MD5.hash(this.getUsername()));
            fs = new FileStream();
            fs.open(f,FileMode.WRITE);
            cert = new ShieldCertifcate();
            cert.id = id;
            cert.version = 3;
            cert.content = content;
            cert.secureLevel = secureLevel;
            fs.writeBytes(cert.serialize());
            fs.close();
            return true;
         }
         catch(e:Error)
         {
            if(!_loc6_)
            {
               ErrorManager.addError("Impossible de créer le fichier de certificat.",e);
            }
         }
         return false;
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
         var _loc3_:* = true;
         var _loc4_:* = false;
         var userName:String = null;
         var f:File = null;
         try
         {
            userName = this.getUsername();
            f = this.getCertifFolder(2).resolvePath(MD5.hash(userName));
            if(!f.exists)
            {
               f = this.getCertifFolder(1).resolvePath(MD5.hash(userName));
            }
            if(f.exists)
            {
               return f;
            }
         }
         catch(e:Error)
         {
            if(_loc3_)
            {
               if(_loc3_)
               {
               }
               _log.error("Erreur lors de la recherche du certifcat : ");
            }
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
      
      private function onRpcData(e:RpcEvent) : void {
         var _loc3_:* = true;
         var _loc4_:* = false;
         if((e.type == RpcEvent.EVENT_ERROR) && (!e.result))
         {
            this._methodsCallback[e.method](
               {
                  "error":true,
                  "fatal":true,
                  "text":I18n.getUiText("ui.secureMode.error.checkCode.503")
               });
            return;
         }
         if(e.method == RPC_METHOD_SECURITY_CODE)
         {
            this._methodsCallback[e.method](this.parseRpcASkCodeResponse(e.result,e.method));
         }
         if(e.method == RPC_METHOD_VALIDATE_CODE)
         {
            this._methodsCallback[e.method](this.parseRpcValidateResponse(e.result,e.method));
         }
         if(e.method == RPC_METHOD_MIGRATE)
         {
            if(e.result.success)
            {
               this.migrationSuccess(e.result);
            }
            else
            {
               _log.error("Impossible de migrer le certificat : " + e.result.error);
            }
         }
      }
      
      private function migrate(iCertificateId:uint, oldCertif:String) : void {
         var _loc4_:* = false;
         var _loc5_:* = true;
         var fooCertif:ShieldCertifcate = new ShieldCertifcate();
         fooCertif.secureLevel = this.shieldLevel;
         this._rpcManager.callMethod(RPC_METHOD_MIGRATE,[this.getUsername(),AuthentificationManager.getInstance().ankamaPortalKey,1,2,iCertificateId,oldCertif,fooCertif.hash,fooCertif.reverseHash]);
      }
      
      private function migrationSuccess(result:Object) : void {
         var _loc3_:* = false;
         var _loc4_:* = true;
         var f:File = this.getCertificateFile();
         if(f.exists)
         {
         }
         this.addCertificate(result.id,result.certificate);
      }
   }
}
