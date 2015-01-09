package com.ankamagames.dofus.logic.connection.managers
{
    import com.ankamagames.jerakine.interfaces.IDestroyable;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.jerakine.utils.system.CommandLineArguments;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.dofus.misc.utils.RpcServiceCenter;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationAsGuestAction;
    import com.ankamagames.jerakine.types.CustomSharedObject;
    import by.blooddy.crypto.MD5;
    import flash.utils.ByteArray;
    import com.hurlant.crypto.symmetric.PKCS5;
    import com.hurlant.crypto.Crypto;
    import com.hurlant.crypto.symmetric.ICipher;
    import flash.events.IOErrorEvent;
    import flash.events.ErrorEvent;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;

    public class GuestModeManager implements IDestroyable 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuestModeManager));
        private static var _self:GuestModeManager;

        private var commonMod:Object;
        private var _forceGuestMode:Boolean;
        public var isLoggingAsGuest:Boolean = false;

        public function GuestModeManager()
        {
            this.commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            super();
            if (_self != null)
            {
                throw (new SingletonError("GuestModeManager is a singleton and should not be instanciated directly."));
            };
            this._forceGuestMode = false;
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

        public function logAsGuest():void
        {
            var domainExtension:String;
            var locale:String;
            var credentials:Object = this.getStoredCredentials();
            if (!(credentials))
            {
                domainExtension = (((BuildInfos.BUILD_TYPE > BuildTypeEnum.BETA)) ? "lan" : "com");
                locale = XmlConfig.getInstance().getEntry("config.lang.current");
                RpcServiceCenter.getInstance().makeRpcCall((("http://api.ankama." + domainExtension) + "/ankama/guest.json"), "json", "1.0", "Create", [locale], this.onGuestAccountCreated);
            }
            else
            {
                Kernel.getWorker().process(LoginValidationAsGuestAction.create(credentials.login, credentials.password));
            };
        }

        public function clearStoredCredentials():void
        {
            var so:CustomSharedObject = CustomSharedObject.getLocal("Dofus_Guest");
            if (so)
            {
                so.clear();
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
            goto _label_2;
            while (goto _label_1, (var _local_9 = _local_9), true)
            {
                continue;
                var pad = pad;
                
            _label_1: 
                goto _label_3;
            };
            var encryptedPassword = encryptedPassword;
            
        _label_2: 
            //unresolved jump
            var mode = mode;
            
        _label_3: 
            var md5:String = MD5.hash(login);
            var key:ByteArray = new ByteArray();
            key.writeUTFBytes(md5);
            pad = new PKCS5();
            mode = Crypto.getCipher("simple-aes", key, pad);
            pad.setBlockSize(mode.getBlockSize());
            encryptedPassword = new ByteArray();
            while (encryptedPassword.writeUTFBytes(password), true)
            {
                goto _label_4;
            };
            var _local_0 = this;
            
        _label_4: 
            mode.encrypt(encryptedPassword);
            var so:CustomSharedObject = CustomSharedObject.getLocal("Dofus_Guest");
            if (so)
            {
                if (!(so.data))
                {
                    goto _label_10;
                    
                _label_5: 
                    goto _label_9;
                    
                _label_6: 
                    return;
                };
                
            _label_7: 
                so.data.login = login;
                goto _label_5;
                
            _label_8: 
                so.flush();
                goto _label_6;
                var _local_10 = _local_10;
                
            _label_9: 
                so.data.password = encryptedPassword;
                goto _label_11;
                
            _label_10: 
                so.data = new Object();
                goto _label_7;
                
            _label_11: 
                goto _label_8;
            };
            return;
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
                while (goto _label_13, goto _label_15, decryptedPassword.writeBytes(cryptedPassword), goto _label_8, (key = new ByteArray()), true)
                {
                    //unresolved jump
                    
                _label_1: 
                    goto _label_3;
                };
                var _local_10 = _local_10;
                
            _label_2: 
                pad = new PKCS5();
                goto _label_7;
                
            _label_3: 
                pad.setBlockSize(mode.getBlockSize());
                //unresolved jump
                
            _label_4: 
                goto _label_10;
                
            _label_5: 
                goto _label_14;
                
            _label_6: 
                goto _label_9;
                
            _label_7: 
                goto _label_17;
                
            _label_8: 
                //unresolved jump
                
            _label_9: 
                goto _label_5;
                
            _label_10: 
                guestLogin = so.data.login;
                //unresolved jump
                
            _label_11: 
                decryptedPassword = new ByteArray();
                while (//unresolved jump
, (var _local_0 = this), key.writeUTFBytes(md5), for (;;)
                {
                    //unresolved jump
                    var _local_11 = _local_11;
                    
                _label_14: 
                    continue;
                    goto _label_2;
                }, (cryptedPassword = cryptedPassword), mode.decrypt(decryptedPassword), goto _label_16, goto _label_11, (md5 = md5), true)
                {
                    guestPassword = decryptedPassword.readUTFBytes(decryptedPassword.length);
                    goto _label_18;
                    
                _label_12: 
                    decryptedPassword.position = 0;
                    goto _label_4;
                    _local_0 = this;
                    
                _label_13: 
                    goto _label_6;
                };
                
            _label_15: 
                cryptedPassword = (so.data.password as ByteArray);
                //unresolved jump
                
            _label_16: 
                goto _label_12;
                
            _label_17: 
                mode = Crypto.getCipher("simple-aes", key, pad);
                goto _label_1;
                
            _label_18: 
                return ({
                    "login":guestLogin,
                    "password":guestPassword
                });
            };
            return (null);
        }

        private function onGuestAccountCreated(success:Boolean, params:*, request:*):void
        {
            while (_log.debug(("onGuestAccountCreated - " + success)), true)
            {
                goto _label_1;
            };
            var _local_4 = _local_4;
            
        _label_1: 
            if (success)
            {
                if (params.error)
                {
                    this.onGuestAccountError(params.error);
                }
                else
                {
                    this.storeCredentials(params.login, params.password);
                    Kernel.getWorker().process(LoginValidationAsGuestAction.create(params.login, params.password));
                };
            }
            else
            {
                this.onGuestAccountError(params);
            };
            return;
        }

        private function onGuestAccountError(error:*):void
        {
            while (true)
            {
                _log.error(error);
                goto _label_1;
            };
            var _local_3 = _local_3;
            
        _label_1: 
            if ((((((error is ErrorEvent)) && ((error.type == IOErrorEvent.NETWORK_ERROR)))) || ((error is IOErrorEvent))))
            {
                this.commonMod.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.connection.guestAccountCreationTimedOut"), [I18n.getUiText("ui.common.ok")]);
            }
            else
            {
                if ((error is String))
                {
                    this.commonMod.openPopup(I18n.getUiText("ui.common.error"), error, [I18n.getUiText("ui.common.ok")]);
                }
                else
                {
                    this.commonMod.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.secureMode.error.default"), [I18n.getUiText("ui.common.ok")]);
                };
            };
            if (this._forceGuestMode)
            {
                while ((this._forceGuestMode = false), goto _label_2, KernelEventsManager.getInstance().processCallback(HookList.AuthentificationStart), true)
                {
                    return;
                };
                
            _label_2: 
                //unresolved jump
                var _local_2 = _local_2;
            };
            return;
        }


    }
}//package com.ankamagames.dofus.logic.connection.managers

