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
      
      public function loadUi(param1:UiData, param2:UiRootContainer, param3:*=null, param4:Boolean=true) : void {
         var _loc5_:PoolableUiRenderer = null;
         var _loc6_:String = param1.file;
         if(!_loc6_)
         {
            _loc6_ = param1.name;
         }
         if(BeriliaConstants.USE_UI_CACHE)
         {
            if(param1.module is PreCompiledUiModule)
            {
               this._aCache[_loc6_] = PreCompiledUiModule(param1.module).getDefinition(param1);
            }
            if(!(this._aCache[_loc6_] == null) && (this._aCache[_loc6_].useCache))
            {
               this._lastRenderStart = getTimer();
               _loc5_ = PoolsManager.getInstance().getUiRendererPool().checkOut() as PoolableUiRenderer;
               _loc5_.addEventListener(Event.COMPLETE,this.onUiRender);
               _loc5_.fromCache = true;
               _loc5_.script = param1.uiClass;
               _loc5_.uiRender(this._aCache[_loc6_],this._aCache[_loc6_].name,param2,param3);
               return;
            }
            if((this._aRendering[_loc6_]) && (!this._aCache[_loc6_]) && (param4))
            {
               this._aRendering[_loc6_].push(new RenderQueueItem(param1,param2,param3));
               return;
            }
         }
         else
         {
            this._aCache = new Array();
         }
         if(((!this._aCache[_loc6_]) || (this._aCache[_loc6_] && this._aCache[_loc6_].useCache)) && (param4))
         {
            this._aRendering[_loc6_] = new Array();
         }
         if(param1.file)
         {
            this._lastRenderStart = getTimer();
            _loc5_ = PoolsManager.getInstance().getUiRendererPool().checkOut() as PoolableUiRenderer;
            _loc5_.addEventListener(Event.COMPLETE,this.onUiRender);
            _loc5_.script = param1.uiClass;
            _loc5_.fileRender(param1.file,_loc6_,param2,param3);
         }
         else
         {
            if(param1.xml)
            {
               this._lastRenderStart = getTimer();
               _loc5_ = PoolsManager.getInstance().getUiRendererPool().checkOut() as PoolableUiRenderer;
               _loc5_.addEventListener(Event.COMPLETE,this.onUiRender);
               _loc5_.script = param1.uiClass;
               _loc5_.xmlRender(param1.xml,_loc6_,param2,param3);
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
      
      public function clearCacheFromId(param1:String) : void {
         delete this._aCache[[param1]];
         delete this._aVersion[[param1]];
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_VERSION,DATASTORE_CATEGORY_VERSION,this._aVersion);
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION,DATASTORE_CATEGORY_CACHE,this._aCache);
      }
      
      public function getUiDefinition(param1:String) : UiDefinition {
         return this._aCache[param1];
      }
      
      public function updateCachedUiDefinition() : void {
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION,DATASTORE_CATEGORY_CACHE,this._aCache);
      }
      
      public function getUiVersion(param1:String) : String {
         return this._aVersion[param1];
      }
      
      public function setUiVersion(param1:String, param2:String) : void {
         this._aVersion[param1] = param2;
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_VERSION,DATASTORE_CATEGORY_VERSION,this._aVersion);
      }
      
      public function setUiDefinition(param1:UiDefinition) : void {
         this._aCache[param1.name] = param1;
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION,DATASTORE_CATEGORY_CACHE,this._aCache);
      }
      
      public function cancelRender(param1:UiData) : void {
         if(param1)
         {
            delete this._aRendering[[param1.file]];
         }
      }
      
      private function processWaitingUi(param1:String, param2:Boolean=true) : void {
         var _loc3_:RenderQueueItem = null;
         if(!this._aRendering[param1])
         {
            return;
         }
         while((this._aRendering[param1]) && (this._aRendering[param1].length))
         {
            _loc3_ = this._aRendering[param1].shift();
            this._lastRenderStart = getTimer();
            this.loadUi(_loc3_.uiData,_loc3_.container,_loc3_.properties,param2);
         }
         delete this._aRendering[[param1]];
      }
      
      private function onUiRender(param1:UiRenderEvent) : void {
         var _loc2_:UiDefinition = param1.uiRenderer.uiDefinition;
         if((((!(param1.uiTarget.uiData.module is PreCompiledUiModule)) && (_loc2_)) && (_loc2_.useCache)) && (!this._aCache[_loc2_.name]) && (BeriliaConstants.USE_UI_CACHE))
         {
            this._aCache[_loc2_.name] = _loc2_;
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION,DATASTORE_CATEGORY_CACHE,this._aCache);
         }
         if(_loc2_)
         {
            _log.info(_loc2_.name + " rendered in " + (getTimer() - this._lastRenderStart) + " ms (parsing: " + param1.uiRenderer.parsingTime + " ms, build: " + param1.uiRenderer.buildTime + " ms, script:" + param1.uiRenderer.scriptTime + " ms )");
         }
         PoolsManager.getInstance().getUiRendererPool().checkIn(param1.uiRenderer as PoolableUiRenderer);
         dispatchEvent(new UiRenderEvent(UiRenderEvent.UIRenderComplete,param1.bubbles,param1.cancelable,param1.uiTarget,param1.uiRenderer));
         if(_loc2_)
         {
            this.processWaitingUi(_loc2_.name,_loc2_.useCache);
         }
      }
   }
}
import com.ankamagames.berilia.types.graphic.UiRootContainer;
import com.ankamagames.berilia.types.data.UiData;
import com.ankamagames.berilia.managers.UiRenderManager;

class RenderQueueItem extends Object
{
   
   function RenderQueueItem(param1:UiData, param2:UiRootContainer, param3:*) {
      super();
      this.container = param2;
      this.properties = param3;
      this.uiData = param1;
      UiRenderManager.MEMORY_LOG[this] = 1;
   }
   
   public var container:UiRootContainer;
   
   public var properties;
   
   public var uiData:UiData;
}
