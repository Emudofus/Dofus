package com.ankamagames.berilia.managers
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.data.UiData;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.pools.PoolableUiRenderer;
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.berilia.types.data.PreCompiledUiModule;
   import flash.utils.getTimer;
   import com.ankamagames.berilia.pools.PoolsManager;
   import flash.events.Event;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.berilia.types.uiDefinition.UiDefinition;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.berilia.types.uiDefinition.BasicElement;
   import com.ankamagames.berilia.types.uiDefinition.ButtonElement;
   import com.ankamagames.berilia.types.uiDefinition.ComponentElement;
   import com.ankamagames.berilia.types.uiDefinition.ContainerElement;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.types.uiDefinition.StateContainerElement;
   import com.ankamagames.berilia.types.uiDefinition.GridElement;
   import com.ankamagames.berilia.types.uiDefinition.ScrollContainerElement;
   import com.ankamagames.berilia.types.uiDefinition.PropertyElement;
   import com.ankamagames.berilia.types.uiDefinition.LocationELement;
   import com.ankamagames.berilia.types.uiDefinition.SizeElement;
   
   public class UiRenderManager extends EventDispatcher
   {
      
      public function UiRenderManager() {
         super();
         if(_self != null)
         {
            throw new SingletonError("UiRenderManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            StoreDataManager.getInstance().registerClass(new UiDefinition());
            StoreDataManager.getInstance().registerClass(new BasicElement());
            StoreDataManager.getInstance().registerClass(new ButtonElement());
            StoreDataManager.getInstance().registerClass(new ComponentElement());
            StoreDataManager.getInstance().registerClass(new ContainerElement());
            StoreDataManager.getInstance().registerClass(new Uri());
            StoreDataManager.getInstance().registerClass(new StateContainerElement());
            StoreDataManager.getInstance().registerClass(new GridElement());
            StoreDataManager.getInstance().registerClass(new ScrollContainerElement());
            StoreDataManager.getInstance().registerClass(new PropertyElement());
            StoreDataManager.getInstance().registerClass(new LocationELement());
            StoreDataManager.getInstance().registerClass(new SizeElement());
            this._aRendering = new Array();
            this._aCache = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_DEFINITION,DATASTORE_CATEGORY_CACHE,new Array());
            this._aVersion = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_VERSION,DATASTORE_CATEGORY_VERSION,new Array());
            return;
         }
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      private static var _self:UiRenderManager;
      
      private static const DATASTORE_CATEGORY_CACHE:String = "cache";
      
      private static const DATASTORE_CATEGORY_APP_VERSION:String = "appVersion";
      
      private static const DATASTORE_CATEGORY_VERSION:String = "uiVersion";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiRenderManager));
      
      public static function getInstance() : UiRenderManager {
         if(_self == null)
         {
            _self = new UiRenderManager();
         }
         return _self;
      }
      
      private var _aCache:Array;
      
      private var _aVersion:Array;
      
      private var _aRendering:Array;
      
      private var _lastRenderStart:uint;
      
      public function loadUi(uiData:UiData, spContainer:UiRootContainer, oProperties:*=null, checkCache:Boolean=true) : void {
         var uiRenderer:PoolableUiRenderer = null;
         var sId:String = uiData.file;
         if(!sId)
         {
            sId = uiData.name;
         }
         if(BeriliaConstants.USE_UI_CACHE)
         {
            if(uiData.module is PreCompiledUiModule)
            {
               this._aCache[sId] = PreCompiledUiModule(uiData.module).getDefinition(uiData);
            }
            if((!(this._aCache[sId] == null)) && (this._aCache[sId].useCache))
            {
               this._lastRenderStart = getTimer();
               uiRenderer = PoolsManager.getInstance().getUiRendererPool().checkOut() as PoolableUiRenderer;
               uiRenderer.addEventListener(Event.COMPLETE,this.onUiRender);
               uiRenderer.fromCache = true;
               uiRenderer.script = uiData.uiClass;
               uiRenderer.uiRender(this._aCache[sId],this._aCache[sId].name,spContainer,oProperties);
               return;
            }
            if((this._aRendering[sId]) && (!this._aCache[sId]) && (checkCache))
            {
               this._aRendering[sId].push(new RenderQueueItem(uiData,spContainer,oProperties));
               return;
            }
         }
         else
         {
            this._aCache = new Array();
         }
         if(((!this._aCache[sId]) || (this._aCache[sId] && this._aCache[sId].useCache)) && (checkCache))
         {
            this._aRendering[sId] = new Array();
         }
         if(uiData.file)
         {
            this._lastRenderStart = getTimer();
            uiRenderer = PoolsManager.getInstance().getUiRendererPool().checkOut() as PoolableUiRenderer;
            uiRenderer.addEventListener(Event.COMPLETE,this.onUiRender);
            uiRenderer.script = uiData.uiClass;
            uiRenderer.fileRender(uiData.file,sId,spContainer,oProperties);
         }
         else
         {
            if(uiData.xml)
            {
               this._lastRenderStart = getTimer();
               uiRenderer = PoolsManager.getInstance().getUiRendererPool().checkOut() as PoolableUiRenderer;
               uiRenderer.addEventListener(Event.COMPLETE,this.onUiRender);
               uiRenderer.script = uiData.uiClass;
               uiRenderer.xmlRender(uiData.xml,sId,spContainer,oProperties);
            }
         }
      }
      
      public function clearCache() : void {
         this._aVersion = new Array();
         this._aCache = new Array();
         TemplateManager.getInstance().init();
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_VERSION,DATASTORE_CATEGORY_VERSION,this._aVersion);
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION,DATASTORE_CATEGORY_CACHE,this._aCache);
      }
      
      public function clearCacheFromId(id:String) : void {
         delete this._aCache[[id]];
         delete this._aVersion[[id]];
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_VERSION,DATASTORE_CATEGORY_VERSION,this._aVersion);
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION,DATASTORE_CATEGORY_CACHE,this._aCache);
      }
      
      public function getUiDefinition(uiId:String) : UiDefinition {
         return this._aCache[uiId];
      }
      
      public function updateCachedUiDefinition() : void {
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION,DATASTORE_CATEGORY_CACHE,this._aCache);
      }
      
      public function getUiVersion(id:String) : String {
         return this._aVersion[id];
      }
      
      public function setUiVersion(id:String, version:String) : void {
         this._aVersion[id] = version;
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_VERSION,DATASTORE_CATEGORY_VERSION,this._aVersion);
      }
      
      public function setUiDefinition(uiDefinition:UiDefinition) : void {
         this._aCache[uiDefinition.name] = uiDefinition;
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION,DATASTORE_CATEGORY_CACHE,this._aCache);
      }
      
      public function cancelRender(uiData:UiData) : void {
         if(uiData)
         {
            delete this._aRendering[[uiData.file]];
         }
      }
      
      private function processWaitingUi(sId:String, checkCache:Boolean=true) : void {
         var currentUi:RenderQueueItem = null;
         if(!this._aRendering[sId])
         {
            return;
         }
         while((this._aRendering[sId]) && (this._aRendering[sId].length))
         {
            currentUi = this._aRendering[sId].shift();
            this._lastRenderStart = getTimer();
            this.loadUi(currentUi.uiData,currentUi.container,currentUi.properties,checkCache);
         }
         delete this._aRendering[[sId]];
      }
      
      private function onUiRender(e:UiRenderEvent) : void {
         var uiDef:UiDefinition = e.uiRenderer.uiDefinition;
         if((((!(e.uiTarget.uiData.module is PreCompiledUiModule)) && (uiDef)) && (uiDef.useCache)) && (!this._aCache[uiDef.name]) && (BeriliaConstants.USE_UI_CACHE))
         {
            this._aCache[uiDef.name] = uiDef;
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION,DATASTORE_CATEGORY_CACHE,this._aCache);
         }
         if(uiDef)
         {
            _log.info(uiDef.name + " rendered in " + (getTimer() - this._lastRenderStart) + " ms (parsing: " + e.uiRenderer.parsingTime + " ms, build: " + e.uiRenderer.buildTime + " ms, script:" + e.uiRenderer.scriptTime + " ms )");
         }
         PoolsManager.getInstance().getUiRendererPool().checkIn(e.uiRenderer as PoolableUiRenderer);
         dispatchEvent(new UiRenderEvent(UiRenderEvent.UIRenderComplete,e.bubbles,e.cancelable,e.uiTarget,e.uiRenderer));
         if(uiDef)
         {
            this.processWaitingUi(uiDef.name,uiDef.useCache);
         }
      }
   }
}
import com.ankamagames.berilia.types.graphic.UiRootContainer;
import com.ankamagames.berilia.types.data.UiData;
import com.ankamagames.berilia.managers.UiRenderManager;

class RenderQueueItem extends Object
{
   
   function RenderQueueItem(uiData:UiData, cont:UiRootContainer, prop:*) {
      super();
      this.container = cont;
      this.properties = prop;
      this.uiData = uiData;
      UiRenderManager.MEMORY_LOG[this] = 1;
   }
   
   public var container:UiRootContainer;
   
   public var properties;
   
   public var uiData:UiData;
}
