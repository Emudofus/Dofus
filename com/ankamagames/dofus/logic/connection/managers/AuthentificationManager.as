package com.ankamagames.dofus.logic.connection.managers
{
    import __AS3__.vec.*;
    import by.blooddy.crypto.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.connection.actions.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.connection.*;
    import com.ankamagames.dofus.network.types.secure.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.system.*;
    import com.hurlant.crypto.rsa.*;
    import com.hurlant.util.der.*;
    import flash.utils.*;

    public class AuthentificationManager extends Object implements IDestroyable
    {
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
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthentificationManager));
        private static var _self:AuthentificationManager;

        public function AuthentificationManager()
        {
            this._verifyKey = AuthentificationManager__verifyKey;
            if (_self != null)
            {
                throw new SingletonError("AuthentificationManager is a singleton and should not be instanciated directly.");
            }
            return;
        }// end function

        public function get salt() : String
        {
            return this._salt;
        }// end function

        public function setSalt(param1:String) : void
        {
            this._salt = param1;
            if (this._salt.length < 32)
            {
                _log.warn("Authentification salt size is lower than 32");
                while (this._salt.length < 32)
                {
                    
                    this._salt = this._salt + " ";
                }
            }
            return;
        }// end function

        public function setPublicKey(param1:Vector.<int>) : void
        {
            var _loc_2:* = new ByteArray();
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2.writeByte(param1[_loc_3]);
                _loc_3++;
            }
            _loc_2.position = 0;
            var _loc_4:* = new ByteArray();
            var _loc_5:* = PEM.readRSAPublicKey((new this._verifyKey() as ByteArray).readUTFBytes((new this._verifyKey() as ByteArray).length));
            PEM.readRSAPublicKey((new this._verifyKey() as ByteArray).readUTFBytes((new this._verifyKey() as ByteArray).length)).verify(_loc_2, _loc_4, _loc_2.length);
            this._publicKey = "-----BEGIN PUBLIC KEY-----\n" + Base64.encodeByteArray(_loc_4) + "-----END PUBLIC KEY-----";
            return;
        }// end function

        public function setValidationAction(param1:LoginValidationAction) : void
        {
            this.username = param1.username;
            this._lva = param1;
            this._certificate = SecureModeManager.getInstance().retreiveCertificate();
            ProtectPishingFrame.setPasswordHash(MD5.hash(param1.password.toUpperCase()), param1.password.length);
            return;
        }// end function

        public function get loginValidationAction() : LoginValidationAction
        {
            return this._lva;
        }// end function

        public function get canAutoConnectWithToken() : Boolean
        {
            return this.nextToken != null;
        }// end function

        public function getIdentificationMessage() : IdentificationMessage
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._lva.username.indexOf("|") == -1)
            {
                _loc_1 = new IdentificationMessage();
                if (this._lva is LoginValidationWithTicketAction || this.nextToken)
                {
                    _loc_2 = this.nextToken ? (this.nextToken) : (LoginValidationWithTicketAction(this._lva).ticket);
                    this.nextToken = null;
                    this.ankamaPortalKey = this.cipherMd5String(_loc_2);
                    _loc_1.initIdentificationMessage(_loc_1.version, XmlConfig.getInstance().getEntry("config.lang.current"), this.cipherRsa("   ", _loc_2, this._certificate), this._lva.serverId, this._lva.autoSelectServer, this._certificate != null, true);
                }
                else
                {
                    this.ankamaPortalKey = this.cipherMd5String(this._lva.password);
                    _loc_1.initIdentificationMessage(_loc_1.version, XmlConfig.getInstance().getEntry("config.lang.current"), this.cipherRsa(this._lva.username, this._lva.password, this._certificate), this._lva.serverId, this._lva.autoSelectServer, this._certificate != null, false);
                }
                _loc_1.version.initVersionExtended(BuildInfos.BUILD_VERSION.major, BuildInfos.BUILD_VERSION.minor, BuildInfos.BUILD_VERSION.release, AirScanner.isStreamingVersion() ? (70000) : (BuildInfos.BUILD_REVISION), BuildInfos.BUILD_PATCH, BuildInfos.BUILD_VERSION.buildType, AirScanner.isStreamingVersion() ? (ClientInstallTypeEnum.CLIENT_STREAMING) : (ClientInstallTypeEnum.CLIENT_BUNDLE), AirScanner.hasAir() ? (ClientTechnologyEnum.CLIENT_AIR) : (ClientTechnologyEnum.CLIENT_FLASH));
                return _loc_1;
            }
            else
            {
                this.ankamaPortalKey = this.cipherMd5String(this._lva.password);
                _loc_3 = this._lva.username.split("|");
                _loc_4 = new IdentificationAccountForceMessage();
                new IdentificationAccountForceMessage().initIdentificationAccountForceMessage(_loc_4.version, XmlConfig.getInstance().getEntry("config.lang.current"), this.cipherRsa(_loc_3[0], this._lva.password, this._certificate), this._lva.serverId, this._lva.autoSelectServer, this._certificate != null, false, _loc_3[1]);
            }
            _loc_4.version.initVersionExtended(BuildInfos.BUILD_VERSION.major, BuildInfos.BUILD_VERSION.minor, BuildInfos.BUILD_VERSION.release, BuildInfos.BUILD_REVISION, BuildInfos.BUILD_PATCH, BuildInfos.BUILD_VERSION.buildType, AirScanner.isStreamingVersion() ? (ClientInstallTypeEnum.CLIENT_STREAMING) : (ClientInstallTypeEnum.CLIENT_BUNDLE), AirScanner.hasAir() ? (ClientTechnologyEnum.CLIENT_AIR) : (ClientTechnologyEnum.CLIENT_FLASH));
            return _loc_4;
        }// end function

        public function destroy() : void
        {
            _self = null;
            return;
        }// end function

        private function cipherMd5String(param1:String) : String
        {
            return MD5.hash(param1 + this._salt);
        }// end function

        private function cipherRsa(param1:String, param2:String, param3:TrustCertificate) : Vector.<int>
        {
            var _loc_5:* = null;
            var _loc_8:* = 0;
            var _loc_4:* = new ByteArray();
            if (param3)
            {
                _loc_4.writeUTFBytes(this._salt);
                _loc_4.writeUnsignedInt(param3.id);
                _loc_4.writeUTFBytes(param3.hash);
                _loc_4.writeByte(param1.length);
                _loc_4.writeUTFBytes(param1);
                _loc_4.writeUTFBytes(param2);
            }
            else
            {
                _loc_4.writeUTFBytes(this._salt);
                _loc_4.writeByte(param1.length);
                _loc_4.writeUTFBytes(param1);
                _loc_4.writeUTFBytes(param2);
            }
            _loc_5 = RSA.publicEncrypt(this._publicKey, _loc_4);
            var _loc_6:* = new Vector.<int>;
            _loc_5.position = 0;
            var _loc_7:* = 0;
            while (_loc_5.bytesAvailable != 0)
            {
                
                _loc_8 = _loc_5.readByte();
                _loc_6[_loc_7] = _loc_8;
                _loc_7++;
            }
            return _loc_6;
        }// end function

        public static function getInstance() : AuthentificationManager
        {
            if (_self == null)
            {
                _self = new AuthentificationManager;
            }
            return _self;
        }// end function

    }
}
