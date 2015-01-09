package com.ankamagames.dofus.logic.connection.managers
{
    import com.ankamagames.jerakine.interfaces.IDestroyable;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.dofus.misc.utils.RpcServiceCenter;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.jerakine.utils.system.CommandLineArguments;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationAsGuestAction;
    import com.ankamagames.dofus.logic.game.common.frames.ExternalGameFrame;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.jerakine.types.CustomSharedObject;
    import by.blooddy.crypto.MD5;
    import flash.utils.ByteArray;
    import com.hurlant.crypto.symmetric.PKCS5;
    import com.hurlant.crypto.Crypto;
    import com.hurlant.crypto.symmetric.ICipher;
    import flash.external.ExternalInterface;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import flash.events.IOErrorEvent;
    import flash.events.ErrorEvent;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import com.ankamagames.jerakine.utils.system.SystemManager;
    import com.ankamagames.jerakine.enum.WebBrowserEnum;
    import flash.net.URLRequestMethod;
    import flash.net.navigateToURL;

    public class GuestModeManager implements IDestroyable 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuestModeManager));
        private static var _self:GuestModeManager;

        private var _forceGuestMode:Boolean;
        private var _domainExtension:String;
        private var _locale:String;
        public var isLoggingAsGuest:Boolean = false;

        public function GuestModeManager()
        {
            if (_self != null)
            {
                throw (new SingletonError("GuestModeManager is a singleton and should not be instanciated directly."));
            };
            this._forceGuestMode = false;
            this._domainExtension = (RpcServiceCenter.getInstance().apiDomain.split(".").pop() as String);
            this._locale = XmlConfig.getInstance().getEntry("config.lang.current");
            if (CommandLineArguments.getInstance().hasArgument("guest"))
            {
                this._forceGuestMode = (CommandLineArguments.getInstance().getArgument("guest") == "true");
            };
        }

        public static function getInstance():GuestModeManager
        {
            if (_self == null)
            {
                _self = new (GuestModeManager)();
            };
            return (_self);
        }


        public function get forceGuestMode():Boolean
        {
            return (this._forceGuestMode);
        }

        public function set forceGuestMode(v:Boolean):void
        {
            this._forceGuestMode = v;
        }

        public function logAsGuest():void
        {
            var methodParams:Array;
            var credentials:Object = this.getStoredCredentials();
            if (!(credentials))
            {
                methodParams = [this._locale];
                if (CommandLineArguments.getInstance().hasArgument("webParams"))
                {
                    methodParams.push(CommandLineArguments.getInstance().getArgument("webParams"));
                };
                RpcServiceCenter.getInstance().makeRpcCall((RpcServiceCenter.getInstance().apiDomain + "/ankama/guest.json"), "json", "1.0", "Create", methodParams, this.onGuestAccountCreated);
            }
            else
            {
                Kernel.getWorker().process(LoginValidationAsGuestAction.create(credentials.login, credentials.password));
            };
        }

        public function convertGuestAccount():void
        {
            var _local_2:Object;
            var egf:ExternalGameFrame = (Kernel.getWorker().getFrame(ExternalGameFrame) as ExternalGameFrame);
            if (egf)
            {
                egf.getIceToken(this.onIceTokenReceived);
            }
            else
            {
                _local_2 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                _local_2.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.secureMode.error.default"), [I18n.getUiText("ui.common.ok")]);
            };
        }

        public function clearStoredCredentials():void
        {
            var so:CustomSharedObject = CustomSharedObject.getLocal("Dofus_Guest");
            if (((so) && (so.data)))
            {
                so.data = new Object();
                so.flush();
            };
        }

        public function hasGuestAccount():Boolean
        {
            return (!((this.getStoredCredentials() == null)));
        }

        public function destroy():void
        {
            _self = null;
        }

        private function storeCredentials(login:String, password:String):void
        {
            var md5:String = MD5.hash(login);
            var key:ByteArray = new ByteArray();
            key.writeUTFBytes(md5);
            var pad:PKCS5 = new PKCS5();
            var mode:ICipher = Crypto.getCipher("simple-aes", key, pad);
            pad.setBlockSize(mode.getBlockSize());
            var encryptedPassword:ByteArray = new ByteArray();
            encryptedPassword.writeUTFBytes(password);
            mode.encrypt(encryptedPassword);
            var so:CustomSharedObject = CustomSharedObject.getLocal("Dofus_Guest");
            if (so)
            {
                if (!(so.data))
                {
                    so.data = new Object();
                };
                so.data.login = login;
                so.data.password = encryptedPassword;
                so.flush();
            };
        }

        private function getStoredCredentials():Object
        {
            var md5:String;
            var key:ByteArray;
            var pad:PKCS5;
            var mode:ICipher;
            var cryptedPassword:ByteArray;
            var decryptedPassword:ByteArray;
            var guestLogin:String;
            var guestPassword:String;
            var so:CustomSharedObject = CustomSharedObject.getLocal("Dofus_Guest");
            if (((((((so) && (so.data))) && (so.data.hasOwnProperty("login")))) && (so.data.hasOwnProperty("password"))))
            {
                md5 = MD5.hash(so.data.login);
                key = new ByteArray();
                key.writeUTFBytes(md5);
                pad = new PKCS5();
                mode = Crypto.getCipher("simple-aes", key, pad);
                pad.setBlockSize(mode.getBlockSize());
                cryptedPassword = (so.data.password as ByteArray);
                decryptedPassword = new ByteArray();
                decryptedPassword.writeBytes(cryptedPassword);
                mode.decrypt(decryptedPassword);
                decryptedPassword.position = 0;
                guestLogin = so.data.login;
                guestPassword = decryptedPassword.readUTFBytes(decryptedPassword.length);
                return ({
                    "login":guestLogin,
                    "password":guestPassword
                });
            };
            return (null);
        }

        private function onGuestAccountCreated(success:Boolean, params:*, request:*):void
        {
            _log.debug(("onGuestAccountCreated - " + success));
            if (success)
            {
                if (params.error)
                {
                    this.onGuestAccountError(params.error);
                }
                else
                {
                    this.storeCredentials(params.login, params.password);
                    if (((AirScanner.isStreamingVersion()) && (ExternalInterface.available)))
                    {
                        ExternalInterface.call("onGuestAccountCreated");
                    };
                    Kernel.getWorker().process(LoginValidationAsGuestAction.create(params.login, params.password));
                };
            }
            else
            {
                this.onGuestAccountError(params);
            };
        }

        private function onGuestAccountError(error:*):void
        {
            var _local_3:String;
            _log.error(error);
            var commonMod:Object = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            if ((((((error is ErrorEvent)) && ((error.type == IOErrorEvent.NETWORK_ERROR)))) || ((error is IOErrorEvent))))
            {
                commonMod.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.connection.guestAccountCreationTimedOut"), [I18n.getUiText("ui.common.ok")]);
            }
            else
            {
                if ((error is String))
                {
                    commonMod.openPopup(I18n.getUiText("ui.common.error"), error, [I18n.getUiText("ui.common.ok")]);
                }
                else
                {
                    _local_3 = I18n.getUiText("ui.secureMode.error.default");
                    if ((error is ErrorEvent))
                    {
                        _local_3 = (_local_3 + ((" (#" + (error as ErrorEvent).errorID) + ")"));
                    };
                    commonMod.openPopup(I18n.getUiText("ui.common.error"), _local_3, [I18n.getUiText("ui.common.ok")]);
                };
            };
            KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailed, 0);
            if (this._forceGuestMode)
            {
                this._forceGuestMode = false;
                KernelEventsManager.getInstance().processCallback(HookList.AuthentificationStart);
            };
        }

        private function onIceTokenReceived(token:String):void
        {
            var commonMod:Object;
            var _local_5:URLRequest;
            if (!(token))
            {
                commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                commonMod.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.secureMode.error.default"), [I18n.getUiText("ui.common.ok")]);
                return;
            };
            var url:String = (((("http://go.ankama." + this._domainExtension) + "/") + this._locale) + "/go/dofus/complete-guest");
            var urlVars:URLVariables = new URLVariables();
            urlVars.key = token;
            if ((((SystemManager.getSingleton().browser == WebBrowserEnum.CHROME)) && (ExternalInterface.available)))
            {
                ExternalInterface.call("window.open", ((url + "?") + urlVars.toString()), "_blank");
            }
            else
            {
                _local_5 = new URLRequest(url);
                _local_5.method = URLRequestMethod.GET;
                _local_5.data = urlVars;
                navigateToURL(_local_5, "_blank");
            };
        }


    }
}//package com.ankamagames.dofus.logic.connection.managers

