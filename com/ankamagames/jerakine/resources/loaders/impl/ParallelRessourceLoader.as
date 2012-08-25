package com.ankamagames.jerakine.resources.loaders.impl
{
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class ParallelRessourceLoader extends AbstractRessourceLoader implements IResourceLoader, IResourceObserver
    {
        private var _maxParallel:uint;
        private var _uris:Array;
        private var _currentlyLoading:uint;
        private var _loadDictionnary:Dictionary;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function ParallelRessourceLoader(param1:uint)
        {
            this._maxParallel = param1;
            this._loadDictionnary = new Dictionary(true);
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function load(param1, param2:ICache = null, param3:Class = null, param4:Boolean = false) : void
        {
            var _loc_5:Array = null;
            var _loc_7:Uri = null;
            if (param1 is Uri)
            {
                _loc_5 = [param1];
            }
            else if (param1 is Array)
            {
                _loc_5 = param1;
            }
            else
            {
                throw new ArgumentError("URIs must be an array or an Uri instance.");
            }
            var _loc_6:Boolean = false;
            if (this._uris != null)
            {
                for each (_loc_7 in _loc_5)
                {
                    
                    this._uris.push({uri:_loc_7, forcedAdapter:param3, singleFile:param4});
                }
                if (this._currentlyLoading == 0)
                {
                    _loc_6 = true;
                }
            }
            else
            {
                this._uris = new Array();
                for each (_loc_7 in _loc_5)
                {
                    
                    this._uris.push({uri:_loc_7, forcedAdapter:param3, singleFile:param4});
                }
                _loc_6 = true;
            }
            _cache = param2;
            _completed = false;
            _filesTotal = _filesTotal + this._uris.length;
            if (_loc_6)
            {
                this.loadNextUris();
            }
            return;
        }// end function

        public function cancel() : void
        {
            var _loc_1:IProtocol = null;
            for each (_loc_1 in this._loadDictionnary)
            {
                
                if (_loc_1)
                {
                    _loc_1.free();
                    _loc_1.cancel();
                }
            }
            this._loadDictionnary = new Dictionary();
            this._currentlyLoading = 0;
            this._uris = [];
            return;
        }// end function

        private function loadNextUris() : void
        {
            var _loc_3:Object = null;
            var _loc_4:IProtocol = null;
            if (this._uris.length == 0)
            {
                this._uris = null;
                return;
            }
            this._currentlyLoading = Math.min(this._maxParallel, this._uris.length);
            var _loc_1:* = this._currentlyLoading;
            var _loc_2:uint = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this._uris.shift();
                if (!checkCache(_loc_3.uri))
                {
                    _loc_4 = ProtocolFactory.getProtocol(_loc_3.uri);
                    this._loadDictionnary[_loc_3.uri] = _loc_4;
                    _loc_4.load(_loc_3.uri, this, hasEventListener(ResourceProgressEvent.PROGRESS), _cache, _loc_3.forcedAdapter, _loc_3.singleFile);
                }
                else
                {
                    this.decrementLoads();
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function decrementLoads() : void
        {
            var _loc_1:String = this;
            var _loc_2:* = this._currentlyLoading - 1;
            _loc_1._currentlyLoading = _loc_2;
            if (this._currentlyLoading == 0)
            {
                this.loadNextUris();
            }
            return;
        }// end function

        override public function onLoaded(param1:Uri, param2:uint, param3) : void
        {
            super.onLoaded(param1, param2, param3);
            delete this._loadDictionnary[param1];
            this.decrementLoads();
            return;
        }// end function

        override public function onFailed(param1:Uri, param2:String, param3:uint) : void
        {
            super.onFailed(param1, param2, param3);
            delete this._loadDictionnary[param1];
            this.decrementLoads();
            return;
        }// end function

    }
}
