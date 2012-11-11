package com.ankamagames.berilia.managers
{
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.template.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.garbage.*;
    import com.ankamagames.jerakine.newCache.impl.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import flash.events.*;
    import flash.utils.*;

    public class TemplateManager extends EventDispatcher
    {
        private var _aTemplates:Array;
        private var _loader:IResourceLoader;
        private var _cache:Cache;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(TemplateManager));
        private static var _self:TemplateManager;

        public function TemplateManager()
        {
            if (_self != null)
            {
                throw new BeriliaError("TemplateManager is a singleton and should not be instanciated directly.");
            }
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.objectLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.objectLoadedFailed);
            this.init();
            return;
        }// end function

        public function init() : void
        {
            this._aTemplates = new Array();
            this._cache = Cache.create(30, new LruGarbageCollector(), getQualifiedClassName(this));
            return;
        }// end function

        public function getTemplate(param1:String) : XmlTemplate
        {
            var _loc_2:* = param1.split("/");
            var _loc_3:* = _loc_2[(_loc_2.length - 1)];
            if (_loc_3.indexOf(".xml") == -1)
            {
                _loc_3 = _loc_3 + ".xml";
            }
            return this._aTemplates[_loc_3];
        }// end function

        public function isRegistered(param1:String) : Boolean
        {
            var _loc_2:* = param1.split("/");
            var _loc_3:* = _loc_2[(_loc_2.length - 1)];
            return this._aTemplates[_loc_3] != null;
        }// end function

        public function isLoaded(param1:String) : Boolean
        {
            var _loc_2:* = param1.split("/");
            var _loc_3:* = _loc_2[(_loc_2.length - 1)];
            return this._aTemplates[_loc_3] is XmlTemplate;
        }// end function

        public function areLoaded(param1:Array) : Boolean
        {
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                if (!this.isLoaded(param1[_loc_2]))
                {
                    return false;
                }
                _loc_2 = _loc_2 + 1;
            }
            return param1.length != 0;
        }// end function

        public function register(param1:String) : void
        {
            var _loc_2:* = param1.split("/");
            var _loc_3:* = _loc_2[(_loc_2.length - 1)];
            if (this.isRegistered(_loc_3))
            {
                if (this.isLoaded(_loc_3))
                {
                    dispatchEvent(new TemplateLoadedEvent(param1));
                }
                return;
            }
            this._aTemplates[_loc_3] = false;
            this._loader.load(new Uri(param1));
            return;
        }// end function

        public function objectLoaded(event:ResourceLoadedEvent) : void
        {
            this._aTemplates[event.uri.fileName] = new XmlTemplate(event.resource, event.uri.fileName);
            dispatchEvent(new TemplateLoadedEvent(event.uri.uri));
            return;
        }// end function

        public function objectLoadedFailed(event:ResourceErrorEvent) : void
        {
            _log.debug("objectLoadedFailed : " + event.uri + " : " + event.errorMsg);
            return;
        }// end function

        public static function getInstance() : TemplateManager
        {
            if (_self == null)
            {
                _self = new TemplateManager;
            }
            return _self;
        }// end function

    }
}
