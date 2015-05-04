package com.ankamagames.dofus.logic.connection.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
   import com.ankamagames.dofus.network.types.secure.TrustCertificate;
   import flash.utils.ByteArray;
   import com.hurlant.crypto.rsa.RSAKey;
   import com.hurlant.util.der.PEM;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   import com.ankamagames.dofus.logic.shield.SecureModeManager;
   import com.ankamagames.dofus.logic.game.common.frames.ProtectPishingFrame;
   import by.blooddy.crypto.MD5;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTicketAction;
   import com.ankamagames.dofus.network.messages.connection.IdentificationMessage;
   import com.ankamagames.dofus.network.messages.connection.IdentificationAccountForceMessage;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.network.enums.ClientInstallTypeEnum;
   import com.ankamagames.dofus.network.enums.ClientTechnologyEnum;
   import com.ankamagames.jerakine.utils.crypto.RSA;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class AuthentificationManager extends Object implements IDestroyable
   {
      
      public function AuthentificationManager()
      {
         this._verifyKey = AuthentificationManager__verifyKey;
         super();
         if(_self != null)
         {
            throw new SingletonError("AuthentificationManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthentificationManager));
      
      private static var _self:AuthentificationManager;
      
      public static function getInstance() : AuthentificationManager
      {
         if(_self == null)
         {
            _self = new AuthentificationManager();
         }
         return _self;
      }
      
      private var _publicKey:String;
      
      private var _salt:String;
      
      private var _lva:LoginValidationAction;
      
      private var _certificate:TrustCertificate;
      
      private var _verifyKey:Class;
      
      private var _gameServerTicket:String;
      
      public var ankamaPortalKey:String;
      
      public var username:String;
      
      public var nextToken:String;
      
      public var tokenMode:Boolean = false;
      
      public function get gameServerTicket() : String
      {
         return this._gameServerTicket;
      }
      
      public function set gameServerTicket(param1:String) : void
      {
         this._gameServerTicket = param1;
      }
      
      public function get salt() : String
      {
         return this._salt;
      }
      
      public function setSalt(param1:String) : void
      {
         this._salt = param1;
         if(this._salt.length < 32)
         {
            _log.warn("Authentification salt size is lower than 32 ");
            while(this._salt.length < 32)
            {
               this._salt = this._salt + " ";
            }
         }
      }
      
      public function setPublicKey(param1:Vector.<int>) : void
      {
         var commonMod:Object = null;
         var publicKey:Vector.<int> = param1;
         var baSignedKey:ByteArray = new ByteArray();
         var i:int = 0;
         while(i < publicKey.length)
         {
            baSignedKey.writeByte(publicKey[i]);
            i++;
         }
         baSignedKey.position = 0;
         var key:ByteArray = new ByteArray();
         var readKey:RSAKey = PEM.readRSAPublicKey((new this._verifyKey() as ByteArray).readUTFBytes((new this._verifyKey() as ByteArray).length));
         try
         {
            readKey.verify(baSignedKey,key,baSignedKey.length);
         }
         catch(e:Error)
         {
            commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            commonMod.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.server.authentificationImpossible"),[I18n.getUiText("ui.common.ok")]);
            return;
         }
         this._publicKey = "-----BEGIN PUBLIC KEY-----\n" + Base64.encodeByteArray(key) + "-----END PUBLIC KEY-----";
      }
      
      public function setValidationAction(param1:LoginValidationAction) : void
      {
         this.username = param1["username"];
         this._lva = param1;
         this._certificate = SecureModeManager.getInstance().retreiveCertificate();
         ProtectPishingFrame.setPasswordHash(MD5.hash(param1.password.toUpperCase()),param1.password.length);
      }
      
      public function get loginValidationAction() : LoginValidationAction
      {
         return this._lva;
      }
      
      public function get canAutoConnectWithToken() : Boolean
      {
         return !(this.nextToken == null);
      }
      
      public function get isLoggingWithTicket() : Boolean
      {
         return this._lva is LoginValidationWithTicketAction;
      }
      
      public function getIdentificationMessage() : IdentificationMessage
      {
         var _loc2_:IdentificationMessage = null;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:IdentificationAccountForceMessage = null;
         var _loc1_:uint = BuildInfos.BUILD_VERSION.buildType;
         if((AirScanner.isStreamingVersion()) && BuildInfos.BUILD_VERSION.buildType == BuildTypeEnum.BETA)
         {
            _loc1_ = BuildTypeEnum.RELEASE;
         }
         if(this._lva.username.indexOf("|") == -1)
         {
            _loc2_ = new IdentificationMessage();
            if(this._lva is LoginValidationWithTicketAction || (this.nextToken))
            {
               _loc3_ = this.nextToken?this.nextToken:LoginValidationWithTicketAction(this._lva).ticket;
               this.nextToken = null;
               this.ankamaPortalKey = this.cipherMd5String(_loc3_);
               _loc2_.initIdentificationMessage(_loc2_.version,XmlConfig.getInstance().getEntry("config.lang.current"),this.cipherRsa("   ",_loc3_,this._certificate),this._lva.serverId,this._lva.autoSelectServer,!(this._certificate == null),true);
            }
            else
            {
               this.ankamaPortalKey = this.cipherMd5String(this._lva.password);
               _loc2_.initIdentificationMessage(_loc2_.version,XmlConfig.getInstance().getEntry("config.lang.current"),this.cipherRsa(this._lva.username,this._lva.password,this._certificate),this._lva.serverId,this._lva.autoSelectServer,!(this._certificate == null),false);
            }
            _loc2_.version.initVersionExtended(BuildInfos.BUILD_VERSION.major,BuildInfos.BUILD_VERSION.minor,BuildInfos.BUILD_VERSION.release,BuildInfos.BUILD_REVISION,BuildInfos.BUILD_PATCH,_loc1_,AirScanner.isStreamingVersion()?ClientInstallTypeEnum.CLIENT_STREAMING:ClientInstallTypeEnum.CLIENT_BUNDLE,AirScanner.hasAir()?ClientTechnologyEnum.CLIENT_AIR:ClientTechnologyEnum.CLIENT_FLASH);
            return _loc2_;
         }
         this.ankamaPortalKey = this.cipherMd5String(this._lva.password);
         _loc4_ = this._lva.username.split("|");
         _loc5_ = new IdentificationAccountForceMessage();
         _loc5_.initIdentificationAccountForceMessage(_loc5_.version,XmlConfig.getInstance().getEntry("config.lang.current"),this.cipherRsa(_loc4_[0],this._lva.password,this._certificate),this._lva.serverId,this._lva.autoSelectServer,!(this._certificate == null),false,0,null,_loc4_[1]);
         _loc5_.version.initVersionExtended(BuildInfos.BUILD_VERSION.major,BuildInfos.BUILD_VERSION.minor,BuildInfos.BUILD_VERSION.release,BuildInfos.BUILD_REVISION,BuildInfos.BUILD_PATCH,_loc1_,AirScanner.isStreamingVersion()?ClientInstallTypeEnum.CLIENT_STREAMING:ClientInstallTypeEnum.CLIENT_BUNDLE,AirScanner.hasAir()?ClientTechnologyEnum.CLIENT_AIR:ClientTechnologyEnum.CLIENT_FLASH);
         return _loc5_;
      }
      
      public function destroy() : void
      {
         _self = null;
      }
      
      private function cipherMd5String(param1:String) : String
      {
         var _loc2_:* = false;
         var _loc3_:* = true;
         return MD5.hash(param1 + this._salt);
      }
      
      private function cipherRsa(param1:String, param2:String, param3:TrustCertificate) : Vector.<int>
      {
         /*
          * Erreur de décompilation
          * Le code est probablement obsfusqué
          * Astuce : Vous pouvez tenter d'activer la "désobfuscation automatique" dans les paramètres
          * Type d'erreur: TranslateException
          */
         throw new flash.errors.IllegalOperationError("Non décompilé car il y a des erreurs");
      }
   }
}
