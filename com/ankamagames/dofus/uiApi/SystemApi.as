package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.connection.frames.AuthentificationFrame;
   import com.ankamagames.dofus.logic.connection.frames.InitializationFrame;
   import com.ankamagames.dofus.logic.game.approach.frames.GameServerApproachFrame;
   import com.ankamagames.dofus.logic.connection.frames.ServerSelectionFrame;
   import com.ankamagames.jerakine.messages.Worker;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.berilia.utils.errors.UntrustedApiCallError;
   import com.ankamagames.berilia.types.listener.GenericListener;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.berilia.frames.UIInteractionFrame;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.jerakine.utils.display.FrameIdManager;
   import flash.utils.getTimer;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.misc.lists.ApiActionList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.replay.LogFrame;
   import com.ankamagames.jerakine.replay.LogTypeEnum;
   import com.ankamagames.jerakine.logger.ModuleLogger;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.jerakine.data.XmlConfig;
   import flash.utils.getDefinitionByName;
   import com.ankamagames.dofus.Constants;
   import flash.net.navigateToURL;
   import flash.net.URLRequest;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.system.Capabilities;
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import flash.filesystem.FileMode;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.dofus.types.data.ServerCommand;
   import com.ankamagames.jerakine.console.ConsolesManager;
   import com.ankamagames.jerakine.utils.misc.Chrono;
   import flash.events.Event;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.jerakine.types.Version;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.atouin.managers.DataGroundMapManager;
   import com.ankamagames.berilia.components.WebBrowser;
   import com.ankamagames.berilia.components.ComponentInternalAccessor;
   import flash.net.URLRequestMethod;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.utils.crypto.AdvancedMd5;
   import flash.utils.ByteArray;
   import flash.net.URLVariables;
   import com.ankamagames.dofus.network.messages.authorized.AdminQuietCommandMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.MonstersInfoFrame;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.jerakine.managers.PerformanceManager;
   import com.ankamagames.dofus.logic.game.approach.managers.PartManager;
   import com.ankamagames.dofus.network.types.updater.ContentPart;
   import com.ankamagames.dofus.network.enums.PartStateEnum;
   import com.ankamagames.dofus.kernel.updater.UpdaterConnexionHandler;
   import com.ankamagames.dofus.logic.common.managers.AccountManager;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.jerakine.types.DynamicSecureObject;
   import com.ankamagames.dofus.misc.utils.StatisticReportingManager;
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import com.ankamagames.jerakine.utils.system.CommandLineArguments;
   import com.ankamagames.dofus.modules.utils.ModuleInstallerFrame;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.misc.utils.frames.LuaScriptRecorderFrame;
   import com.ankamagames.jerakine.logger.Log;
   
   public class SystemApi extends Object implements IApi
   {
      
      public function SystemApi() {
         this._log = Log.getLogger(getQualifiedClassName(SystemApi));
         this._hooks = new Dictionary();
         this._listener = new Dictionary();
         super();
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      private static var _actionCountRef:Dictionary = new Dictionary();
      
      private static var _actionTsRef:Dictionary = new Dictionary();
      
      private static var _wordInteractionEnable:Boolean = true;
      
      private static var _lastFrameId:uint;
      
      public static function get wordInteractionEnable() : Boolean {
         return _wordInteractionEnable;
      }
      
      private var _module:UiModule;
      
      private var _currentUi:UiRootContainer;
      
      protected var _log:Logger;
      
      private var _characterDataStore:DataStoreType;
      
      private var _accountDataStore:DataStoreType;
      
      private var _moduleActionDataStore:DataStoreType;
      
      private var _hooks:Dictionary;
      
      public function set module(value:UiModule) : void {
         this._module = value;
      }
      
      public function set currentUi(value:UiRootContainer) : void {
         this._currentUi = value;
      }
      
      public function destroy() : void {
         var hookName:* = undefined;
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         this._listener = null;
         this._module = null;
         this._currentUi = null;
         this._characterDataStore = null;
         this._accountDataStore = null;
         for (hookName in this._hooks)
         {
            this.removeHook(hookName);
         }
         this._hooks = new Dictionary();
      }
      
      public function isInGame() : Boolean {
         var authentificationFramePresent:Boolean = Kernel.getWorker().contains(AuthentificationFrame);
         var initializationFramePresent:Boolean = Kernel.getWorker().contains(InitializationFrame);
         var gameServerApproachFramePresent:Boolean = Kernel.getWorker().contains(GameServerApproachFrame);
         var serverSelectionFramePresent:Boolean = Kernel.getWorker().contains(ServerSelectionFrame);
         var worker:Worker = Kernel.getWorker();
         return !((authentificationFramePresent) || (initializationFramePresent) || (gameServerApproachFramePresent) || (serverSelectionFramePresent));
      }
      
      public function addHook(hookClass:Class, callback:Function) : void {
         var hookName:String = null;
         var classInfo:Array = getQualifiedClassName(hookClass).split("::");
         hookName = classInfo[classInfo.length - 1];
         var targetedHook:Hook = Hook.getHookByName(hookName);
         if(!targetedHook)
         {
            throw new BeriliaError("Hook [" + hookName + "] does not exists.");
         }
         else
         {
            if((targetedHook.trusted) && (!this._module.trusted))
            {
               throw new UntrustedApiCallError("Hook " + hookName + " cannot be listen from an untrusted module");
            }
            else
            {
               listener = new GenericListener(hookName,this._currentUi?this._currentUi.name:"__module_" + this._module.id,callback,0,this._currentUi?GenericListener.LISTENER_TYPE_UI:GenericListener.LISTENER_TYPE_MODULE);
               this._hooks[hookClass] = listener;
               KernelEventsManager.getInstance().registerEvent(listener);
               return;
            }
         }
      }
      
      public function removeHook(hookClass:Class) : void {
         if(hookClass)
         {
            KernelEventsManager.getInstance().removeEventListener(this._hooks[hookClass]);
            delete this._hooks[[hookClass]];
         }
      }
      
      public function createHook(name:String) : void {
      }
      
      public function dispatchHook(hookClass:Class, ... params) : void {
         var hookName:String = null;
         var classInfo:Array = getQualifiedClassName(hookClass).split("::");
         hookName = classInfo[classInfo.length - 1];
         var targetedHook:Hook = Hook.getHookByName(hookName);
         if(!targetedHook)
         {
            throw new ApiError("Hook [" + hookName + "] does not exist");
         }
         else
         {
            if(targetedHook.nativeHook)
            {
               throw new UntrustedApiCallError("Hook " + hookName + " is a native hook. Native hooks cannot be dispatch by module");
            }
            else
            {
               CallWithParameters.call(KernelEventsManager.getInstance().processCallback,new Array(targetedHook).concat(params));
               return;
            }
         }
      }
      
      public function sendAction(action:Object) : uint {
         var apiAction:DofusApiAction = null;
         var classInfo:Array = null;
         var t:uint = 0;
         var needConfirmStoreDataManager:Array = null;
         var commonMod:Object = null;
         if(action.hasOwnProperty("parameters"))
         {
            classInfo = getQualifiedClassName(action).split("::");
            apiAction = DofusApiAction.getApiActionByName(classInfo[classInfo.length - 1]);
            if(!apiAction)
            {
               throw new ApiError("Action [" + action + "] does not exist");
            }
            else
            {
               if((apiAction.trusted) && (!this._module.trusted))
               {
                  throw new UntrustedApiCallError("Action " + action + " cannot be launch from an untrusted module");
               }
               else
               {
                  if((!this._module.trusted) && (apiAction.needInteraction) && (!((UIInteractionFrame(Kernel.getWorker().getFrame(UIInteractionFrame)).isProcessingDirectInteraction) || (ShortcutsFrame(Kernel.getWorker().getFrame(ShortcutsFrame)).isProcessingDirectInteraction))))
                  {
                     return 0;
                  }
                  if((!this._module.trusted) && (apiAction.maxUsePerFrame))
                  {
                     if(_lastFrameId != FrameIdManager.frameId)
                     {
                        _actionCountRef = new Dictionary();
                        _lastFrameId = FrameIdManager.frameId;
                     }
                     if(_actionCountRef[apiAction] != undefined)
                     {
                        if(_actionCountRef[apiAction] == 0)
                        {
                           return 0;
                        }
                        _actionCountRef[apiAction] = _actionCountRef[apiAction] - 1;
                     }
                     else
                     {
                        _actionCountRef[apiAction] = apiAction.maxUsePerFrame - 1;
                     }
                  }
                  if((!this._module.trusted) && (apiAction.minimalUseInterval))
                  {
                     t = getTimer() - _actionTsRef[apiAction];
                     if((_actionTsRef[apiAction]) && (t <= apiAction.minimalUseInterval))
                     {
                        return 0;
                     }
                     _actionTsRef[apiAction] = getTimer();
                  }
                  actionToSend = CallWithParameters.callR(apiAction.actionClass["create"],SecureCenter.unsecureContent(action.parameters));
                  if(apiAction.needConfirmation)
                  {
                     if(!this._moduleActionDataStore)
                     {
                        this.initModuleActionDataStore();
                     }
                     needConfirmStoreDataManager = StoreDataManager.getInstance().getSetData(this._moduleActionDataStore,"needConfirm",new Array());
                     if((!this._module.trusted) && (!(needConfirmStoreDataManager[apiAction.name] === false)))
                     {
                        commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                        if(actionToSend is ApiActionList.DeleteObject.actionClass)
                        {
                           commonMod.openPopup(I18n.getUiText("ui.popup.warning"),I18n.getUiText("ui.module.action.confirm",[this._module.name,apiAction.description]),[I18n.getUiText("ui.common.ok"),I18n.getUiText("ui.common.no")],[this.onActionConfirm(actionToSend,apiAction)],this.onActionConfirm(actionToSend,apiAction));
                        }
                        else
                        {
                           commonMod.openCheckboxPopup(I18n.getUiText("ui.popup.warning"),I18n.getUiText("ui.module.action.confirm",[this._module.name,apiAction.description]),this.onActionConfirm(actionToSend,apiAction),null,I18n.getUiText("ui.common.rememberMyChoice"));
                        }
                        return 2;
                     }
                  }
                  LogFrame.log(LogTypeEnum.ACTION,actionToSend);
                  ModuleLogger.log(actionToSend);
                  Kernel.getWorker().process(actionToSend);
                  return 1;
               }
            }
         }
         else
         {
            throw new ApiError("Action [" + action + "] don\'t implement IAction");
         }
      }
      
      private function onActionConfirm(actionToSend:Action, apiAction:DofusApiAction) : Function {
         return function(... args):void
         {
            var needConfirmStoreDataManager:* = undefined;
            if((args.length) && (args[0]))
            {
               needConfirmStoreDataManager = StoreDataManager.getInstance().getSetData(_moduleActionDataStore,"needConfirm",new Array());
               needConfirmStoreDataManager[apiAction.name] = !args[0];
               StoreDataManager.getInstance().setData(_moduleActionDataStore,"needConfirm",needConfirmStoreDataManager);
            }
            LogFrame.log(LogTypeEnum.ACTION,actionToSend);
            ModuleLogger.log(actionToSend);
            Kernel.getWorker().process(actionToSend);
         };
      }
      
      public function log(level:uint, text:*) : void {
         var ui:String = this._currentUi?this._currentUi.uiModule.name + "/" + this._currentUi.uiClass:"?";
         this._log.log(level,"[" + ui + "] " + text);
         if((this._module) && (!this._module.trusted) || (BuildInfos.BUILD_TYPE >= BuildTypeEnum.TESTING))
         {
            ModuleLogger.log("[" + ui + "] " + text,level);
         }
      }
      
      public function setConfigEntry(sKey:String, sValue:*) : void {
         XmlConfig.getInstance().setEntry(sKey,sValue);
      }
      
      public function getConfigEntry(sKey:String) : * {
         return XmlConfig.getInstance().getEntry(sKey);
      }
      
      public function getEnum(name:String) : Class {
         var ClassReference:Class = getDefinitionByName(name) as Class;
         return ClassReference;
      }
      
      public function isEventMode() : Boolean {
         return Constants.EVENT_MODE;
      }
      
      public function isCharacterCreationAllowed() : Boolean {
         return Constants.CHARACTER_CREATION_ALLOWED;
      }
      
      public function getConfigKey(key:String) : * {
         return XmlConfig.getInstance().getEntry("config." + key);
      }
      
      public function goToUrl(url:String) : void {
         navigateToURL(new URLRequest(url));
      }
      
      public function getPlayerManager() : PlayerManager {
         return PlayerManager.getInstance();
      }
      
      public function getPort() : uint {
         var dst:DataStoreType = new DataStoreType("Dofus_ComputerOptions",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
         return StoreDataManager.getInstance().getData(dst,"connectionPortDefault");
      }
      
      public function setPort(port:uint) : Boolean {
         var dst:DataStoreType = new DataStoreType("Dofus_ComputerOptions",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
         return StoreDataManager.getInstance().setData(dst,"connectionPortDefault",port);
      }
      
      public function setData(name:String, value:*, shareWithAccount:Boolean=false) : Boolean {
         var dst:DataStoreType = null;
         if(shareWithAccount)
         {
            if(!this._accountDataStore)
            {
               this.initAccountDataStore();
            }
            dst = this._accountDataStore;
         }
         else
         {
            if(!this._characterDataStore)
            {
               this.initCharacterDataStore();
            }
            dst = this._characterDataStore;
         }
         return StoreDataManager.getInstance().setData(dst,name,value);
      }
      
      public function getSetData(name:String, value:*, shareWithAccount:Boolean=false) : * {
         var dst:DataStoreType = null;
         if(shareWithAccount)
         {
            if(!this._accountDataStore)
            {
               this.initAccountDataStore();
            }
            dst = this._accountDataStore;
         }
         else
         {
            if(!this._characterDataStore)
            {
               this.initCharacterDataStore();
            }
            dst = this._characterDataStore;
         }
         return StoreDataManager.getInstance().getSetData(dst,name,value);
      }
      
      public function setQualityIsEnable() : Boolean {
         return StageShareManager.setQualityIsEnable;
      }
      
      public function hasAir() : Boolean {
         return AirScanner.hasAir();
      }
      
      public function getAirVersion() : uint {
         return !(Capabilities.version.indexOf(" 10,0") == -1)?1:2;
      }
      
      public function isAirVersionAvailable(version:uint) : Boolean {
         return this.setQualityIsEnable();
      }
      
      public function setAirVersion(version:uint) : Boolean {
         var fs:FileStream = null;
         var fs2:FileStream = null;
         if(!this.isAirVersionAvailable(version))
         {
            return false;
         }
         var file_air1:File = new File(File.applicationDirectory.nativePath + File.separator + "useOldAir");
         var file_air2:File = new File(File.applicationDirectory.nativePath + File.separator + "useNewAir");
         if(version == 1)
         {
            try
            {
               if(file_air2.exists)
               {
                  file_air2.deleteFile();
               }
               fs = new FileStream();
               fs.open(file_air1,FileMode.WRITE);
               fs.close();
            }
            catch(e:Error)
            {
               return false;
            }
         }
         else
         {
            try
            {
               if(file_air1.exists)
               {
                  file_air1.deleteFile();
               }
               fs2 = new FileStream();
               fs2.open(file_air2,FileMode.WRITE);
               fs2.close();
            }
            catch(e:Error)
            {
               return false;
            }
         }
         if(version == 1)
         {
            return true;
         }
         return true;
      }
      
      public function getOs() : String {
         return SystemManager.getSingleton().os;
      }
      
      public function getOsVersion() : String {
         return SystemManager.getSingleton().version;
      }
      
      public function getCpu() : String {
         return SystemManager.getSingleton().cpu;
      }
      
      public function getData(name:String, shareWithAccount:Boolean=false) : * {
         var dst:DataStoreType = null;
         if(shareWithAccount)
         {
            if(!this._accountDataStore)
            {
               this.initAccountDataStore();
            }
            dst = this._accountDataStore;
         }
         else
         {
            if(!this._characterDataStore)
            {
               this.initCharacterDataStore();
            }
            dst = this._characterDataStore;
         }
         var value:* = StoreDataManager.getInstance().getData(dst,name);
         switch(true)
         {
            case value is IModuleUtil:
            case value is IDataCenter:
               return SecureCenter.secure(value);
         }
      }
      
      public function getOption(name:String, moduleName:String) : * {
         return OptionManager.getOptionManager(moduleName)[name];
      }
      
      public function callbackHook(hook:Hook, ... params) : void {
         KernelEventsManager.getInstance().processCallback(hook,params);
      }
      
      public function showWorld(b:Boolean, resetAnimations:Boolean=false) : void {
         Atouin.getInstance().showWorld(b,resetAnimations);
      }
      
      public function worldIsVisible() : Boolean {
         return Atouin.getInstance().worldIsVisible;
      }
      
      public function getConsoleAutoCompletion(cmd:String, server:Boolean) : String {
         if(server)
         {
            return ServerCommand.autoComplete(cmd);
         }
         return ConsolesManager.getConsole("debug").autoComplete(cmd);
      }
      
      public function getAutoCompletePossibilities(cmd:String, server:Boolean=false) : Array {
         if(server)
         {
            return ServerCommand.getAutoCompletePossibilities(cmd).sort();
         }
         return ConsolesManager.getConsole("debug").getAutoCompletePossibilities(cmd).sort();
      }
      
      public function getAutoCompletePossibilitiesOnParam(cmd:String, server:Boolean=false, paramIndex:uint=0, currentParams:Array=null) : Array {
         return ConsolesManager.getConsole("debug").getAutoCompletePossibilitiesOnParam(cmd,paramIndex,currentParams).sort();
      }
      
      public function getCmdHelp(cmd:String, server:Boolean=false) : String {
         if(server)
         {
            return ServerCommand.getHelp(cmd);
         }
         return ConsolesManager.getConsole("debug").getCmdHelp(cmd);
      }
      
      public function startChrono(label:String) : void {
         Chrono.start(label);
      }
      
      public function stopChrono() : void {
         Chrono.stop();
      }
      
      public function hasAdminCommand(cmd:String) : Boolean {
         return ServerCommand.hasCommand(cmd);
      }
      
      private var _listener:Dictionary;
      
      private var _listenerCount:uint;
      
      private var _running:Boolean;
      
      private function onEnterFrame(e:Event) : void {
         var fct:Function = null;
         for each (fct in this._listener)
         {
            if(fct != null)
            {
               fct();
            }
         }
      }
      
      public function addEventListener(listener:Function, name:String, frameRate:uint=25) : void {
         this._listenerCount++;
         this._listener[name] = listener;
         if(!this._running)
         {
            EnterFrameDispatcher.addEventListener(this.onEnterFrame,this._module.id + ".enterframe" + Math.random(),frameRate);
            this._running = true;
         }
      }
      
      public function removeEventListener(listener:Function) : void {
         var name:String = null;
         var toDelete:Array = [];
         for (name in this._listener)
         {
            if(listener == this._listener[name])
            {
               this._listenerCount--;
               toDelete.push(name);
            }
         }
         for each (name in toDelete)
         {
            delete this._listener[[name]];
         }
         if(!this._listenerCount)
         {
            this._running = false;
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         }
      }
      
      public function disableWorldInteraction(pTotal:Boolean=true) : void {
         _wordInteractionEnable = false;
         TooltipManager.hideAll();
         Kernel.getWorker().process(ChangeWorldInteractionAction.create(false,pTotal));
      }
      
      public function enableWorldInteraction() : void {
         _wordInteractionEnable = true;
         Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
      }
      
      public function setFrameRate(f:uint) : void {
         StageShareManager.stage.frameRate = f;
      }
      
      public function hasWorldInteraction() : Boolean {
         var contextFrame:RoleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
         if(!contextFrame)
         {
            return false;
         }
         return contextFrame.hasWorldInteraction;
      }
      
      public function hasRight() : Boolean {
         return PlayerManager.getInstance().hasRights;
      }
      
      public function isFightContext() : Boolean {
         return Kernel.getWorker().contains(FightContextFrame);
      }
      
      public function getEntityLookFromString(s:String) : TiphonEntityLook {
         return TiphonEntityLook.fromString(s);
      }
      
      public function getCurrentVersion() : Version {
         return BuildInfos.BUILD_VERSION;
      }
      
      public function getBuildType() : uint {
         return BuildInfos.BUILD_TYPE;
      }
      
      public function getCurrentLanguage() : String {
         return XmlConfig.getInstance().getEntry("config.lang.current");
      }
      
      public function clearCache(pSelective:Boolean=false) : void {
         Dofus.getInstance().clearCache(pSelective,true);
      }
      
      public function reset() : void {
         Dofus.getInstance().reboot();
      }
      
      public function getCurrentServer() : Server {
         return PlayerManager.getInstance().server;
      }
      
      public function getGroundCacheSize() : Number {
         return DataGroundMapManager.getCurrentDiskUsed();
      }
      
      public function clearGroundCache() : void {
         DataGroundMapManager.clearGroundCache();
      }
      
      public function zoom(value:Number) : void {
         this.luaZoom(value);
         Atouin.getInstance().zoom(value);
      }
      
      public function getCurrentZoom() : Number {
         return Atouin.getInstance().currentZoom;
      }
      
      public function goToThirdPartyLogin(target:WebBrowser) : void {
         var ur:URLRequest = null;
         if(BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG)
         {
            ur = new URLRequest("http://127.0.0.1/login.php");
         }
         else
         {
            ur = new URLRequest(I18n.getUiText("ui.link.thirdparty.login"));
         }
         ComponentInternalAccessor.access(target,"load")(ur);
      }
      
      public function goToOgrinePortal(target:WebBrowser) : void {
         var ur:URLRequest = null;
         if((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA))
         {
            ur = new URLRequest(I18n.getUiText("ui.link.ogrinePortal"));
         }
         else
         {
            ur = new URLRequest(I18n.getUiText("ui.link.ogrinePortalLocal"));
         }
         ur.data = this.getAnkamaPortalUrlParams();
         ur.method = URLRequestMethod.POST;
         ComponentInternalAccessor.access(target,"load")(ur);
      }
      
      public function goToAnkaBoxPortal(target:WebBrowser) : void {
         var ur:URLRequest = null;
         if((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA))
         {
            ur = new URLRequest(I18n.getUiText("ui.link.ankaboxPortal"));
         }
         else
         {
            ur = new URLRequest(I18n.getUiText("ui.link.ankaboxPortalLocal"));
         }
         ur.data = this.getAnkamaPortalUrlParams();
         ur.data.idbar = 0;
         ur.data.game = 1;
         ur.method = URLRequestMethod.POST;
         ComponentInternalAccessor.access(target,"load")(ur);
      }
      
      public function goToAnkaBoxLastMessage(target:WebBrowser) : void {
         var ur:URLRequest = null;
         if((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA))
         {
            ur = new URLRequest(I18n.getUiText("ui.link.ankaboxLastMessage"));
         }
         else
         {
            ur = new URLRequest(I18n.getUiText("ui.link.ankaboxLastMessageLocal"));
         }
         ur.data = this.getAnkamaPortalUrlParams();
         ur.data.idbar = 0;
         ur.data.game = 1;
         ur.method = URLRequestMethod.POST;
         ComponentInternalAccessor.access(target,"load")(ur);
      }
      
      public function goToAnkaBoxSend(target:WebBrowser, userId:int) : void {
         var ur:URLRequest = null;
         if((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA))
         {
            ur = new URLRequest(I18n.getUiText("ui.link.ankaboxSend"));
         }
         else
         {
            ur = new URLRequest(I18n.getUiText("ui.link.ankaboxSendLocal"));
         }
         ur.data = this.getAnkamaPortalUrlParams();
         ur.data.i = String(userId);
         ur.data.idbar = 0;
         ur.data.game = 1;
         ur.method = URLRequestMethod.POST;
         ComponentInternalAccessor.access(target,"load")(ur);
      }
      
      public function goToSupportFAQ(faqId:uint) : void {
         var ur:URLRequest = new URLRequest(I18n.getUiText("ui.link.support.faq",[faqId]));
         navigateToURL(ur);
      }
      
      public function goToChangelogPortal(target:WebBrowser) : void {
      }
      
      public function goToCheckLink(url:String, sender:uint, senderName:String) : void {
         var checkLink:String = null;
         if((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.TESTING))
         {
            checkLink = I18n.getUiText("ui.link.checklink");
         }
         else
         {
            checkLink = "http://go.ankama.lan/" + this.getCurrentLanguage() + "/check";
         }
         if(url.indexOf("www") == 0)
         {
            url = "http://" + url;
         }
         var url:String = url;
         var click_id:uint = PlayerManager.getInstance().accountId;
         var click_name:String = PlayedCharacterManager.getInstance().infos.name;
         var sender_id:uint = sender;
         var sender_name:String = senderName;
         var game:int = 1;
         var server:int = PlayerManager.getInstance().server.id;
         this._log.debug("goToCheckLink : " + url + " " + click_id + " " + sender_id + " " + game + " " + server);
         var chaine:String = url + click_id + "" + sender_id + "" + click_name + senderName + game.toString() + server.toString();
         var keyMd5:String = AdvancedMd5.hex_hmac_md5(">:fIZ?vfU0sDM_9j",chaine);
         var jsonTab:String = "{\"url\":\"" + url + "\",\"click_account\":" + click_id + ",\"from_account\":" + sender_id + ",\"click_name\":\"" + click_name + "\",\"from_name\":\"" + sender_name + "\",\"game\":" + game + ",\"server\":" + server + ",\"hmac\":\"" + keyMd5 + "\"}";
         var bytearray:ByteArray = new ByteArray();
         bytearray.writeUTFBytes(jsonTab);
         bytearray.position = 0;
         var buffer:String = "";
         bytearray.position = 0;
         while(bytearray.bytesAvailable)
         {
            buffer = buffer + bytearray.readUnsignedByte().toString(16);
         }
         buffer = buffer.toUpperCase();
         checkLink = checkLink + ("?s=" + buffer);
         var ur:URLRequest = new URLRequest(checkLink);
         var params:URLVariables = new URLVariables();
         params.s = buffer;
         ur.method = URLRequestMethod.POST;
         navigateToURL(ur);
      }
      
      public function refreshUrl(target:WebBrowser, domain:uint=0) : void {
         var params:URLVariables = null;
         var ur:URLRequest = new URLRequest(target.location);
         if(domain == 0)
         {
            ur.data = this.getAnkamaPortalUrlParams();
            ur.method = URLRequestMethod.POST;
         }
         else
         {
            if(domain == 1)
            {
               params = new URLVariables();
               params.tags = BuildInfos.BUILD_VERSION.major + "." + BuildInfos.BUILD_VERSION.minor + "." + BuildInfos.BUILD_VERSION.release;
               params.theme = OptionManager.getOptionManager("dofus").switchUiSkin;
               ur.data = params;
               ur.method = URLRequestMethod.GET;
            }
         }
         ComponentInternalAccessor.access(target,"load")(ur);
      }
      
      public function execServerCmd(cmd:String) : void {
         var aqcmsg:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         aqcmsg.initAdminQuietCommandMessage(cmd);
         if(PlayerManager.getInstance().hasRights)
         {
            ConnectionsHandler.getConnection().send(aqcmsg);
         }
      }
      
      public function mouseZoom(zoomIn:Boolean=true) : void {
         var zoomLevel:Number = Atouin.getInstance().currentZoom + (zoomIn?1:-1);
         this.luaZoom(zoomLevel);
         Atouin.getInstance().zoom(zoomLevel,Atouin.getInstance().worldContainer.mouseX,Atouin.getInstance().worldContainer.mouseY);
         var rpEntitesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(rpEntitesFrame)
         {
            rpEntitesFrame.updateAllIcons();
         }
         var monstersInfoFrame:MonstersInfoFrame = Kernel.getWorker().getFrame(MonstersInfoFrame) as MonstersInfoFrame;
         if(monstersInfoFrame)
         {
            monstersInfoFrame.update(true);
         }
         if((zoomLevel <= AtouinConstants.MAX_ZOOM) && (zoomLevel >= 1))
         {
            TooltipManager.hideAll();
         }
      }
      
      public function resetZoom() : void {
         Atouin.getInstance().zoom(1);
         var rpEntitesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(rpEntitesFrame)
         {
            rpEntitesFrame.updateAllIcons();
         }
      }
      
      public function getMaxZoom() : uint {
         return AtouinConstants.MAX_ZOOM;
      }
      
      public function optimize() : Boolean {
         return PerformanceManager.optimize;
      }
      
      public function hasPart(partName:String) : Boolean {
         var part:ContentPart = PartManager.getInstance().getPart(partName);
         if(part)
         {
            return part.state == PartStateEnum.PART_UP_TO_DATE;
         }
         return true;
      }
      
      public function hasUpdaterConnection() : Boolean {
         return (UpdaterConnexionHandler.getConnection()) && (UpdaterConnexionHandler.getConnection().connected);
      }
      
      public function isDownloading() : Boolean {
         return PartManager.getInstance().isDownloading;
      }
      
      public function isStreaming() : Boolean {
         return AirScanner.isStreamingVersion();
      }
      
      public function isDevMode() : Boolean {
         return UiModuleManager.getInstance().isDevMode;
      }
      
      public function isDownloadFinished() : Boolean {
         return PartManager.getInstance().isFinished;
      }
      
      public function notifyUser(always:Boolean) : void {
         return SystemManager.getSingleton().notifyUser(always);
      }
      
      public function setGameAlign(align:String) : void {
         StageShareManager.stage.align = align;
      }
      
      public function getGameAlign() : String {
         return StageShareManager.stage.align;
      }
      
      public function getDirectoryContent(path:String=".") : Array {
         var len:uint = 0;
         var result:Array = null;
         var folderContent:Array = null;
         var file:File = null;
         do
         {
               len = path.length;
               path = path.replace("..",".");
            }while(path.length != len);
            
            var path:String = path.replace(":","");
            var folder:File = new File(unescape(this._module.rootPath.replace("file://",""))).resolvePath(path);
            if(folder.isDirectory)
            {
               result = [];
               folderContent = folder.getDirectoryListing();
               for each (file in folderContent)
               {
                  result.push(
                     {
                        "name":file.name,
                        "type":(file.isDirectory?"folder":"file")
                     });
               }
               return result;
            }
            return [];
         }
         
         public function getAccountId(playerName:String) : int {
            try
            {
               return AccountManager.getInstance().getAccountId(playerName);
            }
            catch(error:Error)
            {
            }
            return 0;
         }
         
         public function getIsAnkaBoxEnabled() : Boolean {
            var chat:ChatFrame = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
            if(chat)
            {
               return chat.ankaboxEnabled;
            }
            return false;
         }
         
         public function getAdminStatus() : int {
            return PlayerManager.getInstance().adminStatus;
         }
         
         public function getObjectVariables(o:Object, onlyVar:Boolean=false, useCache:Boolean=false) : Array {
            return DescribeTypeCache.getVariables(o,onlyVar,useCache);
         }
         
         public function getNewDynamicSecureObject() : DynamicSecureObject {
            return new DynamicSecureObject();
         }
         
         public function sendStatisticReport(key:String, value:String) : Boolean {
            return StatisticReportingManager.getInstance().report(key,value);
         }
         
         public function isStatisticReported(key:String) : Boolean {
            return StatisticReportingManager.getInstance().isReported(key);
         }
         
         public function getNickname() : String {
            return PlayerManager.getInstance().nickname;
         }
         
         public function copyToClipboard(val:String) : void {
            Clipboard.generalClipboard.clear();
            Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,val);
         }
         
         public function getLaunchArgs() : String {
            return CommandLineArguments.getInstance().toString();
         }
         
         public function getPartnerInfo() : String {
            var fs:FileStream = null;
            var content:String = null;
            var f:File = File.applicationDirectory.resolvePath("partner");
            if(f.exists)
            {
               fs = new FileStream();
               fs.open(f,FileMode.READ);
               content = fs.readUTFBytes(fs.bytesAvailable);
               fs.close();
               return content;
            }
            return "";
         }
         
         public function toggleModuleInstaller() : void {
            var mif:ModuleInstallerFrame = Kernel.getWorker().getFrame(ModuleInstallerFrame) as ModuleInstallerFrame;
            if(mif)
            {
               Kernel.getWorker().removeFrame(mif);
            }
            else
            {
               Kernel.getWorker().addFrame(new ModuleInstallerFrame());
            }
         }
         
         public function isUpdaterVersion2OrUnknown() : Boolean {
            if((!CommandLineArguments.getInstance()) || (!CommandLineArguments.getInstance().hasArgument("lang")))
            {
               this._log.debug("Updater version : pas d\'updater");
               return true;
            }
            if(!CommandLineArguments.getInstance().hasArgument("updater_version"))
            {
               this._log.debug("Updater version : pas de version connue");
               return false;
            }
            this._log.debug("Updater version : " + CommandLineArguments.getInstance().getArgument("updater_version"));
            return CommandLineArguments.getInstance().getArgument("updater_version") == "v2";
         }
         
         private function getAnkamaPortalUrlParams() : URLVariables {
            var params:URLVariables = new URLVariables();
            params.username = AuthentificationManager.getInstance().username;
            params.passkey = AuthentificationManager.getInstance().ankamaPortalKey;
            params.server = PlayerManager.getInstance().server.id;
            params.serverName = PlayerManager.getInstance().server.name;
            params.language = XmlConfig.getInstance().getEntry("config.lang.current");
            params.character = PlayedCharacterManager.getInstance().id;
            params.theme = OptionManager.getOptionManager("dofus").switchUiSkin;
            return params;
         }
         
         private function initAccountDataStore() : void {
            this._accountDataStore = new DataStoreType("AccountModule_" + this._module.id,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
         }
         
         private function initCharacterDataStore() : void {
            this._characterDataStore = new DataStoreType("Module_" + this._module.id,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
         }
         
         private function initModuleActionDataStore() : void {
            this._moduleActionDataStore = new DataStoreType("ModuleAction_" + this._module.id,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
         }
         
         private function luaZoom(value:Number) : void {
            var lsrf:LuaScriptRecorderFrame = Kernel.getWorker().getFrame(LuaScriptRecorderFrame) as LuaScriptRecorderFrame;
            if(lsrf)
            {
               lsrf.cameraZoom(value);
            }
         }
      }
   }
