package com.ankamagames.berilia
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.utils.EmbedIcons;
   import com.ankamagames.jerakine.cache.Cache;
   import com.ankamagames.berilia.types.BeriliaOptions;
   import flash.display.Sprite;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.jerakine.interfaces.IInterfaceListener;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.graphic.TimeoutHTMLLoader;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.berilia.managers.UiGroupManager;
   import com.ankamagames.berilia.types.data.UiData;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.berilia.types.event.UiRenderAskEvent;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.berilia.managers.UiRenderManager;
   import com.ankamagames.jerakine.types.DynamicSecureObject;
   import flash.display.DisplayObject;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.berilia.types.event.UiUnloadEvent;
   import flash.text.TextField;
   import com.ankamagames.berilia.types.graphic.ChatTextContainer;
   import flash.display.InteractiveObject;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.managers.UIEventManager;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.jerakine.handlers.HumanInputHandler;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.api.ApiBinder;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class Berilia extends EventDispatcher
   {
      
      public function Berilia() {
         this._UISoundListeners = new Array();
         super();
         if(_self != null)
         {
            throw new SingletonError("Berilia is a singleton and should not be instanciated directly.");
         }
         else
         {
            return;
         }
      }
      
      private static var _self:Berilia;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Berilia));
      
      public static var _uiCache:Dictionary = new Dictionary();
      
      public static var embedIcons:Class = EmbedIcons;
      
      public static function getInstance() : Berilia {
         if(_self == null)
         {
            _self = new Berilia();
         }
         return _self;
      }
      
      private const _cache:Cache = new Cache(Cache.CHECK_SYSTEM_MEMORY,500000000,300000000);
      
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
      
      public function get handler() : MessageHandler {
         return this._handler;
      }
      
      public function set handler(value:MessageHandler) : void {
         this._handler = value;
      }
      
      public function get docMain() : Sprite {
         return this._docMain;
      }
      
      public function get uiList() : Dictionary {
         return this._aUiList;
      }
      
      public function get highestModalDepth() : int {
         return this._highestModalDepth;
      }
      
      public function get containerList() : Array {
         return this._aContainerList;
      }
      
      public function get strataLow() : DisplayObjectContainer {
         return this._docStrataLow;
      }
      
      public function get strataMedium() : DisplayObjectContainer {
         return this._docStrataMedium;
      }
      
      public function get strataHigh() : DisplayObjectContainer {
         return this._docStrataHight;
      }
      
      public function get strataTop() : DisplayObjectContainer {
         return this._docStrataTop;
      }
      
      public function get strataTooltip() : DisplayObjectContainer {
         return this._docStrataTooltip;
      }
      
      public function get strataSuperTooltip() : DisplayObjectContainer {
         return this._docStrataSuperTooltip;
      }
      
      public function get loadingUi() : Array {
         return this._aLoadingUi;
      }
      
      public function get scale() : Number {
         return this._globalScale;
      }
      
      public function set scale(nScale:Number) : void {
         this._globalScale = nScale;
         this.updateUiScale();
      }
      
      public function get cache() : Cache {
         return this._cache;
      }
      
      public function get verboseException() : Boolean {
         return this._verboseException;
      }
      
      public function set verboseException(v:Boolean) : void {
         this._verboseException = v;
      }
      
      public function get UISoundListeners() : Array {
         return this._UISoundListeners;
      }
      
      public function get options() : BeriliaOptions {
         return this._bOptions;
      }
      
      public function get applicationVersion() : uint {
         return this._applicationVersion;
      }
      
      public function get checkModuleAuthority() : Boolean {
         return this._checkModuleAuthority;
      }
      
      public function setDisplayOptions(bopt:BeriliaOptions) : void {
         this._bOptions = bopt;
      }
      
      public function addUIListener(pListener:IInterfaceListener) : void {
         FpsManager.getInstance().startTracking("ui",16525567);
         var index:int = this._UISoundListeners.indexOf(pListener);
         if(index == -1)
         {
            this._UISoundListeners.push(pListener);
         }
         FpsManager.getInstance().stopTracking("ui");
      }
      
      public function removeUIListener(pListener:IInterfaceListener) : void {
         FpsManager.getInstance().startTracking("ui",16525567);
         var index:int = this._UISoundListeners.indexOf(pListener);
         if(index >= 0)
         {
            this._UISoundListeners.splice(index,1);
         }
         FpsManager.getInstance().stopTracking("ui");
      }
      
      public function init(docContainer:Sprite, verboseException:Boolean, applicationVersion:uint, checkModuleAuthority:Boolean=true) : void {
         this._docMain = docContainer;
         this._docMain.mouseEnabled = false;
         this._applicationVersion = applicationVersion;
         this._checkModuleAuthority = checkModuleAuthority;
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
         if(SystemManager.getSingleton().os == OperatingSystem.LINUX)
         {
            Label.HEIGHT_OFFSET = 1;
         }
      }
      
      public function reset() : void {
         var uiName:String = null;
         var tmpUiNameList:Array = null;
         var n:String = null;
         var m:UiModule = null;
         var ui:UiRootContainer = null;
         TimeoutHTMLLoader.resetCache();
         FpsManager.getInstance().startTracking("ui",16525567);
         for (uiName in _uiCache)
         {
            ui = _uiCache[uiName];
            this._aUiList[uiName] = ui;
            ui.cached = false;
         }
         _uiCache = new Dictionary();
         tmpUiNameList = [];
         for (n in this._aUiList)
         {
            tmpUiNameList.push(n);
         }
         for each (n in tmpUiNameList)
         {
            this.unloadUi(n);
         }
         for each (m in UiModuleManager.getInstance().getModules())
         {
            KernelEventsManager.getInstance().removeEvent("__module_" + m.id);
            BindsManager.getInstance().removeEvent("__module_" + m.id);
         }
         UiGroupManager.getInstance().destroy();
         FpsManager.getInstance().stopTracking("ui");
      }
      
      public function loadUi(uiModule:UiModule, uiData:UiData, sName:String, properties:*=null, bReplace:Boolean=false, nStrata:int=1, hide:Boolean=false, cacheName:String=null) : UiRootContainer {
         var container:UiRootContainer = null;
         var highestDepth:int = 0;
         var uiContainer:Sprite = null;
         var i:uint = 0;
         var t:int = 0;
         FpsManager.getInstance().startTracking("ui",16525567);
         if(cacheName)
         {
            container = _uiCache[cacheName];
            if(container)
            {
               container.name = sName;
               container.strata = nStrata;
               highestDepth = int.MIN_VALUE;
               uiContainer = Sprite(this._docMain.getChildAt(nStrata + 1));
               i = 0;
               while(i < uiContainer.numChildren)
               {
                  if((uiContainer.getChildAt(i) is UiRootContainer) && (UiRootContainer(uiContainer.getChildAt(i)).depth > highestDepth))
                  {
                     highestDepth = UiRootContainer(uiContainer.getChildAt(i)).depth;
                  }
                  i++;
               }
               if(highestDepth < 0)
               {
                  highestDepth = 0;
               }
               container.depth = nStrata * 10000 + highestDepth + 1;
               container.uiModule = uiModule;
               DisplayObjectContainer(this._docMain.getChildAt(nStrata + 1)).addChild(container);
               this._aUiList[sName] = container;
               try
               {
                  t = getTimer();
                  FpsManager.getInstance().startTracking("hook",7108545);
                  container.uiClass.main(properties);
                  FpsManager.getInstance().stopTracking("hook");
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiLoaded,sName);
               }
               catch(e:Error)
               {
                  ErrorManager.addError("Impossible d\'utiliser le cache d\'interface pour " + container.name + " du module " + (container.uiModule?container.uiModule.id:"???"));
                  delete _uiCache[[cacheName]];
                  container.cached = false;
                  unloadUi(sName);
               }
               return null;
            }
         }
         container = new UiRootContainer(this._docMain.stage,uiData,Sprite(this._docMain.getChildAt(nStrata + 1)));
         container.name = sName;
         container.strata = nStrata;
         highestDepth = int.MIN_VALUE;
         uiContainer = Sprite(this._docMain.getChildAt(nStrata + 1));
         i = 0;
         while(i < uiContainer.numChildren)
         {
            if((uiContainer.getChildAt(i) is UiRootContainer) && (UiRootContainer(uiContainer.getChildAt(i)).depth > highestDepth))
            {
               highestDepth = UiRootContainer(uiContainer.getChildAt(i)).depth;
            }
            i++;
         }
         if(highestDepth < 0)
         {
            highestDepth = 0;
         }
         container.depth = nStrata * 10000 + highestDepth % 10000 + 1;
         container.uiModule = uiModule;
         if(cacheName)
         {
            container.cached = true;
            _uiCache[cacheName] = container;
         }
         if((!container.parent) && (!hide))
         {
            DisplayObjectContainer(this._docMain.getChildAt(nStrata + 1)).addChild(container);
         }
         this.loadUiInside(uiData,sName,container,properties,bReplace);
         FpsManager.getInstance().stopTracking("ui");
         return container;
      }
      
      public function giveFocus(container:UiRootContainer) : void {
         var onTop:* = false;
         var ui:Object = null;
         if(container.strata == 1)
         {
            onTop = true;
            for each (ui in this._aUiList)
            {
               if((ui.visible) && (ui.depth > container.depth) && (ui.strata == 1))
               {
                  onTop = false;
               }
            }
            if((container.visible) && (onTop))
            {
               StageShareManager.stage.focus = container;
            }
         }
      }
      
      public function loadUiInside(uiData:UiData, sName:String, suiContainer:UiRootContainer, properties:*=null, bReplace:Boolean=false) : UiRootContainer {
         if(bReplace)
         {
            this.unloadUi(sName);
         }
         if(this.isRegisteredUiName(sName))
         {
            throw new BeriliaError(sName + " is already used by an other UI");
         }
         else
         {
            dispatchEvent(new UiRenderAskEvent(sName,uiData));
            suiContainer.name = sName;
            this._aLoadingUi[sName] = true;
            this._aUiList[sName] = suiContainer;
            suiContainer.addEventListener(UiRenderEvent.UIRenderComplete,this.onUiLoaded);
            UiRenderManager.getInstance().loadUi(uiData,suiContainer,properties);
            return suiContainer;
         }
      }
      
      public function unloadUi(sName:String, forceUnload:Boolean=false) : Boolean {
         var ui:UiRootContainer = null;
         var j:Object = null;
         var linkCursor:LinkedCursorData = null;
         var currObj:Object = null;
         var i:Object = null;
         var topUi:Object = null;
         var variables:Array = null;
         var varName:String = null;
         var holder:Object = null;
         var rootContainer:UiRootContainer = null;
         var u:Object = null;
         var startTimer:int = getTimer();
         FpsManager.getInstance().startTracking("ui",16525567);
         dispatchEvent(new UiUnloadEvent(UiUnloadEvent.UNLOAD_UI_STARTED,sName));
         ui = this._aUiList[sName];
         if(ui == null)
         {
            return false;
         }
         var obj:DynamicSecureObject = new DynamicSecureObject();
         obj.cancel = false;
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiUnloading,sName,obj);
         if((!forceUnload) && (obj.cancel))
         {
            return false;
         }
         if(ui.cached)
         {
            if(ui.parent)
            {
               ui.parent.removeChild(ui);
            }
            this.unloadUiEvents(sName,true);
            ui.hideAfterLoading = true;
            delete this._aUiList[[sName]];
            if(ui.uiClass.unload)
            {
               try
               {
                  ui.uiClass.unload();
               }
               catch(e:Error)
               {
                  ErrorManager.addError("Une erreur est survenu dans la fonction unload() de l\'interface " + ui.name + " du module " + (ui.uiModule?ui.uiModule.id:"???"));
               }
            }
            if((ui.transmitFocus) && ((!StageShareManager.stage.focus) || (!((StageShareManager.stage.focus is TextField) || (StageShareManager.stage.focus is ChatTextContainer)))))
            {
               StageShareManager.stage.focus = topUi == null?StageShareManager.stage:InteractiveObject(topUi);
            }
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiUnloaded,sName);
            return true;
         }
         ui.disableRender = true;
         delete this._aLoadingUi[[sName]];
         var doIt:DisplayObject = StageShareManager.stage.focus;
         while(doIt)
         {
            if((doIt is UiRootContainer) && (doIt == ui))
            {
               StageShareManager.stage.focus = null;
               break;
            }
            doIt = doIt.parent;
         }
         if(UiRootContainer(ui).uiClass)
         {
            if(Object(UiRootContainer(ui).uiClass).hasOwnProperty("unload"))
            {
               try
               {
                  UiRootContainer(ui).uiClass.unload();
               }
               catch(e:Error)
               {
                  ErrorManager.addError("Une erreur est survenu dans la fonction unload() de l\'interface " + ui.name + " du module " + (ui.uiModule?ui.uiModule.id:"???") + ": " + e.message);
               }
            }
            variables = DescribeTypeCache.getVariables(UiRootContainer(ui).uiClass,true,false);
            for each (varName in variables)
            {
               if(UiRootContainer(ui).uiClass[varName] is Object)
               {
                  if((getQualifiedClassName(UiRootContainer(ui).uiClass[varName]).indexOf("Api")) && (UiRootContainer(ui).uiClass[varName] is Object) && (Object(UiRootContainer(ui).uiClass[varName]).hasOwnProperty("destroy")))
                  {
                     if(UiRootContainer(ui).uiModule.trusted)
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
         for (j in UIEventManager.getInstance().instances)
         {
            if((!(j == "null")) && (UIEventManager.getInstance().instances[j].instance.getUi() == ui))
            {
               UIEventManager.getInstance().instances[j] = null;
               delete UIEventManager.getInstance().instances[[j]];
            }
         }
         linkCursor = LinkedCursorSpriteManager.getInstance().getItem("DragAndDrop");
         if((linkCursor) && (linkCursor.data.hasOwnProperty("currentHolder")))
         {
            holder = linkCursor.data.currentHolder;
            rootContainer = holder.getUi();
            if(rootContainer == ui)
            {
               LinkedCursorSpriteManager.getInstance().removeItem("DragAndDrop");
               HumanInputHandler.getInstance().resetClick();
            }
         }
         UiRootContainer(ui).remove();
         for (i in ui.getElements())
         {
            currObj = ui.getElements()[i];
            if(currObj is GraphicContainer)
            {
               this._aContainerList[currObj["name"]] = null;
               delete this._aContainerList[[currObj["name"]]];
            }
            ui.getElements()[i] = null;
            delete ui.getElements()[[i]];
         }
         if(sName == "serverListSelection")
         {
            trace("");
         }
         KernelEventsManager.getInstance().removeEvent(sName);
         BindsManager.getInstance().removeEvent(sName);
         UiRenderManager.getInstance().cancelRender(ui.uiData);
         SecureCenter.destroy(ui);
         ui.destroyUi(SecureCenter.ACCESS_KEY);
         if(ApiBinder.getApiData("currentUi") == ui)
         {
            ApiBinder.removeApiData("currentUi");
         }
         UiRootContainer(ui).free();
         delete this._aUiList[[sName]];
         this.updateHighestModalDepth();
         topUi = null;
         if((ui.strata > 0) && (ui.strata < 4))
         {
            for each (u in this._aUiList)
            {
               if(topUi == null)
               {
                  if((u.strata == 1) && (u.visible))
                  {
                     topUi = u;
                  }
               }
               else
               {
                  if((u.depth > topUi.depth) && (u.strata == 1) && (u.visible))
                  {
                     topUi = u;
                  }
               }
            }
            if((!StageShareManager.stage.focus) || (ui.transmitFocus) && (!((StageShareManager.stage.focus is TextField) || (StageShareManager.stage.focus is ChatTextContainer))))
            {
               StageShareManager.stage.focus = topUi == null?StageShareManager.stage:InteractiveObject(topUi);
            }
         }
         FpsManager.getInstance().stopTracking("ui");
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiUnloaded,sName);
         dispatchEvent(new UiUnloadEvent(UiUnloadEvent.UNLOAD_UI_COMPLETE,sName));
         var stopTimer:int = getTimer();
         _log.info(sName + " correctly unloaded in " + (stopTimer - startTimer) + "ms");
         return true;
      }
      
      public function unloadUiEvents(sName:String, useCache:Boolean=false) : void {
         var currObj:Object = null;
         var i:Object = null;
         var j:Object = null;
         FpsManager.getInstance().startTracking("ui",16525567);
         if(this._aUiList[sName] == null)
         {
            return;
         }
         for (i in this._aUiList[sName].getElements())
         {
            currObj = this._aUiList[sName].getElements()[i];
            if(currObj is GraphicContainer)
            {
               this._aContainerList[currObj["name"]] = null;
               delete this._aContainerList[[currObj["name"]]];
            }
            if(!useCache)
            {
               this._aUiList[sName].getElements()[i] = null;
               delete this._aUiList[sName].getElements()[[i]];
            }
         }
         KernelEventsManager.getInstance().removeEvent(sName);
         BindsManager.getInstance().removeEvent(sName);
         for (j in UIEventManager.getInstance().instances)
         {
            if((!(j == null) || !(j == "null")) && (UIEventManager.getInstance().instances[j]) && (UIEventManager.getInstance().instances[j].instance) && (UIEventManager.getInstance().instances[j].instance.topParent) && (UIEventManager.getInstance().instances[j].instance.topParent.name == sName))
            {
               if(UIEventManager.getInstance().instances[j].instance.topParent.name == sName)
               {
                  UIEventManager.getInstance().instances[j] = null;
                  delete UIEventManager.getInstance().instances[[j]];
               }
            }
         }
         FpsManager.getInstance().stopTracking("ui");
      }
      
      public function getUi(sName:String) : UiRootContainer {
         return this._aUiList[sName];
      }
      
      public function isUiDisplayed(sName:String) : Boolean {
         return !(this._aUiList[sName] == null);
      }
      
      public function updateUiRender() : void {
         var i:String = null;
         for (i in this.uiList)
         {
            UiRootContainer(this.uiList[i]).render();
         }
      }
      
      public function updateUiScale() : void {
         var ui:UiRootContainer = null;
         var i:String = null;
         for (i in this.uiList)
         {
            ui = UiRootContainer(this.uiList[i]);
            if(ui.scalable)
            {
               ui.scale = this.scale;
               ui.render();
            }
         }
      }
      
      public function isRegisteredContainerId(sName:String) : Boolean {
         return !(this._aContainerList[sName] == null);
      }
      
      public function registerContainerId(sName:String, doc:DisplayObjectContainer) : Boolean {
         if(this.isRegisteredContainerId(sName))
         {
            return false;
         }
         this._aContainerList[sName] = doc;
         return true;
      }
      
      private function onUiLoaded(ure:UiRenderEvent) : void {
         delete this._aLoadingUi[[ure.uiTarget.name]];
         this.updateHighestModalDepth();
         dispatchEvent(ure);
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiLoaded,ure.uiTarget.name);
      }
      
      private function updateHighestModalDepth() : void {
         var uiContainer:UiRootContainer = null;
         this._highestModalDepth = -1;
         for each (uiContainer in this._aUiList)
         {
            if((uiContainer.modal) && (this._highestModalDepth < uiContainer.depth))
            {
               this._highestModalDepth = uiContainer.depth;
            }
         }
      }
      
      private function isRegisteredUiName(sName:String) : Boolean {
         return !(this._aUiList[sName] == null);
      }
   }
}
