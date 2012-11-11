package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.frames.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.types.listener.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.datacenter.servers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.kernel.updater.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.connection.frames.*;
    import com.ankamagames.dofus.logic.connection.managers.*;
    import com.ankamagames.dofus.logic.game.approach.frames.*;
    import com.ankamagames.dofus.logic.game.approach.managers.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.authorized.*;
    import com.ankamagames.dofus.network.types.updater.*;
    import com.ankamagames.dofus.types.data.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.handlers.messages.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.replay.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.jerakine.utils.system.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class SystemApi extends Object implements IApi
    {
        private var _module:UiModule;
        private var _currentUi:UiRootContainer;
        protected var _log:Logger;
        private var _characterDataStore:DataStoreType;
        private var _accountDataStore:DataStoreType;
        private var _moduleActionDataStore:DataStoreType;
        private var _hooks:Dictionary;
        private var _listener:Dictionary;
        private var _listenerCount:uint;
        private var _running:Boolean;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        private static var _actionCountRef:Dictionary = new Dictionary();
        private static var _actionTsRef:Dictionary = new Dictionary();
        private static var _wordInterfactionEnable:Boolean = true;
        private static var _lastFrameId:uint;

        public function SystemApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(SystemApi));
            this._hooks = new Dictionary();
            this._listener = new Dictionary();
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function set currentUi(param1:UiRootContainer) : void
        {
            this._currentUi = param1;
            return;
        }// end function

        public function destroy() : void
        {
            var _loc_1:* = undefined;
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            this._listener = null;
            this._module = null;
            this._currentUi = null;
            this._characterDataStore = null;
            this._accountDataStore = null;
            for (_loc_1 in this._hooks)
            {
                
                this.removeHook(_loc_1);
            }
            this._hooks = new Dictionary();
            return;
        }// end function

        public function isInGame() : Boolean
        {
            var _loc_1:* = Kernel.getWorker().contains(AuthentificationFrame);
            var _loc_2:* = Kernel.getWorker().contains(InitializationFrame);
            var _loc_3:* = Kernel.getWorker().contains(GameServerApproachFrame);
            var _loc_4:* = Kernel.getWorker().contains(ServerSelectionFrame);
            var _loc_5:* = Kernel.getWorker();
            return !(_loc_1 || _loc_2 || _loc_3 || _loc_4);
        }// end function

        public function addHook(param1:Class, param2:Function) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = getQualifiedClassName(param1).split("::");
            _loc_3 = getQualifiedClassName(param1).split("::")[(getQualifiedClassName(param1).split("::").length - 1)];
            var _loc_5:* = Hook.getHookByName(_loc_3);
            if (!Hook.getHookByName(_loc_3))
            {
                throw new BeriliaError("Hook [" + _loc_3 + "] does not exists.");
            }
            if (_loc_5.trusted && !this._module.trusted)
            {
                throw new UntrustedApiCallError("Hook " + _loc_3 + " cannot be listen from an untrusted module");
            }
            var _loc_6:* = new GenericListener(_loc_3, this._currentUi ? (this._currentUi.name) : ("__module_" + this._module.id), param2);
            this._hooks[param1] = _loc_6;
            KernelEventsManager.getInstance().registerEvent(_loc_6);
            return;
        }// end function

        public function removeHook(param1:Class) : void
        {
            if (param1)
            {
                KernelEventsManager.getInstance().removeEventListener(this._hooks[param1]);
                delete this._hooks[param1];
            }
            return;
        }// end function

        public function createHook(param1:String) : void
        {
            new Hook(param1, false, false);
            return;
        }// end function

        public function dispatchHook(param1:Class, ... args) : void
        {
            args = null;
            var _loc_4:* = getQualifiedClassName(param1).split("::");
            args = getQualifiedClassName(param1).split("::")[(getQualifiedClassName(param1).split("::").length - 1)];
            var _loc_5:* = Hook.getHookByName(args);
            if (!Hook.getHookByName(args))
            {
                throw new ApiError("Hook [" + args + "] does not exist");
            }
            if (_loc_5.nativeHook)
            {
                throw new UntrustedApiCallError("Hook " + args + " is a native hook. Native hooks cannot be dispatch by module");
            }
            CallWithParameters.call(KernelEventsManager.getInstance().processCallback, new Array(_loc_5).concat(args));
            return;
        }// end function

        public function sendAction(param1:Object) : uint
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (param1.hasOwnProperty("parameters"))
            {
                _loc_4 = getQualifiedClassName(param1).split("::");
                _loc_2 = DofusApiAction.getApiActionByName(_loc_4[(_loc_4.length - 1)]);
            }
            else
            {
                throw new ApiError("Action [" + param1 + "] don\'t implement IAction");
            }
            if (!_loc_2)
            {
                throw new ApiError("Action [" + param1 + "] does not exist");
            }
            if (_loc_2.trusted && !this._module.trusted)
            {
                throw new UntrustedApiCallError("Action " + param1 + " cannot be launch from an untrusted module");
            }
            if (!this._module.trusted && _loc_2.needInteraction && !(UIInteractionFrame(Kernel.getWorker().getFrame(UIInteractionFrame)).isProcessingDirectInteraction || ShortcutsFrame(Kernel.getWorker().getFrame(ShortcutsFrame)).isProcessingDirectInteraction))
            {
                return 0;
            }
            if (!this._module.trusted && _loc_2.maxUsePerFrame)
            {
                if (_lastFrameId != FrameIdManager.frameId)
                {
                    _actionCountRef = new Dictionary();
                    _lastFrameId = FrameIdManager.frameId;
                }
                if (_actionCountRef[_loc_2] != undefined)
                {
                    if (_actionCountRef[_loc_2] == 0)
                    {
                        return 0;
                    }
                    (_actionCountRef[_loc_2] - 1);
                }
                else
                {
                    _actionCountRef[_loc_2] = _loc_2.maxUsePerFrame - 1;
                }
            }
            if (!this._module.trusted && _loc_2.minimalUseInterval)
            {
                _loc_5 = getTimer() - _actionTsRef[_loc_2];
                if (_actionTsRef[_loc_2] && _loc_5 <= _loc_2.minimalUseInterval)
                {
                    return 0;
                }
                _actionTsRef[_loc_2] = getTimer();
            }
            var _loc_3:* = CallWithParameters.callR(_loc_2.actionClass["create"], SecureCenter.unsecureContent(param1.parameters));
            if (_loc_2.needConfirmation)
            {
                if (!this._moduleActionDataStore)
                {
                    this.initModuleActionDataStore();
                }
                _loc_6 = StoreDataManager.getInstance().getSetData(this._moduleActionDataStore, "needConfirm", new Array());
                if (!this._module.trusted && _loc_6[_loc_2.name] !== false)
                {
                    _loc_7 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                    if (_loc_3 is ApiActionList.DeleteObject.actionClass)
                    {
                        _loc_7.openPopup(I18n.getUiText("ui.popup.warning"), I18n.getUiText("ui.module.action.confirm", [this._module.name, _loc_2.description]), [I18n.getUiText("ui.common.ok"), I18n.getUiText("ui.common.no")], [this.onActionConfirm(_loc_3, _loc_2)], this.onActionConfirm(_loc_3, _loc_2));
                    }
                    else
                    {
                        _loc_7.openCheckboxPopup(I18n.getUiText("ui.popup.warning"), I18n.getUiText("ui.module.action.confirm", [this._module.name, _loc_2.description]), this.onActionConfirm(_loc_3, _loc_2), null, I18n.getUiText("ui.common.rememberMyChoice"));
                    }
                    return 2;
                }
            }
            LogFrame.log(LogTypeEnum.ACTION, _loc_3);
            ModuleLogger.log(_loc_3);
            Kernel.getWorker().process(_loc_3);
            return 1;
        }// end function

        private function onActionConfirm(param1:Action, param2:DofusApiAction) : Function
        {
            var actionToSend:* = param1;
            var apiAction:* = param2;
            return function (... args) : void
            {
                args = undefined;
                if (args.length && args[0])
                {
                    args = StoreDataManager.getInstance().getSetData(_moduleActionDataStore, "needConfirm", new Array());
                    args[apiAction.name] = !args[0];
                    StoreDataManager.getInstance().setData(_moduleActionDataStore, "needConfirm", args);
                }
                LogFrame.log(LogTypeEnum.ACTION, actionToSend);
                ModuleLogger.log(actionToSend);
                Kernel.getWorker().process(actionToSend);
                return;
            }// end function
            ;
        }// end function

        public function log(param1:uint, param2) : void
        {
            var _loc_3:* = this._currentUi ? (this._currentUi.uiModule.name + "/" + this._currentUi.uiClass) : ("?");
            this._log.log(param1, "[" + _loc_3 + "] " + param2);
            if (!this._module.trusted || BuildInfos.BUILD_TYPE >= BuildTypeEnum.TESTING)
            {
                ModuleLogger.log("[" + _loc_3 + "] " + param2, param1);
            }
            return;
        }// end function

        public function setConfigEntry(param1:String, param2) : void
        {
            XmlConfig.getInstance().setEntry(param1, param2);
            return;
        }// end function

        public function getConfigEntry(param1:String)
        {
            return XmlConfig.getInstance().getEntry(param1);
        }// end function

        public function getEnum(param1:String) : Class
        {
            var _loc_2:* = getDefinitionByName(param1) as Class;
            return _loc_2;
        }// end function

        public function isEventMode() : Boolean
        {
            return Constants.EVENT_MODE;
        }// end function

        public function isCharacterCreationAllowed() : Boolean
        {
            return Constants.CHARACTER_CREATION_ALLOWED;
        }// end function

        public function getConfigKey(param1:String)
        {
            return XmlConfig.getInstance().getEntry("config." + param1);
        }// end function

        public function goToUrl(param1:String) : void
        {
            navigateToURL(new URLRequest(param1));
            return;
        }// end function

        public function getPlayerManager() : PlayerManager
        {
            return PlayerManager.getInstance();
        }// end function

        public function getPort() : uint
        {
            var _loc_1:* = new DataStoreType("Dofus_ComputerOptions", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT);
            return StoreDataManager.getInstance().getData(_loc_1, "connectionPortDefault");
        }// end function

        public function setPort(param1:uint) : Boolean
        {
            var _loc_2:* = new DataStoreType("Dofus_ComputerOptions", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT);
            return StoreDataManager.getInstance().setData(_loc_2, "connectionPortDefault", param1);
        }// end function

        public function setData(param1:String, param2, param3:Boolean = false) : Boolean
        {
            var _loc_4:* = null;
            if (param3)
            {
                if (!this._accountDataStore)
                {
                    this.initAccountDataStore();
                }
                _loc_4 = this._accountDataStore;
            }
            else
            {
                if (!this._characterDataStore)
                {
                    this.initCharacterDataStore();
                }
                _loc_4 = this._characterDataStore;
            }
            return StoreDataManager.getInstance().setData(_loc_4, param1, param2);
        }// end function

        public function getSetData(param1:String, param2, param3:Boolean = false)
        {
            var _loc_4:* = null;
            if (param3)
            {
                if (!this._accountDataStore)
                {
                    this.initAccountDataStore();
                }
                _loc_4 = this._accountDataStore;
            }
            else
            {
                if (!this._characterDataStore)
                {
                    this.initCharacterDataStore();
                }
                _loc_4 = this._characterDataStore;
            }
            return StoreDataManager.getInstance().getSetData(_loc_4, param1, param2);
        }// end function

        public function setQualityIsEnable() : Boolean
        {
            return StageShareManager.setQualityIsEnable;
        }// end function

        public function hasAir() : Boolean
        {
            return AirScanner.hasAir();
        }// end function

        public function getAirVersion() : uint
        {
            return Capabilities.version.indexOf(" 10,0") != -1 ? (1) : (2);
        }// end function

        public function isAirVersionAvailable(param1:uint) : Boolean
        {
            return this.setQualityIsEnable();
        }// end function

        public function setAirVersion(param1:uint) : Boolean
        {
            var fs:FileStream;
            var fs2:FileStream;
            var version:* = param1;
            if (!this.isAirVersionAvailable(version))
            {
                return false;
            }
            var file_air1:* = new File(File.applicationDirectory.nativePath + File.separator + "useOldAir");
            var file_air2:* = new File(File.applicationDirectory.nativePath + File.separator + "useNewAir");
            if (version == 1)
            {
                try
                {
                    if (file_air2.exists)
                    {
                        file_air2.deleteFile();
                    }
                    fs = new FileStream();
                    fs.open(file_air1, FileMode.WRITE);
                    fs.close();
                }
                catch (e:Error)
                {
                    return false;
                }
            }
            else
            {
                try
                {
                    if (file_air1.exists)
                    {
                        file_air1.deleteFile();
                    }
                    fs2 = new FileStream();
                    fs2.open(file_air2, FileMode.WRITE);
                    fs2.close();
                }
                catch (e:Error)
                {
                    return false;
                }
            }
            return true;
        }// end function

        public function getOs() : String
        {
            return SystemManager.getSingleton().os;
        }// end function

        public function getOsVersion() : String
        {
            return SystemManager.getSingleton().version;
        }// end function

        public function getCpu() : String
        {
            return SystemManager.getSingleton().cpu;
        }// end function

        public function getData(param1:String, param2:Boolean = false)
        {
            var _loc_3:* = null;
            if (param2)
            {
                if (!this._accountDataStore)
                {
                    this.initAccountDataStore();
                }
                _loc_3 = this._accountDataStore;
            }
            else
            {
                if (!this._characterDataStore)
                {
                    this.initCharacterDataStore();
                }
                _loc_3 = this._characterDataStore;
            }
            var _loc_4:* = StoreDataManager.getInstance().getData(_loc_3, param1);
            switch(true)
            {
                case _loc_4 is IModuleUtil:
                case _loc_4 is IDataCenter:
                {
                    return SecureCenter.secure(_loc_4);
                }
                default:
                {
                    break;
                }
            }
            return _loc_4;
        }// end function

        public function getOption(param1:String, param2:String)
        {
            return OptionManager.getOptionManager(param2)[param1];
        }// end function

        public function callbackHook(param1:Hook, ... args) : void
        {
            KernelEventsManager.getInstance().processCallback(param1, args);
            return;
        }// end function

        public function showWorld(param1:Boolean) : void
        {
            Atouin.getInstance().showWorld(param1);
            return;
        }// end function

        public function worldIsVisible() : Boolean
        {
            return Atouin.getInstance().worldIsVisible;
        }// end function

        public function getConsoleAutoCompletion(param1:String, param2:Boolean) : String
        {
            if (param2)
            {
                return ServerCommand.autoComplete(param1);
            }
            return ConsolesManager.getConsole("debug").autoComplete(param1);
        }// end function

        public function getAutoCompletePossibilities(param1:String, param2:Boolean = false) : Array
        {
            if (param2)
            {
                return ServerCommand.getAutoCompletePossibilities(param1).sort();
            }
            return ConsolesManager.getConsole("debug").getAutoCompletePossibilities(param1).sort();
        }// end function

        public function getAutoCompletePossibilitiesOnParam(param1:String, param2:Boolean = false, param3:uint = 0, param4:Array = null) : Array
        {
            return ConsolesManager.getConsole("debug").getAutoCompletePossibilitiesOnParam(param1, param3, param4).sort();
        }// end function

        public function getCmdHelp(param1:String, param2:Boolean = false) : String
        {
            if (param2)
            {
                return ServerCommand.getHelp(param1);
            }
            return ConsolesManager.getConsole("debug").getCmdHelp(param1);
        }// end function

        public function startChrono(param1:String) : void
        {
            Chrono.start(param1);
            return;
        }// end function

        public function stopChrono() : void
        {
            Chrono.stop();
            return;
        }// end function

        public function hasAdminCommand(param1:String) : Boolean
        {
            return ServerCommand.hasCommand(param1);
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._listener)
            {
                
                if (_loc_2 != null)
                {
                    this._loc_2();
                }
            }
            return;
        }// end function

        public function addEventListener(param1:Function, param2:String, param3:uint = 25) : void
        {
            var _loc_4:* = this;
            var _loc_5:* = this._listenerCount + 1;
            _loc_4._listenerCount = _loc_5;
            this._listener[param2] = param1;
            if (!this._running)
            {
                EnterFrameDispatcher.addEventListener(this.onEnterFrame, this._module.id + ".enterframe" + Math.random(), param3);
                this._running = true;
            }
            return;
        }// end function

        public function removeEventListener(param1:Function) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for (_loc_3 in this._listener)
            {
                
                if (param1 == this._listener[_loc_3])
                {
                    var _loc_6:* = this;
                    var _loc_7:* = this._listenerCount - 1;
                    _loc_6._listenerCount = _loc_7;
                    _loc_2.push(_loc_3);
                }
            }
            for each (_loc_3 in _loc_2)
            {
                
                delete this._listener[_loc_3];
            }
            if (!this._listenerCount)
            {
                this._running = false;
                EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            }
            return;
        }// end function

        public function disableWorldInteraction(param1:Boolean = true) : void
        {
            _wordInterfactionEnable = false;
            TooltipManager.hideAll();
            Kernel.getWorker().process(ChangeWorldInteractionAction.create(false, param1));
            return;
        }// end function

        public function enableWorldInteraction() : void
        {
            _wordInterfactionEnable = true;
            Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
            return;
        }// end function

        public function setFrameRate(param1:uint) : void
        {
            StageShareManager.stage.frameRate = param1;
            return;
        }// end function

        public function hasWorldInteraction() : Boolean
        {
            var _loc_1:* = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
            if (!_loc_1)
            {
                return false;
            }
            return _loc_1.hasWorldInteraction;
        }// end function

        public function hasRight() : Boolean
        {
            return PlayerManager.getInstance().hasRights;
        }// end function

        public function isFightContext() : Boolean
        {
            return Kernel.getWorker().contains(FightContextFrame);
        }// end function

        public function getEntityLookFromString(param1:String) : TiphonEntityLook
        {
            return TiphonEntityLook.fromString(param1);
        }// end function

        public function getCurrentVersion() : Version
        {
            return BuildInfos.BUILD_VERSION;
        }// end function

        public function getBuildType() : uint
        {
            return BuildInfos.BUILD_TYPE;
        }// end function

        public function getCurrentLanguage() : String
        {
            return XmlConfig.getInstance().getEntry("config.lang.current");
        }// end function

        public function clearCache(param1:Boolean = false) : void
        {
            Dofus.getInstance().clearCache(param1, true);
            return;
        }// end function

        public function reset() : void
        {
            Dofus.getInstance().reboot();
            return;
        }// end function

        public function getCurrentServer() : Server
        {
            return PlayerManager.getInstance().server;
        }// end function

        public function getGroundCacheSize() : Number
        {
            return DataGroundMapManager.getCurrentDiskUsed();
        }// end function

        public function clearGroundCache() : void
        {
            DataGroundMapManager.clearGroundCache();
            return;
        }// end function

        public function zoom(param1:Number) : void
        {
            Atouin.getInstance().zoom(param1);
            return;
        }// end function

        public function getCurrentZoom() : Number
        {
            return Atouin.getInstance().currentZoom;
        }// end function

        public function goToThirdPartyLogin(param1:WebBrowser) : void
        {
            var _loc_2:* = null;
            _loc_2 = new URLRequest(I18n.getUiText("ui.link.thirdparty.login"));
            this.ComponentInternalAccessor.access(param1, "load")(_loc_2);
            return;
        }// end function

        public function goToOgrinePortal(param1:WebBrowser) : void
        {
            var _loc_2:* = null;
            if (BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE || BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA)
            {
                _loc_2 = new URLRequest(I18n.getUiText("ui.link.ogrinePortal"));
            }
            else
            {
                _loc_2 = new URLRequest(I18n.getUiText("ui.link.ogrinePortalLocal"));
            }
            _loc_2.data = this.getAnkamaPortalUrlParams();
            _loc_2.method = URLRequestMethod.POST;
            this.ComponentInternalAccessor.access(param1, "load")(_loc_2);
            return;
        }// end function

        public function goToAnkaBoxPortal(param1:WebBrowser) : void
        {
            var _loc_2:* = null;
            if (BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE || BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA)
            {
                _loc_2 = new URLRequest(I18n.getUiText("ui.link.ankaboxPortal"));
            }
            else
            {
                _loc_2 = new URLRequest(I18n.getUiText("ui.link.ankaboxPortalLocal"));
            }
            _loc_2.data = this.getAnkamaPortalUrlParams();
            _loc_2.data.idbar = 0;
            _loc_2.data.game = 1;
            _loc_2.method = URLRequestMethod.POST;
            this.ComponentInternalAccessor.access(param1, "load")(_loc_2);
            return;
        }// end function

        public function goToAnkaBoxLastMessage(param1:WebBrowser) : void
        {
            var _loc_2:* = null;
            if (BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE || BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA)
            {
                _loc_2 = new URLRequest(I18n.getUiText("ui.link.ankaboxLastMessage"));
            }
            else
            {
                _loc_2 = new URLRequest(I18n.getUiText("ui.link.ankaboxLastMessageLocal"));
            }
            _loc_2.data = this.getAnkamaPortalUrlParams();
            _loc_2.data.idbar = 0;
            _loc_2.data.game = 1;
            _loc_2.method = URLRequestMethod.POST;
            this.ComponentInternalAccessor.access(param1, "load")(_loc_2);
            return;
        }// end function

        public function goToAnkaBoxSend(param1:WebBrowser, param2:int) : void
        {
            var _loc_3:* = null;
            if (BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE || BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA)
            {
                _loc_3 = new URLRequest(I18n.getUiText("ui.link.ankaboxSend"));
            }
            else
            {
                _loc_3 = new URLRequest(I18n.getUiText("ui.link.ankaboxSendLocal"));
            }
            _loc_3.data = this.getAnkamaPortalUrlParams();
            _loc_3.data.i = String(param2);
            _loc_3.data.idbar = 0;
            _loc_3.data.game = 1;
            _loc_3.method = URLRequestMethod.POST;
            this.ComponentInternalAccessor.access(param1, "load")(_loc_3);
            return;
        }// end function

        public function goToSupportFAQ(param1:uint) : void
        {
            var _loc_2:* = new URLRequest(I18n.getUiText("ui.link.support.faq", [param1]));
            navigateToURL(_loc_2);
            return;
        }// end function

        public function goToChangelogPortal(param1:WebBrowser) : void
        {
            return;
        }// end function

        public function goToCheckLink(param1:String, param2:uint, param3:String) : void
        {
            var _loc_4:* = null;
            if (BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE || BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA || BuildInfos.BUILD_TYPE == BuildTypeEnum.TESTING)
            {
                _loc_4 = I18n.getUiText("ui.link.checklink");
            }
            else
            {
                _loc_4 = "http://go.ankama.lan/" + this.getCurrentLanguage() + "/check";
            }
            if (param1.indexOf("www") == 0)
            {
                param1 = "http://" + param1;
            }
            param1 = param1;
            var _loc_5:* = PlayerManager.getInstance().accountId;
            var _loc_6:* = PlayedCharacterManager.getInstance().infos.name;
            var _loc_7:* = param2;
            var _loc_8:* = param3;
            var _loc_9:* = 1;
            var _loc_10:* = PlayerManager.getInstance().server.id;
            this._log.debug("goToCheckLink : " + param1 + " " + _loc_5 + " " + _loc_7 + " " + _loc_9 + " " + _loc_10);
            var _loc_11:* = param1 + _loc_5 + "" + _loc_7 + "" + _loc_6 + param3 + _loc_9.toString() + _loc_10.toString();
            var _loc_12:* = MD5.hex_hmac_md5(">:fIZ?vfU0sDM_9j", _loc_11);
            var _loc_13:* = "{\"url\":\"" + param1 + "\",\"click_account\":" + _loc_5 + ",\"from_account\":" + _loc_7 + ",\"click_name\":\"" + _loc_6 + "\",\"from_name\":\"" + _loc_8 + "\",\"game\":" + _loc_9 + ",\"server\":" + _loc_10 + ",\"hmac\":\"" + _loc_12 + "\"}";
            var _loc_14:* = new ByteArray();
            new ByteArray().writeUTFBytes(_loc_13);
            _loc_14.position = 0;
            var _loc_15:* = "";
            _loc_14.position = 0;
            while (_loc_14.bytesAvailable)
            {
                
                _loc_15 = _loc_15 + _loc_14.readUnsignedByte().toString(16);
            }
            _loc_15 = _loc_15.toUpperCase();
            _loc_4 = _loc_4 + ("?s=" + _loc_15);
            var _loc_16:* = new URLRequest(_loc_4);
            var _loc_17:* = new URLVariables();
            new URLVariables().s = _loc_15;
            _loc_16.method = URLRequestMethod.POST;
            navigateToURL(_loc_16);
            return;
        }// end function

        public function refreshUrl(param1:WebBrowser, param2:uint = 0) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = new URLRequest(param1.location);
            if (param2 == 0)
            {
                _loc_3.data = this.getAnkamaPortalUrlParams();
                _loc_3.method = URLRequestMethod.POST;
            }
            else if (param2 == 1)
            {
                _loc_4 = new URLVariables();
                _loc_4.tags = BuildInfos.BUILD_VERSION.major + "." + BuildInfos.BUILD_VERSION.minor + "." + BuildInfos.BUILD_VERSION.release;
                _loc_4.theme = OptionManager.getOptionManager("dofus").switchUiSkin;
                _loc_3.data = _loc_4;
                _loc_3.method = URLRequestMethod.GET;
            }
            this.ComponentInternalAccessor.access(param1, "load")(_loc_3);
            return;
        }// end function

        public function execServerCmd(param1:String) : void
        {
            var _loc_2:* = new AdminQuietCommandMessage();
            _loc_2.initAdminQuietCommandMessage(param1);
            if (PlayerManager.getInstance().hasRights)
            {
                ConnectionsHandler.getConnection().send(_loc_2);
            }
            return;
        }// end function

        public function mouseZoom(param1:Boolean = true) : void
        {
            Atouin.getInstance().zoom(Atouin.getInstance().currentZoom + (param1 ? (1) : (-1)), Atouin.getInstance().worldContainer.mouseX, Atouin.getInstance().worldContainer.mouseY);
            return;
        }// end function

        public function resetZoom() : void
        {
            Atouin.getInstance().zoom(1);
            return;
        }// end function

        public function getMaxZoom() : uint
        {
            return AtouinConstants.MAX_ZOOM;
        }// end function

        public function optimize() : Boolean
        {
            return PerformanceManager.optimize;
        }// end function

        public function hasPart(param1:String) : Boolean
        {
            var _loc_2:* = PartManager.getInstance().getPart(param1);
            if (_loc_2)
            {
                return _loc_2.state == PartStateEnum.PART_UP_TO_DATE;
            }
            return true;
        }// end function

        public function hasUpdaterConnection() : Boolean
        {
            return UpdaterConnexionHandler.getConnection() && UpdaterConnexionHandler.getConnection().connected;
        }// end function

        public function isDownloading() : Boolean
        {
            return PartManager.getInstance().isDownloading;
        }// end function

        public function isDownloadFinished() : Boolean
        {
            return PartManager.getInstance().isFinished;
        }// end function

        public function notifyUser(param1:Boolean) : void
        {
            return SystemManager.getSingleton().notifyUser(param1);
        }// end function

        public function setGameAlign(param1:String) : void
        {
            StageShareManager.stage.align = param1;
            return;
        }// end function

        public function getGameAlign() : String
        {
            return StageShareManager.stage.align;
        }// end function

        public function getDirectoryContent(param1:String = ".") : Array
        {
            var _loc_2:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            do
            {
                
                _loc_2 = param1.length;
                param1 = param1.replace("..", ".");
            }while (param1.length != _loc_2)
            param1 = param1.replace(":", "");
            var _loc_3:* = new File(unescape(this._module.rootPath.replace("file://", ""))).resolvePath(param1);
            if (_loc_3.isDirectory)
            {
                _loc_4 = [];
                _loc_5 = _loc_3.getDirectoryListing();
                for each (_loc_6 in _loc_5)
                {
                    
                    _loc_4.push({name:_loc_6.name, type:_loc_6.isDirectory ? ("folder") : ("file")});
                }
                return _loc_4;
            }
            return [];
        }// end function

        public function getAccountId(param1:String) : int
        {
            var playerName:* = param1;
            try
            {
                return AccountManager.getInstance().getAccountId(playerName);
            }
            catch (error:Error)
            {
            }
            return 0;
        }// end function

        public function getIsAnkaBoxEnabled() : Boolean
        {
            var _loc_1:* = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
            if (_loc_1)
            {
                return _loc_1.ankaboxEnabled;
            }
            return false;
        }// end function

        public function getAdminStatus() : int
        {
            return PlayerManager.getInstance().adminStatus;
        }// end function

        public function getObjectVariables(param1:Object, param2:Boolean = false, param3:Boolean = false) : Array
        {
            return DescribeTypeCache.getVariables(param1, param2, param3);
        }// end function

        public function getNewDynamicSecureObject() : DynamicSecureObject
        {
            return new DynamicSecureObject();
        }// end function

        public function sendStatisticReport(param1:String, param2:String) : Boolean
        {
            return StatisticReportingManager.getInstance().report(param1, param2);
        }// end function

        public function isStatisticReported(param1:String) : Boolean
        {
            return StatisticReportingManager.getInstance().isReported(param1);
        }// end function

        public function getNickname() : String
        {
            return PlayerManager.getInstance().nickname;
        }// end function

        private function getAnkamaPortalUrlParams() : URLVariables
        {
            var _loc_1:* = new URLVariables();
            _loc_1.username = AuthentificationManager.getInstance().username;
            _loc_1.passkey = AuthentificationManager.getInstance().ankamaPortalKey;
            _loc_1.server = PlayerManager.getInstance().server.id;
            _loc_1.serverName = PlayerManager.getInstance().server.name;
            _loc_1.language = XmlConfig.getInstance().getEntry("config.lang.current");
            _loc_1.character = PlayedCharacterManager.getInstance().id;
            _loc_1.theme = OptionManager.getOptionManager("dofus").switchUiSkin;
            return _loc_1;
        }// end function

        private function initAccountDataStore() : void
        {
            this._accountDataStore = new DataStoreType("AccountModule_" + this._module.id, true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT);
            return;
        }// end function

        private function initCharacterDataStore() : void
        {
            this._characterDataStore = new DataStoreType("Module_" + this._module.id, true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_CHARACTER);
            return;
        }// end function

        private function initModuleActionDataStore() : void
        {
            this._moduleActionDataStore = new DataStoreType("ModuleAction_" + this._module.id, true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_CHARACTER);
            return;
        }// end function

        public static function get wordInterfactionEnable() : Boolean
        {
            return _wordInterfactionEnable;
        }// end function

    }
}
