package com.ankamagames.dofus.logic.connection.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
   import com.ankamagames.dofus.network.types.secure.TrustCertificate;
   import flash.utils.ByteArray;
   import com.hurlant.util.der.PEM;
   import com.hurlant.crypto.rsa.RSAKey;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   import com.ankamagames.dofus.logic.shield.SecureModeManager;
   import com.ankamagames.dofus.logic.game.common.frames.ProtectPishingFrame;
   import by.blooddy.crypto.MD5;
   import com.ankamagames.dofus.network.messages.connection.IdentificationMessage;
   import com.ankamagames.dofus.network.messages.connection.IdentificationAccountForceMessage;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTicketAction;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.dofus.network.enums.ClientInstallTypeEnum;
   import com.ankamagames.dofus.network.enums.ClientTechnologyEnum;
   import com.ankamagames.jerakine.utils.crypto.RSA;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class AuthentificationManager extends Object implements IDestroyable
   {
      
      public function AuthentificationManager() {
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
      
      public static function getInstance() : AuthentificationManager {
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
      
      public var gameServerTicket:String;
      
      public var ankamaPortalKey:String;
      
      public var username:String;
      
      public var nextToken:String;
      
      public var tokenMode:Boolean = false;
      
      public function get salt() : String {
         return this._salt;
      }
      
      public function setSalt(salt:String) : void {
         this._salt = salt;
         if(this._salt.length < 32)
         {
            _log.warn("Authentification salt size is lower than 32 ");
            while(this._salt.length < 32)
            {
               this._salt = this._salt + " ";
            }
         }
      }
      
      public function setPublicKey(publicKey:Vector.<int>) : void {
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
         readKey.verify(baSignedKey,key,baSignedKey.length);
         this._publicKey = "-----BEGIN PUBLIC KEY-----\n" + Base64.encodeByteArray(key) + "-----END PUBLIC KEY-----";
      }
      
      public function setValidationAction(lva:LoginValidationAction) : void {
         this.username = lva["username"];
         this._lva = lva;
         this._certificate = SecureModeManager.getInstance().retreiveCertificate();
         ProtectPishingFrame.setPasswordHash(MD5.hash(lva.password.toUpperCase()),lva.password.length);
      }
      
      public function get loginValidationAction() : LoginValidationAction {
         return this._lva;
      }
      
      public function get canAutoConnectWithToken() : Boolean {
         return !(this.nextToken == null);
      }
      
      public function getIdentificationMessage() : IdentificationMessage {
         var imsg:IdentificationMessage = null;
         var token:String = null;
         var login:Array = null;
         var iafmsg:IdentificationAccountForceMessage = null;
         if(this._lva.username.indexOf("|") == -1)
         {
            imsg = new IdentificationMessage();
            if((this._lva is LoginValidationWithTicketAction) || (this.nextToken))
            {
               token = this.nextToken?this.nextToken:LoginValidationWithTicketAction(this._lva).ticket;
               this.nextToken = null;
               this.ankamaPortalKey = this.cipherMd5String(token);
               imsg.initIdentificationMessage(imsg.version,XmlConfig.getInstance().getEntry("config.lang.current"),this.cipherRsa("   ",token,this._certificate),this._lva.serverId,this._lva.autoSelectServer,!(this._certificate == null),true);
            }
            else
            {
               this.ankamaPortalKey = this.cipherMd5String(this._lva.password);
               imsg.initIdentificationMessage(imsg.version,XmlConfig.getInstance().getEntry("config.lang.current"),this.cipherRsa(this._lva.username,this._lva.password,this._certificate),this._lva.serverId,this._lva.autoSelectServer,!(this._certificate == null),false);
            }
            imsg.version.initVersionExtended(BuildInfos.BUILD_VERSION.major,BuildInfos.BUILD_VERSION.minor,BuildInfos.BUILD_VERSION.release,BuildInfos.BUILD_REVISION,BuildInfos.BUILD_PATCH,BuildInfos.BUILD_VERSION.buildType,AirScanner.isStreamingVersion()?ClientInstallTypeEnum.CLIENT_STREAMING:ClientInstallTypeEnum.CLIENT_BUNDLE,AirScanner.hasAir()?ClientTechnologyEnum.CLIENT_AIR:ClientTechnologyEnum.CLIENT_FLASH);
            return imsg;
         }
         this.ankamaPortalKey = this.cipherMd5String(this._lva.password);
         login = this._lva.username.split("|");
         iafmsg = new IdentificationAccountForceMessage();
         iafmsg.initIdentificationAccountForceMessage(iafmsg.version,XmlConfig.getInstance().getEntry("config.lang.current"),this.cipherRsa(login[0],this._lva.password,this._certificate),this._lva.serverId,this._lva.autoSelectServer,!(this._certificate == null),false,0,login[1]);
         iafmsg.version.initVersionExtended(BuildInfos.BUILD_VERSION.major,BuildInfos.BUILD_VERSION.minor,BuildInfos.BUILD_VERSION.release,BuildInfos.BUILD_REVISION,BuildInfos.BUILD_PATCH,BuildInfos.BUILD_VERSION.buildType,AirScanner.isStreamingVersion()?ClientInstallTypeEnum.CLIENT_STREAMING:ClientInstallTypeEnum.CLIENT_BUNDLE,AirScanner.hasAir()?ClientTechnologyEnum.CLIENT_AIR:ClientTechnologyEnum.CLIENT_FLASH);
         return iafmsg;
      }
      
      public function destroy() : void {
         _self = null;
      }
      
      private function cipherMd5String(pwd:String) : String {
         var _loc3_:* = false;
         return MD5.hash(pwd + this._salt);
      }
      
      private function cipherRsa(login:String, pwd:String, certificate:TrustCertificate) : Vector.<int> {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
