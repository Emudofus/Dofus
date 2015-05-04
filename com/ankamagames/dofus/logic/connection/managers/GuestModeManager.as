package com.ankamagames.dofus.logic.connection.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.utils.system.CommandLineArguments;
   import com.ankamagames.dofus.misc.utils.RpcServiceCenter;
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
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.external.ExternalInterface;
   import com.ankamagames.jerakine.messages.Frame;
   import flash.events.ErrorEvent;
   import flash.events.IOErrorEvent;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.logic.game.common.frames.ProtectPishingFrame;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.jerakine.enum.WebBrowserEnum;
   import flash.net.URLRequestMethod;
   import flash.net.navigateToURL;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.data.XmlConfig;
   
   public class GuestModeManager extends Object implements IDestroyable
   {
      
      public function GuestModeManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("GuestModeManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            this._forceGuestMode = false;
            this._domainExtension = RpcServiceCenter.getInstance().apiDomain.split(".").pop() as String;
            this._locale = XmlConfig.getInstance().getEntry("config.lang.current");
            if(CommandLineArguments.getInstance().hasArgument("guest"))
            {
               this._forceGuestMode = CommandLineArguments.getInstance().getArgument("guest") == "true";
            }
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuestModeManager));
      
      private static var _self:GuestModeManager;
      
      public static function getInstance() : GuestModeManager
      {
         if(_self == null)
         {
            _self = new GuestModeManager();
         }
         return _self;
      }
      
      private var _forceGuestMode:Boolean;
      
      private var _domainExtension:String;
      
      private var _locale:String;
      
      public var isLoggingAsGuest:Boolean = false;
      
      public function get forceGuestMode() : Boolean
      {
         return this._forceGuestMode;
      }
      
      public function set forceGuestMode(param1:Boolean) : void
      {
         this._forceGuestMode = param1;
      }
      
      public function logAsGuest() : void
      {
         var _loc2_:Array = null;
         var _loc1_:Object = this.getStoredCredentials();
         if(!_loc1_)
         {
            _loc2_ = [this._locale];
            if(CommandLineArguments.getInstance().hasArgument("webParams"))
            {
               _loc2_.push(CommandLineArguments.getInstance().getArgument("webParams"));
            }
            RpcServiceCenter.getInstance().makeRpcCall(RpcServiceCenter.getInstance().apiDomain + "/ankama/guest.json","json","1.0","Create",_loc2_,this.onGuestAccountCreated,true,false);
         }
         else
         {
            Kernel.getWorker().process(LoginValidationAsGuestAction.create(_loc1_.login,_loc1_.password));
         }
      }
      
      public function convertGuestAccount() : void
      {
         var _loc2_:Object = null;
         var _loc1_:ExternalGameFrame = Kernel.getWorker().getFrame(ExternalGameFrame) as ExternalGameFrame;
         if(_loc1_)
         {
            _loc1_.getIceToken(this.onIceTokenReceived);
         }
         else
         {
            _loc2_ = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            _loc2_.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.secureMode.error.default"),[I18n.getUiText("ui.common.ok")]);
         }
      }
      
      public function clearStoredCredentials() : void
      {
         var _loc1_:CustomSharedObject = CustomSharedObject.getLocal("Dofus_Guest");
         if((_loc1_) && (_loc1_.data))
         {
            _loc1_.data = new Object();
            _loc1_.flush();
         }
      }
      
      public function hasGuestAccount() : Boolean
      {
         return !(this.getStoredCredentials() == null);
      }
      
      public function destroy() : void
      {
         _self = null;
      }
      
      private function storeCredentials(param1:String, param2:String) : void
      {
         var _loc9_:* = true;
         if(_loc9_)
         {
         }
         var _loc3_:* = MD5.hash(param1);
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeUTFBytes(_loc3_);
         var _loc5_:PKCS5 = new PKCS5();
         var _loc6_:ICipher = Crypto.getCipher("simple-aes",_loc4_,_loc5_);
         if(_loc9_)
         {
            _loc5_.setBlockSize(_loc6_.getBlockSize());
         }
         _loc7_.writeUTFBytes(param2);
         if(!_loc10_)
         {
            _loc6_.encrypt(_loc7_);
         }
         var _loc8_:CustomSharedObject = CustomSharedObject.getLocal("Dofus_Guest");
         if(_loc8_)
         {
            if(!_loc10_)
            {
               if(!_loc8_.data)
               {
                  if(_loc9_)
                  {
                     _loc8_.data = new Object();
                     if(!_loc10_)
                     {
                        if(_loc9_)
                        {
                        }
                     }
                     if(_loc10_)
                     {
                     }
                  }
               }
               _loc8_.data.login = param1;
               if(_loc10_)
               {
               }
               if(_loc10_)
               {
               }
               _loc8_.flush();
               if(_loc10_)
               {
               }
            }
            if(_loc10_)
            {
            }
            _loc8_.data.password = _loc7_;
            if(!_loc10_)
            {
               if(_loc10_)
               {
               }
               _loc8_.flush();
            }
            if(_loc10_)
            {
            }
         }
      }
      
      private function getStoredCredentials() : Object
      {
         /*
          * Erreur de décompilation
          * Le code est probablement obsfusqué
          * Astuce : Vous pouvez tenter d'activer la "désobfuscation automatique" dans les paramètres
          * Type d'erreur: TranslateException
          */
         throw new flash.errors.IllegalOperationError("Non décompilé car il y a des erreurs");
      }
      
      private function onGuestAccountCreated(param1:Boolean, param2:*, param3:*) : void
      {
         /*
          * Erreur de décompilation
          * Le code est probablement obsfusqué
          * Astuce : Vous pouvez tenter d'activer la "désobfuscation automatique" dans les paramètres
          * Type d'erreur: EmptyStackException
          */
         throw new flash.errors.IllegalOperationError("Non décompilé car il y a des erreurs");
      }
      
      private function onGuestAccountError(param1:*) : void
      {
         /*
          * Erreur de décompilation
          * Le code est probablement obsfusqué
          * Astuce : Vous pouvez tenter d'activer la "désobfuscation automatique" dans les paramètres
          * Type d'erreur: TranslateException
          */
         throw new flash.errors.IllegalOperationError("Non décompilé car il y a des erreurs");
      }
      
      private function onIceTokenReceived(param1:String) : void
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
