package com.ankamagames.berilia
{
    import com.ankamagames.berilia.api.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.utils.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.cache.*;
    import com.ankamagames.jerakine.enum.*;
    import com.ankamagames.jerakine.handlers.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class Berilia extends EventDispatcher
    {
        private const _cache:Cache;
        private var _UISoundListeners:Array;
        private var _bOptions:BeriliaOptions;
        private var _applicationVersion:uint;
        private var _checkModuleAuthority:Boolean = true;
        private var _docMain:Sprite;
        private var _aUiList:Dictionary;
        private var _highestModalDepth:int;
        private var _aContainerList:Array;
        private var _docStrataWorld:Sprite;
        private var _docStrataLow:Sprite;
        private var _docStrataMedium:Sprite;
        private var _docStrataHight:Sprite;
        private var _docStrataTop:Sprite;
        private var _docStrataTooltip:Sprite;
        private var _docStrataSuperTooltip:Sprite;
        private var _handler:MessageHandler;
        private var _aLoadingUi:Array;
        private var _globalScale:Number = 1;
        private var _verboseException:Boolean = false;
        public var useIME:Boolean;
        private static var _self:Berilia;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Berilia));
        public static var _uiCache:Dictionary = new Dictionary();
        public static var embedIcons:Class = EmbedIcons;

        public function Berilia()
        {
            this._cache = new Cache(Cache.CHECK_SYSTEM_MEMORY, 500000000, 300000000);
            this._UISoundListeners = new Array();
            if (_self != null)
            {
                throw new SingletonError("Berilia is a singleton and should not be instanciated directly.");
            }
            return;
        }// end function

        public function get handler() : MessageHandler
        {
            return this._handler;
        }// end function

        public function set handler(param1:MessageHandler) : void
        {
            this._handler = param1;
            return;
        }// end function

        public function get docMain() : Sprite
        {
            return this._docMain;
        }// end function

        public function get uiList() : Dictionary
        {
            return this._aUiList;
        }// end function

        public function get highestModalDepth() : int
        {
            return this._highestModalDepth;
        }// end function

        public function get containerList() : Array
        {
            return this._aContainerList;
        }// end function

        public function get strataLow() : DisplayObjectContainer
        {
            return this._docStrataLow;
        }// end function

        public function get strataMedium() : DisplayObjectContainer
        {
            return this._docStrataMedium;
        }// end function

        public function get strataHigh() : DisplayObjectContainer
        {
            return this._docStrataHight;
        }// end function

        public function get strataTop() : DisplayObjectContainer
        {
            return this._docStrataTop;
        }// end function

        public function get strataTooltip() : DisplayObjectContainer
        {
            return this._docStrataTooltip;
        }// end function

        public function get strataSuperTooltip() : DisplayObjectContainer
        {
            return this._docStrataSuperTooltip;
        }// end function

        public function get loadingUi() : Array
        {
            return this._aLoadingUi;
        }// end function

        public function get scale() : Number
        {
            return this._globalScale;
        }// end function

        public function set scale(param1:Number) : void
        {
            this._globalScale = param1;
            this.updateUiScale();
            return;
        }// end function

        public function get cache() : Cache
        {
            return this._cache;
        }// end function

        public function get verboseException() : Boolean
        {
            return this._verboseException;
        }// end function

        public function set verboseException(param1:Boolean) : void
        {
            this._verboseException = param1;
            return;
        }// end function

        public function get UISoundListeners() : Array
        {
            return this._UISoundListeners;
        }// end function

        public function get options() : BeriliaOptions
        {
            return this._bOptions;
        }// end function

        public function get applicationVersion() : uint
        {
            return this._applicationVersion;
        }// end function

        public function get checkModuleAuthority() : Boolean
        {
            return this._checkModuleAuthority;
        }// end function

        public function setDisplayOptions(param1:BeriliaOptions) : void
        {
            this._bOptions = param1;
            return;
        }// end function

        public function addUIListener(param1:IInterfaceListener) : void
        {
            FpsManager.getInstance().startTracking("ui", 16525567);
            var _loc_2:* = this._UISoundListeners.indexOf(param1);
            if (_loc_2 == -1)
            {
                this._UISoundListeners.push(param1);
            }
            FpsManager.getInstance().stopTracking("ui");
            return;
        }// end function

        public function removeUIListener(param1:IInterfaceListener) : void
        {
            FpsManager.getInstance().startTracking("ui", 16525567);
            var _loc_2:* = this._UISoundListeners.indexOf(param1);
            if (_loc_2 >= 0)
            {
                this._UISoundListeners.splice(_loc_2, 1);
            }
            FpsManager.getInstance().stopTracking("ui");
            return;
        }// end function

        public function init(param1:Sprite, param2:Boolean, param3:uint, param4:Boolean = true) : void
        {
            this._docMain = param1;
            this._docMain.mouseEnabled = false;
            this._applicationVersion = param3;
            this._checkModuleAuthority = param4;
            this._docStrataWorld = new Sprite();
            this._docStrataWorld.name = "strataWorld";
            this._docStrataLow = new Sprite();
            this._docStrataLow.name = "strataLow";
            this._docStrataMedium = new Sprite();
            this._docStrataMedium.name = "strataMedium";
            this._docStrataHight = new Sprite();
            this._docStrataHight.name = "strataHight";
            this._docStrataTop = new Sprite();
            this._docStrataTop.name = "strataTop";
            this._docStrataTooltip = new Sprite();
            this._docStrataTooltip.name = "strataTooltip";
            this._docStrataSuperTooltip = new Sprite();
            this._docStrataSuperTooltip.name = "strataSuperTooltip";
            this._docStrataWorld.mouseEnabled = false;
            this._docStrataLow.mouseEnabled = false;
            this._docStrataMedium.mouseEnabled = false;
            this._docStrataHight.mouseEnabled = false;
            this._docStrataTop.mouseEnabled = false;
            this._docStrataTooltip.mouseChildren = false;
            this._docStrataTooltip.mouseEnabled = false;
            this._docStrataSuperTooltip.mouseChildren = false;
            this._docStrataSuperTooltip.mouseEnabled = false;
            this._docMain.addChild(this._docStrataWorld);
            this._docMain.addChild(this._docStrataLow);
            this._docMain.addChild(this._docStrataMedium);
            this._docMain.addChild(this._docStrataHight);
            this._docMain.addChild(this._docStrataTop);
            this._docMain.addChild(this._docStrataTooltip);
            this._docMain.addChild(this._docStrataSuperTooltip);
            this._aUiList = new Dictionary();
            this._aContainerList = new Array();
            this._aLoadingUi = new Array();
            if (SystemManager.getSingleton().os == OperatingSystem.LINUX)
            {
                Label.HEIGHT_OFFSET = 1;
            }
            return;
        }// end function

        public function reset() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            TimeoutHTMLLoader.resetCache();
            FpsManager.getInstance().startTracking("ui", 16525567);
            for (_loc_1 in _uiCache)
            {
                
                _loc_5 = _uiCache[_loc_1];
                this._aUiList[_loc_1] = _loc_5;
                _loc_5.cached = false;
            }
            _uiCache = new Dictionary();
            _loc_2 = [];
            for (_loc_3 in this._aUiList)
            {
                
                _loc_2.push(_loc_3);
            }
            for each (_loc_3 in _loc_2)
            {
                
                this.unloadUi(_loc_3);
            }
            for each (_loc_4 in UiModuleManager.getInstance().getModules())
            {
                
                KernelEventsManager.getInstance().removeEvent("__module_" + _loc_4.id);
                BindsManager.getInstance().removeEvent("__module_" + _loc_4.id);
            }
            UiGroupManager.getInstance().destroy();
            FpsManager.getInstance().stopTracking("ui");
            return;
        }// end function

        public function loadUi(param1:UiModule, param2:UiData, param3:String, param4 = null, param5:Boolean = false, param6:int = 1, param7:Boolean = false, param8:String = null) : UiRootContainer
        {
            var container:UiRootContainer;
            var t:int;
            var uiModule:* = param1;
            var uiData:* = param2;
            var sName:* = param3;
            var properties:* = param4;
            var bReplace:* = param5;
            var nStrata:* = param6;
            var hide:* = param7;
            var cacheName:* = param8;
            FpsManager.getInstance().startTracking("ui", 16525567);
            if (cacheName)
            {
                container = _uiCache[cacheName];
                if (container)
                {
                    container.name = sName;
                    container.strata = nStrata;
                    container.depth = nStrata * 10000 + Sprite(this._docMain.getChildAt((nStrata + 1))).numChildren;
                    container.uiModule = uiModule;
                    DisplayObjectContainer(this._docMain.getChildAt((nStrata + 1))).addChild(container);
                    this._aUiList[sName] = container;
                    try
                    {
                        t = getTimer();
                        FpsManager.getInstance().startTracking("hook", 7108545);
                        container.uiClass.main(properties);
                        FpsManager.getInstance().stopTracking("hook");
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiLoaded, sName);
                    }
                    catch (e:Error)
                    {
                        ErrorManager.addError("Impossible d\'utiliser le cache d\'interface pour " + container.name + " du module " + (container.uiModule ? (container.uiModule.id) : ("???")));
                        delete _uiCache[cacheName];
                        container.cached = false;
                        unloadUi(sName);
                    }
                    return null;
                }
            }
            container = new UiRootContainer(this._docMain.stage, uiData, Sprite(this._docMain.getChildAt((nStrata + 1))));
            container.name = sName;
            container.strata = nStrata;
            container.depth = nStrata * 10000 + Sprite(this._docMain.getChildAt((nStrata + 1))).numChildren;
            container.uiModule = uiModule;
            if (cacheName)
            {
                container.cached = true;
                _uiCache[cacheName] = container;
            }
            if (!container.parent && !hide)
            {
                DisplayObjectContainer(this._docMain.getChildAt((nStrata + 1))).addChild(container);
            }
            this.loadUiInside(uiData, sName, container, properties, bReplace);
            FpsManager.getInstance().stopTracking("ui");
            return container;
        }// end function

        public function giveFocus(param1:UiRootContainer) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = null;
            if (param1.strata == 1)
            {
                _loc_2 = true;
                for each (_loc_3 in this._aUiList)
                {
                    
                    if (_loc_3.visible && _loc_3.depth > param1.depth && _loc_3.strata == 1)
                    {
                        _loc_2 = false;
                    }
                }
                if (param1.visible && _loc_2)
                {
                    StageShareManager.stage.focus = param1;
                }
            }
            return;
        }// end function

        public function loadUiInside(param1:UiData, param2:String, param3:UiRootContainer, param4 = null, param5:Boolean = false) : UiRootContainer
        {
            if (param5)
            {
                this.unloadUi(param2);
            }
            if (this.isRegisteredUiName(param2))
            {
                throw new BeriliaError(param2 + " is already used by an other UI");
            }
            dispatchEvent(new UiRenderAskEvent(param2, param1));
            param3.name = param2;
            this._aLoadingUi[param2] = true;
            this._aUiList[param2] = param3;
            param3.addEventListener(UiRenderEvent.UIRenderComplete, this.onUiLoaded);
            UiRenderManager.getInstance().loadUi(param1, param3, param4);
            return param3;
        }// end function

        public function unloadUi(param1:String, param2:Boolean = false) : Boolean
        {
            var ui:UiRootContainer;
            var j:Object;
            var linkCursor:LinkedCursorData;
            var currObj:Object;
            var i:Object;
            var topUi:Object;
            var variables:Array;
            var varName:String;
            var holder:Object;
            var rootContainer:UiRootContainer;
            var u:Object;
            var sName:* = param1;
            var forceUnload:* = param2;
            FpsManager.getInstance().startTracking("ui", 16525567);
            dispatchEvent(new UiUnloadEvent(UiUnloadEvent.UNLOAD_UI_STARTED, sName));
            ui = this._aUiList[sName];
            if (ui == null)
            {
                return false;
            }
            var obj:* = new DynamicSecureObject();
            obj.cancel = false;
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiUnloading, sName, obj);
            if (!forceUnload && obj.cancel)
            {
                return false;
            }
            if (ui.cached)
            {
                if (ui.parent)
                {
                    ui.parent.removeChild(ui);
                }
                this.unloadUiEvents(sName, true);
                ui.hideAfterLoading = true;
                delete this._aUiList[sName];
                if (ui.uiClass.unload)
                {
                    try
                    {
                        ui.uiClass.unload();
                    }
                    catch (e:Error)
                    {
                        ErrorManager.addError("Une erreur est survenu dans la fonction unload() de l\'interface " + ui.name + " du module " + (ui.uiModule ? (ui.uiModule.id) : ("???")));
                    }
                }
                if (ui.transmitFocus && (!StageShareManager.stage.focus || !(StageShareManager.stage.focus is TextField)))
                {
                    StageShareManager.stage.focus = topUi == null ? (StageShareManager.stage) : (InteractiveObject(topUi));
                }
                KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiUnloaded, sName);
                return true;
            }
            ui.disableRender = true;
            delete this._aLoadingUi[sName];
            var doIt:* = StageShareManager.stage.focus;
            while (doIt)
            {
                
                if (doIt is UiRootContainer && doIt == ui)
                {
                    StageShareManager.stage.focus = null;
                    break;
                }
                doIt = doIt.parent;
            }
            if (UiRootContainer(ui).uiClass)
            {
                if (Object(UiRootContainer(ui).uiClass).hasOwnProperty("unload"))
                {
                    try
                    {
                        UiRootContainer(ui).uiClass.unload();
                    }
                    catch (e:Error)
                    {
                        ErrorManager.addError("Une erreur est survenu dans la fonction unload() de l\'interface " + ui.name + " du module " + (ui.uiModule ? (ui.uiModule.id) : ("???")));
                    }
                }
                variables = DescribeTypeCache.getVariables(UiRootContainer(ui).uiClass, true, false);
                var _loc_4:* = 0;
                var _loc_5:* = variables;
                while (_loc_5 in _loc_4)
                {
                    
                    varName = _loc_5[_loc_4];
                    if (UiRootContainer(ui).uiClass[varName] is Object)
                    {
                        if (getQualifiedClassName(UiRootContainer(ui).uiClass[varName]).indexOf("Api") && UiRootContainer(ui).uiClass[varName] is Object && Object(UiRootContainer(ui).uiClass[varName]).hasOwnProperty("destroy"))
                        {
                            if (UiRootContainer(ui).uiModule.trusted)
                            {
                                UiRootContainer(ui).uiClass[varName].destroy();
                            }
                            else
                            {
                                UiRootContainer(ui).uiClass[varName].destroy(SecureCenter.ACCESS_KEY);
                            }
                        }
                        UiRootContainer(ui).uiClass[varName] = null;
                    }
                }
                UiRootContainer(ui).uiClass = null;
            }
            var _loc_4:* = 0;
            var _loc_5:* = UIEventManager.getInstance().instances;
            while (_loc_5 in _loc_4)
            {
                
                j = _loc_5[_loc_4];
                if (j != "null" && UIEventManager.getInstance().instances[j].instance.getUi() == ui)
                {
                    UIEventManager.getInstance().instances[j] = null;
                    delete UIEventManager.getInstance().instances[j];
                }
            }
            linkCursor = LinkedCursorSpriteManager.getInstance().getItem("DragAndDrop");
            if (linkCursor && linkCursor.data.hasOwnProperty("currentHolder"))
            {
                holder = linkCursor.data.currentHolder;
                rootContainer = holder.getUi();
                if (rootContainer == ui)
                {
                    LinkedCursorSpriteManager.getInstance().removeItem("DragAndDrop");
                    HumanInputHandler.getInstance().resetClick();
                }
            }
            UiRootContainer(ui).remove();
            var _loc_4:* = 0;
            var _loc_5:* = ui.getElements();
            while (_loc_5 in _loc_4)
            {
                
                i = _loc_5[_loc_4];
                currObj = ui.getElements()[i];
                if (currObj is GraphicContainer)
                {
                    this._aContainerList[currObj["name"]] = null;
                    delete this._aContainerList[currObj["name"]];
                }
                ui.getElements()[i] = null;
                delete ui.getElements()[i];
            }
            if (sName == "serverListSelection")
            {
                trace("");
            }
            KernelEventsManager.getInstance().removeEvent(sName);
            BindsManager.getInstance().removeEvent(sName);
            UiRenderManager.getInstance().cancelRender(ui.uiData);
            SecureCenter.destroy(ui);
            ui.destroyUi(SecureCenter.ACCESS_KEY);
            if (ApiBinder.getApiData("currentUi") == ui)
            {
                ApiBinder.removeApiData("currentUi");
            }
            UiRootContainer(ui).free();
            delete this._aUiList[sName];
            this.updateHighestModalDepth();
            topUi;
            if (ui.strata > 0 && ui.strata < 4)
            {
                var _loc_4:* = 0;
                var _loc_5:* = this._aUiList;
                while (_loc_5 in _loc_4)
                {
                    
                    u = _loc_5[_loc_4];
                    if (topUi == null)
                    {
                        if (u.strata == 1 && u.visible)
                        {
                            topUi = u;
                        }
                        continue;
                    }
                    if (u.depth > topUi.depth && u.strata == 1 && u.visible)
                    {
                        topUi = u;
                    }
                }
                if (!StageShareManager.stage.focus || ui.transmitFocus && !(StageShareManager.stage.focus is TextField))
                {
                    StageShareManager.stage.focus = topUi == null ? (StageShareManager.stage) : (InteractiveObject(topUi));
                }
            }
            FpsManager.getInstance().stopTracking("ui");
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiUnloaded, sName);
            dispatchEvent(new UiUnloadEvent(UiUnloadEvent.UNLOAD_UI_COMPLETE, sName));
            _log.info(sName + " correctly unloaded");
            return true;
        }// end function

        public function unloadUiEvents(param1:String, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            FpsManager.getInstance().startTracking("ui", 16525567);
            if (this._aUiList[param1] == null)
            {
                return;
            }
            for (_loc_4 in this._aUiList[param1].getElements())
            {
                
                _loc_3 = this._aUiList[param1].getElements()[_loc_4];
                if (_loc_3 is GraphicContainer)
                {
                    this._aContainerList[_loc_3["name"]] = null;
                    delete this._aContainerList[_loc_3["name"]];
                }
                if (!param2)
                {
                    this._aUiList[param1].getElements()[_loc_4] = null;
                    delete this._aUiList[param1].getElements()[_loc_4];
                }
            }
            KernelEventsManager.getInstance().removeEvent(param1);
            BindsManager.getInstance().removeEvent(param1);
            for (_loc_5 in UIEventManager.getInstance().instances)
            {
                
                if ((_loc_5 != null || _loc_5 != "null") && UIEventManager.getInstance().instances[_loc_5] && UIEventManager.getInstance().instances[_loc_5].instance && UIEventManager.getInstance().instances[_loc_5].instance.topParent && UIEventManager.getInstance().instances[_loc_5].instance.topParent.name == param1)
                {
                    if (UIEventManager.getInstance().instances[_loc_5].instance.topParent.name == param1)
                    {
                        UIEventManager.getInstance().instances[_loc_5] = null;
                        delete UIEventManager.getInstance().instances[_loc_5];
                    }
                }
            }
            FpsManager.getInstance().stopTracking("ui");
            return;
        }// end function

        public function getUi(param1:String) : UiRootContainer
        {
            return this._aUiList[param1];
        }// end function

        public function isUiDisplayed(param1:String) : Boolean
        {
            return this._aUiList[param1] != null;
        }// end function

        public function updateUiRender() : void
        {
            var _loc_1:* = null;
            for (_loc_1 in this.uiList)
            {
                
                UiRootContainer(this.uiList[_loc_1]).render();
            }
            return;
        }// end function

        public function updateUiScale() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for (_loc_2 in this.uiList)
            {
                
                _loc_1 = UiRootContainer(this.uiList[_loc_2]);
                if (_loc_1.scalable)
                {
                    _loc_1.scale = this.scale;
                    _loc_1.render();
                }
            }
            return;
        }// end function

        public function isRegisteredContainerId(param1:String) : Boolean
        {
            return this._aContainerList[param1] != null;
        }// end function

        public function registerContainerId(param1:String, param2:DisplayObjectContainer) : Boolean
        {
            if (this.isRegisteredContainerId(param1))
            {
                return false;
            }
            this._aContainerList[param1] = param2;
            return true;
        }// end function

        private function onUiLoaded(event:UiRenderEvent) : void
        {
            delete this._aLoadingUi[event.uiTarget.name];
            this.updateHighestModalDepth();
            dispatchEvent(event);
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiLoaded, event.uiTarget.name);
            return;
        }// end function

        private function updateHighestModalDepth() : void
        {
            var _loc_1:* = null;
            this._highestModalDepth = -1;
            for each (_loc_1 in this._aUiList)
            {
                
                if (_loc_1.modal && this._highestModalDepth < _loc_1.depth)
                {
                    this._highestModalDepth = _loc_1.depth;
                }
            }
            return;
        }// end function

        private function isRegisteredUiName(param1:String) : Boolean
        {
            return this._aUiList[param1] != null;
        }// end function

        public static function getInstance() : Berilia
        {
            if (_self == null)
            {
                _self = new Berilia;
            }
            return _self;
        }// end function

    }
}
