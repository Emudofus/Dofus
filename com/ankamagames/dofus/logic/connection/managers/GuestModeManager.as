package com.ankamagames.dofus.logic.connection.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
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
   import flash.events.ErrorEvent;
   import flash.events.IOErrorEvent;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.system.CommandLineArguments;
   
   public class GuestModeManager extends Object implements IDestroyable
   {
      
      public function GuestModeManager() {
         this.commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
         super();
         if(_self != null)
         {
            throw new SingletonError("GuestModeManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            this._forceGuestMode = false;
            if(CommandLineArguments.getInstance().hasArgument("guest"))
            {
               this._forceGuestMode = CommandLineArguments.getInstance().getArgument("guest") == "true";
            }
            return;
         }
      }
      
      protected static const _log:Logger;
      
      private static var _self:GuestModeManager;
      
      public static function getInstance() : GuestModeManager {
         if(_self == null)
         {
            _self = new GuestModeManager();
         }
         return _self;
      }
      
      private var commonMod:Object;
      
      private var _forceGuestMode:Boolean;
      
      public var isLoggingAsGuest:Boolean = false;
      
      public function get forceGuestMode() : Boolean {
         return this._forceGuestMode;
      }
      
      public function logAsGuest() : void {
         var domainExtension:String = null;
         var locale:String = null;
         var credentials:Object = this.getStoredCredentials();
         if(!credentials)
         {
            domainExtension = BuildInfos.BUILD_TYPE > BuildTypeEnum.BETA?"lan":"com";
            locale = XmlConfig.getInstance().getEntry("config.lang.current");
            RpcServiceCenter.getInstance().makeRpcCall("http://api.ankama." + domainExtension + "/ankama/guest.json","json","1.0","Create",[locale],this.onGuestAccountCreated);
         }
         else
         {
            Kernel.getWorker().process(LoginValidationAsGuestAction.create(credentials.login,credentials.password));
         }
      }
      
      public function clearStoredCredentials() : void {
         var so:CustomSharedObject = CustomSharedObject.getLocal("Dofus_Guest");
         if(so)
         {
            so.clear();
         }
      }
      
      public function hasGuestAccount() : Boolean {
         return !(this.getStoredCredentials() == null);
      }
      
      public function destroy() : void {
         _self = null;
      }
      
      private function storeCredentials(login:String, password:String) : void {
         var _loc9_:* = true;
         var _loc10_:* = false;
         var md5:String = MD5.hash(login);
         var key:ByteArray = new ByteArray();
         key.writeUTFBytes(md5);
         var pad:PKCS5 = new PKCS5();
         var mode:ICipher = Crypto.getCipher("simple-aes",key,pad);
         pad.setBlockSize(mode.getBlockSize());
         var encryptedPassword:ByteArray = new ByteArray();
         encryptedPassword.writeUTFBytes(password);
         mode.encrypt(encryptedPassword);
         var so:CustomSharedObject = CustomSharedObject.getLocal("Dofus_Guest");
         if(so)
         {
            if(!so.data)
            {
               so.data = new Object();
            }
            so.data.login = login;
            so.data.password = encryptedPassword;
            so.flush();
         }
      }
      
      private function getStoredCredentials() : Object {
         var _loc10_:* = true;
         var _loc11_:* = false;
         var md5:String = null;
         var key:ByteArray = null;
         var pad:PKCS5 = null;
         var mode:ICipher = null;
         var cryptedPassword:ByteArray = null;
         var decryptedPassword:ByteArray = null;
         var guestLogin:String = null;
         var guestPassword:String = null;
         var so:CustomSharedObject = CustomSharedObject.getLocal("Dofus_Guest");
         if((so && so.data) && (so.data.hasOwnProperty("login")) && (so.data.hasOwnProperty("password")))
         {
            md5 = MD5.hash(so.data.login);
            key = new ByteArray();
            key.writeUTFBytes(md5);
            pad = new PKCS5();
            mode = Crypto.getCipher("simple-aes",key,pad);
            pad.setBlockSize(mode.getBlockSize());
            cryptedPassword = so.data.password as ByteArray;
            decryptedPassword = new ByteArray();
            decryptedPassword.writeBytes(cryptedPassword);
            mode.decrypt(decryptedPassword);
            decryptedPassword.position = 0;
            guestLogin = so.data.login;
            guestPassword = decryptedPassword.readUTFBytes(decryptedPassword.length);
            return 
               {
                  "login":guestLogin,
                  "password":guestPassword
               };
         }
         return null;
      }
      
      private function onGuestAccountCreated(success:Boolean, params:*, request:*) : void {
         var _loc4_:* = true;
         var _loc5_:* = false;
         _log.debug("onGuestAccountCreated - " + success);
         if(success)
         {
            if(params.error)
            {
               this.onGuestAccountError(params.error);
            }
            else
            {
               this.storeCredentials(params.login,params.password);
               Kernel.getWorker().process(LoginValidationAsGuestAction.create(params.login,params.password));
            }
         }
         else
         {
            this.onGuestAccountError(params);
         }
      }
      
      private function onGuestAccountError(error:*) : void {
         var _loc2_:* = true;
         var _loc3_:* = false;
         _log.error(error);
         if((error is ErrorEvent) && (error.type == IOErrorEvent.NETWORK_ERROR) || (error is IOErrorEvent))
         {
            this.commonMod.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.connection.guestAccountCreationTimedOut"),[I18n.getUiText("ui.common.ok")]);
         }
         else if(error is String)
         {
            this.commonMod.openPopup(I18n.getUiText("ui.common.error"),error,[I18n.getUiText("ui.common.ok")]);
         }
         else
         {
            this.commonMod.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.secureMode.error.default"),[I18n.getUiText("ui.common.ok")]);
         }
         
         if(this._forceGuestMode)
         {
            this._forceGuestMode = false;
            KernelEventsManager.getInstance().processCallback(HookList.AuthentificationStart);
         }
      }
   }
}
