package com.ankamagames.berilia.managers
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.text.*;
    import flash.utils.*;

    public class CssManager extends Object
    {
        private var _aCss:Array;
        private var _aWaiting:Array;
        private var _aMultiWaiting:Array;
        private var _loader:IResourceLoader;
        private var _aLoadingFile:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CssManager));
        private static const CSS_ARRAY_KEY:String = "cssFilesContents";
        private static var _self:CssManager;
        private static var _useCache:Boolean = true;

        public function CssManager()
        {
            if (_self)
            {
                throw new SingletonError();
            }
            this._aCss = new Array();
            this._aWaiting = new Array();
            this._aMultiWaiting = new Array();
            this._aLoadingFile = new Array();
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.complete);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.error);
            return;
        }// end function

        public function load(param1) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = 0;
            var _loc_3:* = new Array();
            if (param1 is String)
            {
                _loc_2 = new Uri(param1);
                if (!this.exists(_loc_2.uri) && !this.inQueue(_loc_2.uri))
                {
                    _loc_3.push(_loc_2);
                    this._aLoadingFile[_loc_2.uri] = true;
                }
            }
            else if (param1 is Array)
            {
                _loc_4 = 0;
                while (_loc_4 < (param1 as Array).length)
                {
                    
                    _loc_2 = new Uri(param1[_loc_4]);
                    if (!this.exists(_loc_2.uri) && !this.inQueue(_loc_2.uri))
                    {
                        this._aLoadingFile[_loc_2.uri] = true;
                        _loc_3.push(_loc_2);
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            if (_loc_3.length)
            {
                this._loader.load(_loc_3);
            }
            return;
        }// end function

        public function exists(param1:String) : Boolean
        {
            var _loc_2:* = new Uri(param1);
            return this._aCss[_loc_2.uri] != null;
        }// end function

        public function inQueue(param1:String) : Boolean
        {
            return this._aLoadingFile[param1];
        }// end function

        public function askCss(param1:String, param2:Callback) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.exists(param1))
            {
                param2.exec();
            }
            else
            {
                _loc_3 = new Uri(param1);
                if (!this._aWaiting[_loc_3.uri])
                {
                    this._aWaiting[_loc_3.uri] = new Array();
                }
                this._aWaiting[_loc_3.uri].push(param2);
                if (param1.indexOf(",") != -1)
                {
                    _loc_4 = param1.split(",");
                    this._aMultiWaiting[_loc_3.uri] = _loc_4;
                    this.load(_loc_4);
                }
                else
                {
                    this.load(param1);
                }
            }
            return;
        }// end function

        public function preloadCss(param1:String) : void
        {
            if (!this.exists(param1))
            {
                this.load(param1);
            }
            return;
        }// end function

        public function getCss(param1:String) : ExtendedStyleSheet
        {
            var _loc_2:* = new Uri(param1);
            return this._aCss[_loc_2.uri];
        }// end function

        public function merge(param1:Array) : ExtendedStyleSheet
        {
            var _loc_2:* = "";
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2 = _loc_2 + ((_loc_3 ? (",") : ("")) + param1[_loc_3].url);
                _loc_3 = _loc_3 + 1;
            }
            if (this.exists(_loc_2))
            {
                return this.getCss(_loc_2);
            }
            var _loc_4:* = new ExtendedStyleSheet(_loc_2);
            var _loc_5:* = param1.length - 1;
            while ((_loc_5 - 1) > -1)
            {
                
                _loc_4.merge(param1[_loc_5] as ExtendedStyleSheet);
                _loc_5 = _loc_5 - 1;
            }
            this._aCss[_loc_2] = _loc_4;
            return _loc_4;
        }// end function

        protected function init() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (_useCache)
            {
                _loc_1 = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_CSS, CSS_ARRAY_KEY, new Array());
                for (_loc_2 in _loc_1)
                {
                    
                    this.parseCss(_loc_2, _loc_1[_loc_2]);
                }
            }
            return;
        }// end function

        private function parseCss(param1:String, param2:String) : void
        {
            var _loc_3:* = new Uri(param1);
            var _loc_4:* = new ExtendedStyleSheet(_loc_3.uri);
            this._aCss[_loc_3.uri] = _loc_4;
            _loc_4.addEventListener(CssEvent.CSS_PARSED, this.onCssParsed);
            _loc_4.parseCSS(param2);
            return;
        }// end function

        private function updateWaitingMultiUrl(param1:String) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            for (_loc_3 in this._aMultiWaiting)
            {
                
                if (this._aMultiWaiting[_loc_3])
                {
                    _loc_2 = true;
                    _loc_4 = 0;
                    while (_loc_4 < this._aMultiWaiting[_loc_3].length)
                    {
                        
                        if (this._aMultiWaiting[_loc_3][_loc_4] == param1)
                        {
                            this._aMultiWaiting[_loc_3][_loc_4] = true;
                        }
                        _loc_2 = _loc_2 && this._aMultiWaiting[_loc_3][_loc_4] === true;
                        _loc_4 = _loc_4 + 1;
                    }
                    if (_loc_2)
                    {
                        delete this._aMultiWaiting[_loc_3];
                        _loc_5 = _loc_3.split(",");
                        _loc_6 = new Array();
                        _loc_7 = 0;
                        while (_loc_7 < _loc_5.length)
                        {
                            
                            _loc_6.push(this.getCss(_loc_5[_loc_7]));
                            _loc_7 = _loc_7 + 1;
                        }
                        this.merge(_loc_6);
                        this.dispatchWaitingCallbabk(_loc_3);
                    }
                }
            }
            return;
        }// end function

        private function dispatchWaitingCallbabk(param1:String) : void
        {
            var _loc_2:* = 0;
            if (this._aWaiting[param1])
            {
                _loc_2 = 0;
                while (_loc_2 < this._aWaiting[param1].length)
                {
                    
                    Callback(this._aWaiting[param1][_loc_2]).exec();
                    _loc_2 = _loc_2 + 1;
                }
                delete this._aWaiting[param1];
            }
            return;
        }// end function

        protected function complete(event:ResourceLoadedEvent) : void
        {
            var _loc_2:* = null;
            if (_useCache)
            {
                _loc_2 = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_CSS, CSS_ARRAY_KEY, new Array());
                _loc_2[event.uri.uri] = event.resource;
                StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_CSS, CSS_ARRAY_KEY, _loc_2);
            }
            this._aLoadingFile[event.uri.uri] = false;
            this.parseCss(event.uri.uri, event.resource);
            return;
        }// end function

        protected function error(event:ResourceErrorEvent) : void
        {
            ErrorManager.addError("Impossible de trouver la feuille de style (url: " + event.uri + ")");
            this._aLoadingFile[event.uri.uri] = false;
            delete this._aWaiting[event.uri.uri];
            return;
        }// end function

        private function onCssParsed(event:CssEvent) : void
        {
            event.stylesheet.removeEventListener(CssEvent.CSS_PARSED, this.onCssParsed);
            var _loc_2:* = new Uri(event.stylesheet.url);
            this.dispatchWaitingCallbabk(_loc_2.uri);
            this.updateWaitingMultiUrl(_loc_2.uri);
            return;
        }// end function

        public static function getInstance() : CssManager
        {
            if (!_self)
            {
                _self = new CssManager;
            }
            return _self;
        }// end function

        public static function set useCache(param1:Boolean) : void
        {
            _useCache = param1;
            if (!param1)
            {
                clear();
            }
            return;
        }// end function

        public static function get useCache() : Boolean
        {
            return _useCache;
        }// end function

        public static function clear() : void
        {
            StoreDataManager.getInstance().clear(BeriliaConstants.DATASTORE_UI_CSS);
            return;
        }// end function

    }
}
