package com.ankamagames.berilia.managers
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.pools.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.types.uiDefinition.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.events.*;
    import flash.utils.*;

    public class UiRenderManager extends EventDispatcher
    {
        private var _aCache:Array;
        private var _aVersion:Array;
        private var _aRendering:Array;
        private var _lastRenderStart:uint;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        private static var _self:UiRenderManager;
        private static const DATASTORE_CATEGORY_CACHE:String = "cache";
        private static const DATASTORE_CATEGORY_APP_VERSION:String = "appVersion";
        private static const DATASTORE_CATEGORY_VERSION:String = "uiVersion";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(UiRenderManager));

        public function UiRenderManager()
        {
            if (_self != null)
            {
                throw new SingletonError("UiRenderManager is a singleton and should not be instanciated directly.");
            }
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
            this._aCache = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_DEFINITION, DATASTORE_CATEGORY_CACHE, new Array());
            this._aVersion = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_VERSION, DATASTORE_CATEGORY_VERSION, new Array());
            return;
        }// end function

        public function loadUi(param1:UiData, param2:UiRootContainer, param3 = null, param4:Boolean = true) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = param1.file;
            if (!param1.file)
            {
                _loc_6 = param1.name;
            }
            if (BeriliaConstants.USE_UI_CACHE)
            {
                if (param1.module is PreCompiledUiModule)
                {
                    this._aCache[_loc_6] = PreCompiledUiModule(param1.module).getDefinition(param1);
                }
                if (this._aCache[_loc_6] != null && this._aCache[_loc_6].useCache)
                {
                    this._lastRenderStart = getTimer();
                    _loc_5 = PoolsManager.getInstance().getUiRendererPool().checkOut() as PoolableUiRenderer;
                    _loc_5.addEventListener(Event.COMPLETE, this.onUiRender);
                    _loc_5.fromCache = true;
                    _loc_5.script = param1.uiClass;
                    _loc_5.uiRender(this._aCache[_loc_6], this._aCache[_loc_6].name, param2, param3);
                    return;
                }
                if (this._aRendering[_loc_6] && !this._aCache[_loc_6] && param4)
                {
                    this._aRendering[_loc_6].push(new RenderQueueItem(param1, param2, param3));
                    return;
                }
            }
            else
            {
                this._aCache = new Array();
            }
            if ((!this._aCache[_loc_6] || this._aCache[_loc_6] && this._aCache[_loc_6].useCache) && param4)
            {
                this._aRendering[_loc_6] = new Array();
            }
            if (param1.file)
            {
                this._lastRenderStart = getTimer();
                _loc_5 = PoolsManager.getInstance().getUiRendererPool().checkOut() as PoolableUiRenderer;
                _loc_5.addEventListener(Event.COMPLETE, this.onUiRender);
                _loc_5.script = param1.uiClass;
                _loc_5.fileRender(param1.file, _loc_6, param2, param3);
            }
            else if (param1.xml)
            {
                this._lastRenderStart = getTimer();
                _loc_5 = PoolsManager.getInstance().getUiRendererPool().checkOut() as PoolableUiRenderer;
                _loc_5.addEventListener(Event.COMPLETE, this.onUiRender);
                _loc_5.script = param1.uiClass;
                _loc_5.xmlRender(param1.xml, _loc_6, param2, param3);
            }
            return;
        }// end function

        public function clearCache() : void
        {
            this._aVersion = new Array();
            this._aCache = new Array();
            TemplateManager.getInstance().init();
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_VERSION, DATASTORE_CATEGORY_VERSION, this._aVersion);
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION, DATASTORE_CATEGORY_CACHE, this._aCache);
            return;
        }// end function

        public function clearCacheFromId(param1:String) : void
        {
            delete this._aCache[param1];
            delete this._aVersion[param1];
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_VERSION, DATASTORE_CATEGORY_VERSION, this._aVersion);
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION, DATASTORE_CATEGORY_CACHE, this._aCache);
            return;
        }// end function

        public function getUiDefinition(param1:String) : UiDefinition
        {
            return this._aCache[param1];
        }// end function

        public function updateCachedUiDefinition() : void
        {
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION, DATASTORE_CATEGORY_CACHE, this._aCache);
            return;
        }// end function

        public function getUiVersion(param1:String) : String
        {
            return this._aVersion[param1];
        }// end function

        public function setUiVersion(param1:String, param2:String) : void
        {
            this._aVersion[param1] = param2;
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_VERSION, DATASTORE_CATEGORY_VERSION, this._aVersion);
            return;
        }// end function

        public function setUiDefinition(param1:UiDefinition) : void
        {
            this._aCache[param1.name] = param1;
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION, DATASTORE_CATEGORY_CACHE, this._aCache);
            return;
        }// end function

        public function cancelRender(param1:UiData) : void
        {
            if (param1)
            {
                delete this._aRendering[param1.file];
            }
            return;
        }// end function

        private function processWaitingUi(param1:String, param2:Boolean = true) : void
        {
            var _loc_3:* = null;
            if (!this._aRendering[param1])
            {
                return;
            }
            while (this._aRendering[param1] && this._aRendering[param1].length)
            {
                
                _loc_3 = this._aRendering[param1].shift();
                this._lastRenderStart = getTimer();
                this.loadUi(_loc_3.uiData, _loc_3.container, _loc_3.properties, param2);
            }
            delete this._aRendering[param1];
            return;
        }// end function

        private function onUiRender(event:UiRenderEvent) : void
        {
            var _loc_2:* = event.uiRenderer.uiDefinition;
            if (!(event.uiTarget.uiData.module is PreCompiledUiModule) && _loc_2 && _loc_2.useCache && !this._aCache[_loc_2.name] && BeriliaConstants.USE_UI_CACHE)
            {
                this._aCache[_loc_2.name] = _loc_2;
                StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION, DATASTORE_CATEGORY_CACHE, this._aCache);
            }
            if (_loc_2)
            {
                _log.info(_loc_2.name + " rendered in " + (getTimer() - this._lastRenderStart) + " ms (parsing: " + event.uiRenderer.parsingTime + " ms, build: " + event.uiRenderer.buildTime + " ms, script:" + event.uiRenderer.scriptTime + " ms )");
            }
            PoolsManager.getInstance().getUiRendererPool().checkIn(event.uiRenderer as PoolableUiRenderer);
            dispatchEvent(new UiRenderEvent(UiRenderEvent.UIRenderComplete, event.bubbles, event.cancelable, event.uiTarget, event.uiRenderer));
            if (_loc_2)
            {
                this.processWaitingUi(_loc_2.name, _loc_2.useCache);
            }
            return;
        }// end function

        public static function getInstance() : UiRenderManager
        {
            if (_self == null)
            {
                _self = new UiRenderManager;
            }
            return _self;
        }// end function

    }
}

import com.ankamagames.berilia.*;

import com.ankamagames.berilia.pools.*;

import com.ankamagames.berilia.types.data.*;

import com.ankamagames.berilia.types.event.*;

import com.ankamagames.berilia.types.graphic.*;

import com.ankamagames.berilia.types.uiDefinition.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.managers.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.utils.errors.*;

import flash.events.*;

import flash.utils.*;

class RenderQueueItem extends Object
{
    public var container:UiRootContainer;
    public var properties:Object;
    public var uiData:UiData;

    function RenderQueueItem(param1:UiData, param2:UiRootContainer, param3)
    {
        this.container = param2;
        this.properties = param3;
        this.uiData = param1;
        UiRenderManager.MEMORY_LOG[this] = 1;
        return;
    }// end function

}

