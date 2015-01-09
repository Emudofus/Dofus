package com.ankamagames.dofus.logic.connection.managers
{
    import com.ankamagames.jerakine.interfaces.IDestroyable;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
    import com.ankamagames.dofus.network.types.secure.TrustCertificate;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import flash.utils.ByteArray;
    import com.hurlant.crypto.rsa.RSAKey;
    import com.hurlant.util.der.PEM;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.jerakine.utils.crypto.Base64;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.shield.SecureModeManager;
    import com.ankamagames.dofus.logic.game.common.frames.ProtectPishingFrame;
    import by.blooddy.crypto.MD5;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTicketAction;
    import com.ankamagames.dofus.network.messages.connection.IdentificationMessage;
    import com.ankamagames.dofus.network.messages.connection.IdentificationAccountForceMessage;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.dofus.network.enums.ClientInstallTypeEnum;
    import com.ankamagames.dofus.network.enums.ClientTechnologyEnum;
    import com.ankamagames.jerakine.utils.crypto.RSA;
    import __AS3__.vec.*;

    public class AuthentificationManager implements IDestroyable 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthentificationManager));
        private static var _self:AuthentificationManager;

        private var commonMod:Object;
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

        public function AuthentificationManager()
        {
            this.commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            this._verifyKey = AuthentificationManager__verifyKey;
            super();
            if (_self != null)
            {
                throw (new SingletonError("AuthentificationManager is a singleton and should not be instanciated directly."));
            };
        }

        public static function getInstance():AuthentificationManager
        {
            if (_self == null)
            {
                _self = new (AuthentificationManager)();
            };
            return (_self);
        }


        public function get gameServerTicket():String
        {
            return (this._gameServerTicket);
        }

        public function set gameServerTicket(value:String):void
        {
            this._gameServerTicket = value;
        }

        public function get salt():String
        {
            return (this._salt);
        }

        public function setSalt(salt:String):void
        {
            this._salt = salt;
            if (this._salt.length < 32)
            {
                _log.warn("Authentification salt size is lower than 32 ");
                while (this._salt.length < 32)
                {
                    this._salt = (this._salt + " ");
                };
            };
        }

        public function setPublicKey(publicKey:Vector.<int>):void
        {
            var baSignedKey:ByteArray = new ByteArray();
            var i:int;
            while (i < publicKey.length)
            {
                baSignedKey.writeByte(publicKey[i]);
                i = (i + 1);
            };
            baSignedKey.position = 0;
            var key:ByteArray = new ByteArray();
            var readKey:RSAKey = PEM.readRSAPublicKey((new this._verifyKey() as ByteArray).readUTFBytes((new this._verifyKey() as ByteArray).length));
            try
            {
                readKey.verify(baSignedKey, key, baSignedKey.length);
            }
            catch(e:Error)
            {
                commonMod.openPopup(I18n.getUiText("ui.common.error"), "Il est impossible d'authentifier le serveur (ted)", [I18n.getUiText("ui.common.ok")]);
                return;
            };
            this._publicKey = (("-----BEGIN PUBLIC KEY-----\n" + Base64.encodeByteArray(key)) + "-----END PUBLIC KEY-----");
        }

        public function setValidationAction(lva:LoginValidationAction):void
        {
            this.username = lva["username"];
            this._lva = lva;
            this._certificate = SecureModeManager.getInstance().retreiveCertificate();
            ProtectPishingFrame.setPasswordHash(MD5.hash(lva.password.toUpperCase()), lva.password.length);
        }

        public function get loginValidationAction():LoginValidationAction
        {
            return (this._lva);
        }

        public function get canAutoConnectWithToken():Boolean
        {
            return (!((this.nextToken == null)));
        }

        public function get isLoggingWithTicket():Boolean
        {
            return ((this._lva is LoginValidationWithTicketAction));
        }

        public function getIdentificationMessage():IdentificationMessage
        {
            var imsg:IdentificationMessage;
            var token:String;
            var _local_4:Array;
            var _local_5:IdentificationAccountForceMessage;
            var buildType:uint = BuildInfos.BUILD_VERSION.buildType;
            if (((AirScanner.isStreamingVersion()) && ((BuildInfos.BUILD_VERSION.buildType == BuildTypeEnum.BETA))))
            {
                buildType = BuildTypeEnum.RELEASE;
            };
            if (this._lva.username.indexOf("|") == -1)
            {
                imsg = new IdentificationMessage();
                if ((((this._lva is LoginValidationWithTicketAction)) || (this.nextToken)))
                {
                    token = ((this.nextToken) ? this.nextToken : LoginValidationWithTicketAction(this._lva).ticket);
                    this.nextToken = null;
                    this.ankamaPortalKey = this.cipherMd5String(token);
                    imsg.initIdentificationMessage(imsg.version, XmlConfig.getInstance().getEntry("config.lang.current"), this.cipherRsa("   ", token, this._certificate), this._lva.serverId, this._lva.autoSelectServer, !((this._certificate == null)), true);
                }
                else
                {
                    this.ankamaPortalKey = this.cipherMd5String(this._lva.password);
                    imsg.initIdentificationMessage(imsg.version, XmlConfig.getInstance().getEntry("config.lang.current"), this.cipherRsa(this._lva.username, this._lva.password, this._certificate), this._lva.serverId, this._lva.autoSelectServer, !((this._certificate == null)), false);
                };
                imsg.version.initVersionExtended(BuildInfos.BUILD_VERSION.major, BuildInfos.BUILD_VERSION.minor, BuildInfos.BUILD_VERSION.release, BuildInfos.BUILD_REVISION, BuildInfos.BUILD_PATCH, buildType, ((AirScanner.isStreamingVersion()) ? ClientInstallTypeEnum.CLIENT_STREAMING : (ClientInstallTypeEnum.CLIENT_BUNDLE)), ((AirScanner.hasAir()) ? ClientTechnologyEnum.CLIENT_AIR : ClientTechnologyEnum.CLIENT_FLASH));
                return (imsg);
            };
            this.ankamaPortalKey = this.cipherMd5String(this._lva.password);
            _local_4 = this._lva.username.split("|");
            _local_5 = new IdentificationAccountForceMessage();
            _local_5.initIdentificationAccountForceMessage(_local_5.version, XmlConfig.getInstance().getEntry("config.lang.current"), this.cipherRsa(_local_4[0], this._lva.password, this._certificate), this._lva.serverId, this._lva.autoSelectServer, !((this._certificate == null)), false, 0, _local_4[1]);
            _local_5.version.initVersionExtended(BuildInfos.BUILD_VERSION.major, BuildInfos.BUILD_VERSION.minor, BuildInfos.BUILD_VERSION.release, BuildInfos.BUILD_REVISION, BuildInfos.BUILD_PATCH, buildType, ((AirScanner.isStreamingVersion()) ? ClientInstallTypeEnum.CLIENT_STREAMING : (ClientInstallTypeEnum.CLIENT_BUNDLE)), ((AirScanner.hasAir()) ? ClientTechnologyEnum.CLIENT_AIR : ClientTechnologyEnum.CLIENT_FLASH));
            return (_local_5);
        }

        public function destroy():void
        {
            _self = null;
        }

        private function cipherMd5String(pwd:String):String
        {
            return (MD5.hash((pwd + this._salt)));
        }

        private function cipherRsa(login:String, pwd:String, certificate:TrustCertificate):Vector.<int>
        {
            var baOut:ByteArray;
            var n:int;
            while (true)
            {
                goto _label_2;
                
            _label_1: 
                goto _label_3;
            };
            var _local_9 = _local_9;
            
        _label_2: 
            goto _label_1;
            
        _label_3: 
            var baIn:ByteArray = new ByteArray();
            if (certificate)
            {
                baIn.writeUTFBytes(this._salt);
                for (;;)
                {
                    baIn.writeUTFBytes(pwd);
                    //unresolved jump
                    
                _label_4: 
                    baIn.writeByte(login.length);
                    //unresolved jump
                    
                _label_5: 
                    baIn.writeUnsignedInt(certificate.id);
                    goto _label_6;
                    goto _label_5;
                    var _local_10 = _local_10;
                    
                _label_6: 
                    goto _label_8;
                    
                _label_7: 
                    baIn.writeUTFBytes(login);
                    continue;
                };
                
            _label_8: 
                baIn.writeUTFBytes(certificate.hash);
                goto _label_4;
            }
            else
            {
                baIn.writeUTFBytes(this._salt);
                goto _label_12;
                
            _label_9: 
                goto _label_11;
                
            _label_10: 
                baIn.writeByte(login.length);
                goto _label_13;
            };
            
        _label_11: 
            baOut = RSA.publicEncrypt(this._publicKey, baIn);
            goto _label_14;
            
        _label_12: 
            goto _label_10;
            
        _label_13: 
            baIn.writeUTFBytes(login);
            while (true)
            {
                baIn.writeUTFBytes(pwd);
                goto _label_9;
            };
            
        _label_14: 
            var ret:Vector.<int> = new Vector.<int>();
            baOut.position = 0;
            var i:int;
            while (baOut.bytesAvailable != 0)
            {
                goto _label_18;
                
            _label_15: 
                continue;
                
            _label_16: 
                ret[i] = n;
                //unresolved jump
                while ((n = baOut.readByte()), goto _label_17, (_local_9 = _local_9), true)
                {
                    i++;
                    goto _label_15;
                    
                _label_17: 
                    goto _label_16;
                    
                _label_18: 
                    continue;
                };
            };
            return (ret);
        }


    }
}//package com.ankamagames.dofus.logic.connection.managers

