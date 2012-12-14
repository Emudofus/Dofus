package com.ankamagames.dofus.logic.common.managers
{
    import by.blooddy.crypto.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.logic.connection.managers.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.secure.*;
    import com.ankamagames.dofus.types.events.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.system.*;
    import com.hurlant.crypto.symmetric.*;
    import flash.filesystem.*;
    import flash.system.*;
    import flash.utils.*;

    public class SecureModeManager extends Object
    {
        private var _timeout:Timer;
        private var _active:Boolean;
        private var _computerName:String;
        private var _methodsCallback:Dictionary;
        private var _hasV1Certif:Boolean;
        private var _rpcManager:RpcServiceManager;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SecureModeManager));
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

        public function SecureModeManager()
        {
            this._timeout = new Timer(30000);
            this._methodsCallback = new Dictionary();
            if (_self)
            {
                throw new SingletonError();
            }
            this.initRPC();
            return;
        }// end function

        public function get active() : Boolean
        {
            return this._active;
        }// end function

        public function set active(param1:Boolean) : void
        {
            this._active = param1;
            KernelEventsManager.getInstance().processCallback(HookList.SecureModeChange, param1);
            return;
        }// end function

        public function get computerName() : String
        {
            return this._computerName;
        }// end function

        public function set computerName(param1:String) : void
        {
            this._computerName = param1;
            return;
        }// end function

        public function get certificate() : TrustCertificate
        {
            return this.retreiveCertificate();
        }// end function

        public function askCode(param1:Function) : void
        {
            this._methodsCallback[RPC_METHOD_SECURITY_CODE] = param1;
            this._rpcManager.callMethod(RPC_METHOD_SECURITY_CODE, [this.getUsername(), AuthentificationManager.getInstance().ankamaPortalKey, 1]);
            return;
        }// end function

        public function sendCode(param1:String, param2:Function) : void
        {
            this._methodsCallback[RPC_METHOD_VALIDATE_CODE] = param2;
            this._rpcManager.callMethod(RPC_METHOD_VALIDATE_CODE, [this.getUsername(), AuthentificationManager.getInstance().ankamaPortalKey, 1, param1.toUpperCase(), this.getH(), this.getH(true), this._computerName ? (true) : (false), this._computerName ? (this._computerName) : ("")]);
            return;
        }// end function

        private function initRPC() : void
        {
            if (BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG || BuildInfos.BUILD_TYPE == BuildTypeEnum.INTERNAL || BuildInfos.BUILD_TYPE == BuildTypeEnum.TESTING)
            {
                RPC_URL = "http://api.ankama.lan/ankama/shield.json";
            }
            else
            {
                RPC_URL = "https://api.ankama.com/ankama/shield.json";
            }
            this._rpcManager = new RpcServiceManager(RPC_URL, "json");
            this._rpcManager.addEventListener(RpcEvent.EVENT_DATA, this.onRpcData);
            this._rpcManager.addEventListener(RpcEvent.EVENT_ERROR, this.onRpcData);
            return;
        }// end function

        private function getUsername() : String
        {
            return AuthentificationManager.getInstance().username.toLowerCase().split("|")[0];
        }// end function

        private function parseRpcValidateResponse(param1:Object, param2:String) : Object
        {
            var _loc_4:* = false;
            var _loc_3:* = new Object();
            _loc_3.error = param1.error;
            _loc_3.fatal = false;
            _loc_3.retry = false;
            _loc_3.text = "";
            switch(param1.error)
            {
                case VALIDATECODE_CODEEXPIRE:
                {
                    _loc_3.text = I18n.getUiText("ui.secureMode.error.checkCode.expire");
                    _loc_3.fatal = true;
                    break;
                }
                case VALIDATECODE_CODEBADCODE:
                {
                    _loc_3.text = I18n.getUiText("ui.secureMode.error.checkCode.403");
                    _loc_3.retry = true;
                    break;
                }
                case VALIDATECODE_CODENOTFOUND:
                {
                    _loc_3.text = I18n.getUiText("ui.secureMode.error.checkCode.404") + " (1)";
                    _loc_3.fatal = true;
                    break;
                }
                case VALIDATECODE_SECURITY:
                {
                    _loc_3.text = I18n.getUiText("ui.secureMode.error.checkCode.security");
                    _loc_3.fatal = true;
                    break;
                }
                case VALIDATECODE_TOOMANYCERTIFICATE:
                {
                    _loc_3.text = I18n.getUiText("ui.secureMode.error.checkCode.413");
                    _loc_3.fatal = true;
                    break;
                }
                case VALIDATECODE_NOTAVAILABLE:
                {
                    _loc_3.text = I18n.getUiText("ui.secureMode.error.checkCode.202");
                    _loc_3.fatal = true;
                    break;
                }
                case ACCOUNT_AUTHENTIFICATION_FAILED:
                {
                    _loc_3.text = I18n.getUiText("ui.secureMode.error.checkCode.404") + " (2)";
                    _loc_3.fatal = true;
                    break;
                }
                default:
                {
                    _loc_3.text = param1.error;
                    _loc_3.fatal = true;
                    break;
                }
            }
            if (param1.certificate && param1.id)
            {
                _loc_4 = this.addCertificate(param1.id, param1.certificate);
                if (!_loc_4)
                {
                    _loc_3.text = I18n.getUiText("ui.secureMode.error.checkCode.202.fatal");
                    _loc_3.fatal = true;
                }
            }
            return _loc_3;
        }// end function

        private function parseRpcASkCodeResponse(param1:Object, param2:String) : Object
        {
            var _loc_3:* = new Object();
            _loc_3.error = !_loc_3.error;
            _loc_3.fatal = false;
            _loc_3.retry = false;
            _loc_3.text = "";
            if (!param1.error)
            {
                _loc_3.domain = param1.domain;
                _loc_3.error = false;
            }
            else
            {
                switch(param1.error)
                {
                    case VALIDATECODE_CODEEXPIRE:
                    {
                        _loc_3.text = I18n.getUiText("ui.secureMode.error.checkCode.expire");
                        _loc_3.fatal = true;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return _loc_3;
        }// end function

        private function getCertifFolder(param1:uint) : File
        {
            var _loc_4:* = null;
            var _loc_2:* = File.applicationStorageDirectory.nativePath.split(File.separator);
            _loc_2.pop();
            _loc_2.pop();
            var _loc_3:* = _loc_2.join(File.separator);
            if (param1 == 1)
            {
                _loc_4 = new File(_loc_3 + File.separator + "AnkamaCertificates/");
            }
            if (param1 == 2)
            {
                _loc_4 = new File(_loc_3 + File.separator + "AnkamaCertificates/v2-" + BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE) + "/");
            }
            _loc_4.createDirectory();
            return _loc_4;
        }// end function

        private function addCertificate(param1:uint, param2:String) : Boolean
        {
            var f:File;
            var fs:FileStream;
            var id:* = param1;
            var content:* = param2;
            try
            {
                f = this.getCertifFolder(2);
                f = f.resolvePath(MD5.hash(this.getUsername()));
                fs = new FileStream();
                fs.open(f, FileMode.WRITE);
                fs.writeUTFBytes("SV2");
                fs.writeUnsignedInt(id);
                fs.writeUTFBytes(content);
                fs.close();
                return true;
            }
            catch (e:Error)
            {
                ErrorManager.addError("Impossible de créer le fichier de certificat.", e);
            }
            return false;
        }// end function

        public function checkMigrate() : void
        {
            if (!this._hasV1Certif)
            {
                return;
            }
            var _loc_1:* = this.retreiveCertificate();
            this.migrate(_loc_1.id, _loc_1.hash);
            return;
        }// end function

        private function getCertificateFile() : File
        {
            var userName:String;
            var f:File;
            try
            {
                userName = this.getUsername();
                f = this.getCertifFolder(2).resolvePath(MD5.hash(userName));
                if (!f.exists)
                {
                    f = this.getCertifFolder(1).resolvePath(MD5.hash(userName));
                }
                if (f.exists)
                {
                    return f;
                }
            }
            catch (e:Error)
            {
                _log.error("Erreur lors de la recherche du certifcat : " + e.message);
            }
            return null;
        }// end function

        public function retreiveCertificate() : TrustCertificate
        {
            var f:File;
            var certif:TrustCertificate;
            var fs:FileStream;
            var header:String;
            var id:uint;
            var cryptedData:ByteArray;
            var key:ByteArray;
            var aesKey:AESKey;
            var ecb:ECBMode;
            var dataS:String;
            var hash:String;
            var oldCertifId:uint;
            var v1Data:String;
            var oldCertifData:String;
            try
            {
                this._hasV1Certif = false;
                f = this.getCertificateFile();
                if (f)
                {
                    certif = new TrustCertificate();
                    fs = new FileStream();
                    fs.open(f, FileMode.READ);
                    header = fs.readUTFBytes(3);
                    if (header == "SV2")
                    {
                        id = fs.readUnsignedInt();
                        cryptedData = Base64.decodeToByteArray(fs.readUTFBytes(fs.bytesAvailable));
                        key = new ByteArray();
                        key.writeUTFBytes(this.getH(true));
                        aesKey = new AESKey(key);
                        ecb = new ECBMode(aesKey);
                        try
                        {
                            ecb.decrypt(cryptedData);
                        }
                        catch (e:Error)
                        {
                            _log.error("Certificat V2 non valide");
                        }
                        cryptedData.position = 0;
                        dataS = cryptedData.readUTFBytes(cryptedData.length);
                        hash = SHA256.hash(this.getH() + dataS);
                        certif.initTrustCertificate(id, hash);
                    }
                    else
                    {
                        fs.position = 0;
                        oldCertifId = fs.readUnsignedInt();
                        v1Data = fs.readUTF();
                        oldCertifData = SHA256.hashBytes(Base64.decodeToByteArray(v1Data));
                        certif.initTrustCertificate(oldCertifId, oldCertifData);
                        this._hasV1Certif = true;
                    }
                    fs.close();
                    return certif;
                }
            }
            catch (e:Error)
            {
                ErrorManager.addError("Impossible de lire le fichier de certificat.", e);
            }
            return null;
        }// end function

        private function onRpcData(event:RpcEvent) : void
        {
            if (event.type == RpcEvent.EVENT_ERROR && !event.result)
            {
                var _loc_2:* = this._methodsCallback;
                _loc_2.this._methodsCallback[event.method]({error:true, fatal:true, text:I18n.getUiText("ui.secureMode.error.checkCode.503")});
                return;
            }
            if (event.method == RPC_METHOD_SECURITY_CODE)
            {
                var _loc_2:* = this._methodsCallback;
                _loc_2.this._methodsCallback[event.method](this.parseRpcASkCodeResponse(event.result, event.method));
            }
            if (event.method == RPC_METHOD_VALIDATE_CODE)
            {
                var _loc_2:* = this._methodsCallback;
                _loc_2.this._methodsCallback[event.method](this.parseRpcValidateResponse(event.result, event.method));
            }
            if (event.method == RPC_METHOD_MIGRATE)
            {
                if (event.result.success)
                {
                    this.migrationSuccess(event.result);
                }
                else
                {
                    _log.error("Impossible de migrer le certificat : " + event.result.error);
                }
            }
            return;
        }// end function

        private function migrate(param1:uint, param2:String) : void
        {
            this._rpcManager.callMethod(RPC_METHOD_MIGRATE, [this.getUsername(), AuthentificationManager.getInstance().ankamaPortalKey, 1, 2, param1, param2, this.getH(), this.getH(true)]);
            return;
        }// end function

        private function migrationSuccess(param1:Object) : void
        {
            var _loc_2:* = this.getCertificateFile();
            if (_loc_2.exists)
            {
            }
            this.addCertificate(param1.id, param1.certificate);
            return;
        }// end function

        private function getH(param1:Boolean = false) : String
        {
            var networkInterface:Object;
            var interfaces:*;
            var orderInterfaces:Array;
            var netInterface:*;
            var i:uint;
            var reverse:* = param1;
            var data:Array;
            data.push(Capabilities.cpuArchitecture);
            data.push(Capabilities.os);
            data.push(Capabilities.maxLevelIDC);
            data.push(Capabilities.language);
            if (AirScanner.hasAir())
            {
                try
                {
                    data.push(File.documentsDirectory.nativePath.split(File.separator)[2]);
                }
                catch (e:Error)
                {
                    _log.error("User non disponible.");
                    try
                    {
                    }
                    if (ApplicationDomain.currentDomain.hasDefinition("flash.net::NetworkInfo"))
                    {
                        networkInterface = ApplicationDomain.currentDomain.getDefinition("flash.net::NetworkInfo");
                        interfaces = networkInterface.networkInfo.findInterfaces();
                        orderInterfaces;
                        var _loc_3:* = 0;
                        var _loc_4:* = interfaces;
                        while (_loc_4 in _loc_3)
                        {
                            
                            netInterface = _loc_4[_loc_3];
                            orderInterfaces.push(netInterface);
                        }
                        orderInterfaces.sortOn("hardwareAddress");
                        i;
                        while (i < orderInterfaces.length)
                        {
                            
                            data.push(orderInterfaces[i].hardwareAddress);
                            data.push(orderInterfaces[i].name);
                            data.push(orderInterfaces[i].displayName);
                            i = (i + 1);
                        }
                    }
                }
                catch (e:Error)
                {
                    _log.error("Donnée sur la carte réseau non disponible.");
                }
            }
            if (reverse)
            {
                data.reverse();
            }
            return MD5.hash(data.toString());
        }// end function

        public static function getInstance() : SecureModeManager
        {
            if (!_self)
            {
                _self = new SecureModeManager;
            }
            return _self;
        }// end function

    }
}
