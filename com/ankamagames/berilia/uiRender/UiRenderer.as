package com.ankamagames.berilia.uiRender
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.pools.PoolableXmlParsor;
   import com.ankamagames.berilia.types.uiDefinition.UiDefinition;
   import flash.utils.getTimer;
   import com.ankamagames.berilia.pools.PoolsManager;
   import flash.events.Event;
   import flash.display.Sprite;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.event.InstanceEvent;
   import com.ankamagames.berilia.types.graphic.GraphicElement;
   import com.ankamagames.berilia.types.uiDefinition.BasicElement;
   import com.ankamagames.berilia.types.uiDefinition.StateContainerElement;
   import com.ankamagames.berilia.types.uiDefinition.ContainerElement;
   import com.ankamagames.berilia.types.uiDefinition.ComponentElement;
   import com.ankamagames.berilia.types.graphic.GraphicLocation;
   import com.ankamagames.berilia.types.uiDefinition.ButtonElement;
   import com.ankamagames.berilia.types.graphic.StateContainer;
   import com.ankamagames.berilia.types.uiDefinition.GridElement;
   import com.ankamagames.berilia.types.uiDefinition.LocationELement;
   import com.ankamagames.berilia.types.graphic.GraphicSize;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.managers.UIEventManager;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.ScrollContainer;
   import flash.utils.getDefinitionByName;
   import com.ankamagames.berilia.types.uiDefinition.ScrollContainerElement;
   import com.ankamagames.berilia.types.graphic.InternalComponentAccess;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.api.ApiBinder;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.berilia.types.listener.GenericListener;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.berilia.types.event.ParsorEvent;
   
   public class UiRenderer extends EventDispatcher
   {
      
      public function UiRenderer() {
         super();
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary;
      
      public static var MEMORY_LOG_2:Dictionary;
      
      protected static const _log:Logger;
      
      public static var componentsPools:Array;
      
      protected var _scUi:UiRootContainer;
      
      private var _sName:String;
      
      private var _xpParser:PoolableXmlParsor;
      
      private var _uiDef:UiDefinition;
      
      private var _xmlClassDef:XML;
      
      private var _oProperties;
      
      protected var _nTimeStamp:uint;
      
      private var _scriptClass:Class;
      
      private var _isXmlRender:Boolean;
      
      private var _aFilnalizedLater:Array;
      
      public function get uiDefinition() : UiDefinition {
         return this._uiDef;
      }
      
      public var fromCache:Boolean = false;
      
      public var parsingTime:uint = 0;
      
      public var buildTime:uint = 0;
      
      public var scriptTime:uint = 0;
      
      public function set script(scriptClass:Class) : void {
         this._scriptClass = scriptClass;
      }
      
      public function get script() : Class {
         return this._scriptClass;
      }
      
      public function fileRender(sUrl:String, sName:String, scUi:UiRootContainer, oProperties:* = null) : void {
         this._nTimeStamp = getTimer();
         this._oProperties = oProperties;
         this._sName = sName;
         this._scUi = scUi;
         this._isXmlRender = true;
         this._xpParser = PoolsManager.getInstance().getXmlParsorPool().checkOut() as PoolableXmlParsor;
         this._xpParser.rootPath = this._scUi.uiModule.rootPath;
         this._xpParser.addEventListener(Event.COMPLETE,this.onParseComplete);
         this._xpParser.processFile(sUrl);
      }
      
      public function xmlRender(sXml:String, sName:String, scUi:UiRootContainer, oProperties:* = null) : void {
         this._nTimeStamp = getTimer();
         this._oProperties = oProperties;
         this._sName = sName;
         this._scUi = scUi;
         this._isXmlRender = true;
         this._xpParser = PoolsManager.getInstance().getXmlParsorPool().checkOut() as PoolableXmlParsor;
         this._xpParser.rootPath = this._scUi.uiModule.rootPath;
         this._xpParser.addEventListener(Event.COMPLETE,this.onParseComplete);
         this._xpParser.processXml(sXml);
      }
      
      public function uiRender(uiDef:UiDefinition, sName:String, scUi:UiRootContainer, oProperties:* = null) : void {
         var constKey:String = null;
         MEMORY_LOG_2[oProperties] = 1;
         if(!this._nTimeStamp)
         {
            this._nTimeStamp = getTimer();
         }
         if(scUi.parent)
         {
            scUi.tempHolder = new Sprite();
            scUi.parent.addChildAt(scUi.tempHolder,scUi.parent.getChildIndex(scUi));
            scUi.parent.removeChild(scUi);
         }
         if(!uiDef)
         {
            _log.error("Cannot render " + sName + " : no UI definition");
            dispatchEvent(new UiRenderEvent(Event.COMPLETE,false,false,this._scUi,this));
            return;
         }
         this._oProperties = oProperties;
         this._sName = sName;
         this._scUi = scUi;
         this._uiDef = uiDef;
         this._uiDef.name = sName;
         this._aFilnalizedLater = new Array();
         if(this._uiDef.scalable)
         {
            scUi.scaleX = Berilia.getInstance().scale;
            scUi.scaleY = Berilia.getInstance().scale;
         }
         this._scUi.scalable = this._uiDef.scalable;
         var constants:Array = [];
         for(constKey in this._uiDef.constants)
         {
            constants[constKey] = LangManager.getInstance().replaceKey(this._uiDef.constants[constKey]);
         }
         this._scUi.constants = constants;
         this._scUi.disableRender = true;
         this.makeScript();
         if(this._uiDef.modal)
         {
            this.makeModalContainer();
         }
         scUi.giveFocus = this._uiDef.giveFocus;
         scUi.transmitFocus = this._uiDef.transmitFocus;
         this.makeChilds(uiDef.graphicTree,scUi);
         this.makeShortcuts();
         this.fillUiScriptVar();
         if(this._scUi.uiClass)
         {
            this._scUi.properties = this._oProperties;
         }
         this._scUi.disableRender = false;
         scUi.render();
         if((scUi.strata == StrataEnum.STRATA_MEDIUM) && (scUi.giveFocus))
         {
            Berilia.getInstance().giveFocus(scUi);
         }
         this.finalizeContainer();
         this.buildTime = getTimer() - this._nTimeStamp;
         this.scriptTime = getTimer();
         this.scriptTime = getTimer() - this.scriptTime;
         scUi.iAmFinalized(null);
         if(!this._isXmlRender)
         {
            this.parsingTime = 0;
         }
         dispatchEvent(new UiRenderEvent(Event.COMPLETE,false,false,this._scUi,this));
         this._oProperties = null;
         this._sName = null;
         this._scUi = null;
         this._uiDef = null;
      }
      
      public function postInit(ui:UiRootContainer) : void {
         this._scUi = ui;
      }
      
      public function makeChilds(aChild:Array, gcContainer:GraphicContainer, preprocessLocation:Boolean = false) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function makeContainer(ce:ContainerElement) : Sprite {
         var container:GraphicContainer = null;
         var sProperty:String = null;
         switch(true)
         {
            case ce is ButtonElement:
               container = new ButtonContainer();
               break;
            case ce is StateContainerElement:
               container = new StateContainer();
               break;
            case ce is ScrollContainerElement:
               container = new ScrollContainer();
               this._scUi.addPostFinalizeComponent(container as FinalizableUIComponent);
               break;
            case ce is GridElement:
               container = new (getDefinitionByName(ce.className) as Class)();
               break;
            case ce is ContainerElement:
               container = new GraphicContainer();
               break;
         }
         for(sProperty in ce.properties)
         {
            if(ce.properties[sProperty] is String)
            {
               container[sProperty] = LangManager.getInstance().replaceKey(ce.properties[sProperty]);
            }
            else
            {
               container[sProperty] = ce.properties[sProperty];
            }
         }
         InternalComponentAccess.setProperty(container,"_uiRootContainer",this._scUi);
         return container as Sprite;
      }
      
      private function makeComponent(ce:ComponentElement) : Sprite {
         var uiComponent:UIComponent = null;
         var sProperty:String = null;
         var cComponent:Class = getDefinitionByName(ce.className) as Class;
         uiComponent = new cComponent() as UIComponent;
         InternalComponentAccess.setProperty(uiComponent,"_uiRootContainer",this._scUi);
         for(sProperty in ce.properties)
         {
            if(ce.properties[sProperty] is String)
            {
               uiComponent[sProperty] = LangManager.getInstance().replaceKey(ce.properties[sProperty]);
            }
            else
            {
               uiComponent[sProperty] = ce.properties[sProperty];
            }
         }
         return uiComponent as Sprite;
      }
      
      private function makeScript() : void {
         if(this._scriptClass)
         {
            this._scUi.uiClass = new this._scriptClass();
            ApiBinder.addApiData("currentUi",this._scUi);
            ApiBinder.initApi(this._scUi.uiClass,this._scUi.uiModule,UiModuleManager.getInstance().sharedDefinition);
            this._xmlClassDef = DescribeTypeCache.typeDescription(this._scUi.uiClass);
         }
         else
         {
            _log.warn("[Warning] " + this._scriptClass + " wasn\'t found for " + this._scUi.name);
         }
      }
      
      private function fillUiScriptVar() : void {
         var sVariable:String = null;
         var xmlVar:XMLList = null;
         var variable:XML = null;
         var i:String = null;
         var st:String = null;
         if(!this._xmlClassDef)
         {
            return;
         }
         this._xmlClassDef = DescribeTypeCache.typeDescription(this._scUi.uiClass);
         var variables:Array = new Array();
         for each(variable in this._xmlClassDef..variable)
         {
            variables[variable.@name.toString()] = true;
         }
         for(i in this._scUi.getElements())
         {
            sVariable = this._scUi.getElements()[i].name;
            if(variables[sVariable])
            {
               try
               {
                  this._scUi.uiClass[sVariable] = SecureCenter.secure(this._scUi.getElements()[i],this._scUi.uiModule.trusted);
               }
               catch(e:Error)
               {
                  if(e.getStackTrace())
                  {
                     st = e.getStackTrace();
                  }
                  else
                  {
                     st = "no stack trace available";
                  }
                  _log.error(sVariable + "in " + _scUi.name + " cannot be set (wrong type) " + st);
                  continue;
               }
            }
         }
      }
      
      private function makeShortcuts() : void {
         var sShortcutName:String = null;
         var listener:GenericListener = null;
      }
      
      private function finalizeContainer() : void {
         var i:uint = 0;
         while(i < this._aFilnalizedLater.length)
         {
            this._aFilnalizedLater[i].finalize();
            i++;
         }
         this._aFilnalizedLater = new Array();
      }
      
      private function makeModalContainer() : void {
         var fct:Function = null;
         var listener:GenericListener = null;
         if(this._scUi.uiClass != null)
         {
            if(this._scUi.uiClass.hasOwnProperty("onShortcut"))
            {
               fct = this._scUi.uiClass["onShortcut"];
            }
            else
            {
               fct = function(... args):Boolean
               {
                  return true;
               };
            }
            listener = new GenericListener("ALL",this._scUi.name,fct,this._scUi.depth,GenericListener.LISTENER_TYPE_UI,new WeakReference(this._scUi));
            BindsManager.getInstance().registerEvent(listener);
         }
         this._scUi.modal = true;
         if((this._uiDef.graphicTree) && (this._uiDef.graphicTree[0].name == "__modalContainer"))
         {
            return;
         }
         var modalContainer:ContainerElement = new ContainerElement();
         var size:GraphicSize = new GraphicSize();
         size.setX(1,GraphicSize.SIZE_PRC);
         size.setY(1,GraphicSize.SIZE_PRC);
         modalContainer.name = "__modalContainer";
         modalContainer.size = size.toSizeElement();
         modalContainer.properties["alpha"] = 0.3;
         modalContainer.properties["bgColor"] = 0;
         modalContainer.properties["mouseEnabled"] = true;
         modalContainer.strata = StrataEnum.STRATA_LOW;
         this._uiDef.graphicTree.unshift(modalContainer);
      }
      
      private function onParseComplete(e:ParsorEvent) : void {
         this.parsingTime = getTimer() - this._nTimeStamp;
         this._nTimeStamp = this.parsingTime + this._nTimeStamp;
         this._xpParser.removeEventListener(Event.COMPLETE,this.onParseComplete);
         PoolsManager.getInstance().getXmlParsorPool().checkIn(this._xpParser);
         this.uiRender(e.uiDefinition,this._sName,this._scUi,this._oProperties);
         this._isXmlRender = false;
      }
   }
}
