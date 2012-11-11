package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.logic.connection.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.secure.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.json.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.utils.*;
    import mx.utils.*;

    public class SecureModeManager extends Object
    {
        private var _timeout:Timer;
        private var _active:Boolean;
        private var _computerName:String;
        private var _urlLoaders:Dictionary;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SecureModeManager));
        private static const URL_ASK_CODE:String = "https://ws.ankama." + (BuildInfos.BUILD_TYPE <= BuildTypeEnum.BETA ? ("com") : ("lan")) + "/ankama/Accounts_Authentication/SecurityCode?login=%1&game=1&key=%2&lang=%3";
        private static const URL_SEND_CODE:String = "https://ws.ankama." + (BuildInfos.BUILD_TYPE <= BuildTypeEnum.BETA ? ("com") : ("lan")) + "/ankama/Accounts_Authentication/ValidateCode?login=%1&game=1&key=%2&code=%3&certify=%4&name=%5&lang=%6";
        private static const ASK_CODE:uint = 0;
        private static const CHECK_CODE:uint = 1;
        private static var _self:SecureModeManager;

        public function SecureModeManager()
        {
            this._timeout = new Timer(30000);
            this._urlLoaders = new Dictionary();
            if (_self)
            {
                throw new SingletonError();
            }
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
            var _loc_2:* = new URLRequest(this.getUrl(URL_ASK_CODE, this.getUsername(), AuthentificationManager.getInstance().ankamaPortalKey, XmlConfig.getInstance().getEntry("config.lang.current")));
            var _loc_3:* = new URLLoader();
            _loc_3.addEventListener(Event.COMPLETE, this.onRequestAskCodeResponse);
            _loc_3.addEventListener(IOErrorEvent.IO_ERROR, this.onServerNotFound);
            this._urlLoaders[_loc_3] = param1;
            _loc_3.load(_loc_2);
            return;
        }// end function

        public function sendCode(param1:String, param2:Function) : void
        {
            var _loc_3:* = new URLRequest(this.getUrl(URL_SEND_CODE, this.getUsername(), AuthentificationManager.getInstance().ankamaPortalKey, param1.toUpperCase(), this._computerName ? (1) : (0), this._computerName ? (this._computerName) : (""), XmlConfig.getInstance().getEntry("config.lang.current")));
            var _loc_4:* = new URLLoader();
            new URLLoader().addEventListener(Event.COMPLETE, this.onRequestSendCodeResponse);
            this._urlLoaders[_loc_4] = param2;
            _loc_4.load(_loc_3);
            return;
        }// end function

        private function getUsername() : String
        {
            return AuthentificationManager.getInstance().username.toLowerCase().split("|")[0];
        }// end function

        private function parseResponse(param1:String, param2:uint) : Object
        {
            var result:Object;
            var response:Object;
            var success:Boolean;
            var str:* = param1;
            var context:* = param2;
            _log.info(str);
            result = new Object();
            result.error = true;
            result.fatal = false;
            result.retry = false;
            result.text = "";
            try
            {
                response = JSON.decode(str);
                switch(context)
                {
                    case ASK_CODE:
                    {
                        switch(response.response_code)
                        {
                            case 200:
                            {
                                result.domain = response["return"].domain;
                                result.error = false;
                                break;
                            }
                            case 403:
                            {
                                result.text = I18n.getUiText("ui.secureMode.error.askCode.403");
                                break;
                            }
                            case 404:
                            {
                                result.text = I18n.getUiText("ui.secureMode.error.askCode.404");
                                result.fatal = true;
                                break;
                            }
                            default:
                            {
                                if (response["return"] && response["return"]["error_text"])
                                {
                                    result.text = response["return"]["error_text"];
                                }
                                else
                                {
                                    result.text = I18n.getUiText("ui.secureMode.error.default");
                                }
                                result.fatal = true;
                                break;
                                break;
                            }
                        }
                        break;
                    }
                    case CHECK_CODE:
                    {
                        switch(response.response_code)
                        {
                            case 200:
                            case 202:
                            {
                                result.error = response.response_code != 200;
                                if (response["return"] && response["return"].certificate)
                                {
                                    success = this.addCertificate(response["return"].id, response["return"].certificate);
                                    if (!success)
                                    {
                                        result.error = true;
                                        result.text = I18n.getUiText("ui.secureMode.error.checkCode.202.fatal");
                                    }
                                    else if (response.response_code == 202)
                                    {
                                        result.text = I18n.getUiText("ui.secureMode.error.checkCode.202");
                                    }
                                }
                                break;
                            }
                            case 403:
                            {
                                result.text = I18n.getUiText("ui.secureMode.error.checkCode.403");
                                result.retry = true;
                                break;
                            }
                            case 404:
                            {
                                result.text = I18n.getUiText("ui.secureMode.error.checkCode.404");
                                result.fatal = true;
                                break;
                            }
                            case 413:
                            {
                                result.text = I18n.getUiText("ui.secureMode.error.checkCode.413");
                                result.fatal = true;
                                break;
                            }
                            case 503:
                            {
                                result.text = I18n.getUiText("ui.secureMode.error.checkCode.503");
                                result.fatal = true;
                                break;
                            }
                            default:
                            {
                                if (response["return"] && response["return"]["error_text"])
                                {
                                    result.text = response["return"]["error_text"];
                                }
                                else
                                {
                                    result.text = I18n.getUiText("ui.secureMode.error.default");
                                }
                                result.fatal = true;
                                break;
                                break;
                            }
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            catch (e:Error)
            {
                ErrorManager.addError("Erreur lors du traitement de la réponse web", e);
                result.text = I18n.getUiText("ui.secureMode.error.checkCode.503");
                result.fatal = true;
            }
            return result;
        }// end function

        private function getUrl(param1:String, ... args) : String
        {
            args = 1;
            while (args <= args.length)
            {
                
                param1 = param1.replace("%" + args, args[(args - 1)]);
                args = args + 1;
            }
            return param1;
        }// end function

        private function addCertificate(param1:uint, param2:String, param3:Boolean = true) : Boolean
        {
            var tmp:Array;
            var parentDir:String;
            var f:File;
            var fs:FileStream;
            var id:* = param1;
            var content:* = param2;
            var isBase64:* = param3;
            try
            {
                tmp = File.applicationStorageDirectory.nativePath.split(File.separator);
                tmp.pop();
                tmp.pop();
                parentDir = tmp.join(File.separator);
                f = new File(parentDir + File.separator + "AnkamaCertificates/");
                f.createDirectory();
                f = f.resolvePath(MD5.hash(this.getUsername()));
                fs = new FileStream();
                fs.open(f, FileMode.WRITE);
                fs.writeUnsignedInt(id);
                fs.writeUTF(isBase64 ? (content) : (Base64.encode(content)));
                fs.close();
                return true;
            }
            catch (e:Error)
            {
                ErrorManager.addError("Impossible de créer le fichier de certificat.", e);
            }
            return false;
        }// end function

        public function retreiveCertificate() : TrustCertificate
        {
            var tmp:Array;
            var parentDir:String;
            var userName:String;
            var f:File;
            var certif:TrustCertificate;
            var fs:FileStream;
            try
            {
                tmp = File.applicationStorageDirectory.nativePath.split(File.separator);
                tmp.pop();
                tmp.pop();
                parentDir = tmp.join(File.separator);
                userName = this.getUsername();
                f = new File(parentDir + File.separator + "AnkamaCertificates/" + MD5.hash(userName));
                if (f.exists)
                {
                    certif = new TrustCertificate();
                    fs = new FileStream();
                    fs.open(f, FileMode.READ);
                    certif.initTrustCertificate(fs.readUnsignedInt(), SHA256.computeDigest(Base64.decodeToByteArray(fs.readUTF())));
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

        private function onRequestAskCodeResponse(event:Event) : void
        {
            var _loc_2:* = this._urlLoaders;
            _loc_2.this._urlLoaders[URLLoader(event.target)](this.parseResponse(URLLoader(event.target).data, ASK_CODE));
            return;
        }// end function

        private function onRequestSendCodeResponse(event:Event) : void
        {
            var _loc_2:* = this._urlLoaders;
            _loc_2.this._urlLoaders[URLLoader(event.target)](this.parseResponse(URLLoader(event.target).data, CHECK_CODE));
            return;
        }// end function

        private function onServerNotFound(event:IOErrorEvent) : void
        {
            ErrorManager.addError("Impossible de joindre le web service permettant le déblocage du mode sécurisé : " + event.text);
            var _loc_2:* = new Object();
            _loc_2.error = true;
            _loc_2.fatal = true;
            _loc_2.retry = false;
            _loc_2.text = I18n.getUiText("ui.secureMode.error.checkCode.503");
            var _loc_3:* = this._urlLoaders;
            _loc_3.this._urlLoaders[URLLoader(event.target)](_loc_2);
            return;
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
