package com.ankamagames.tiphon.engine
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.impl.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tiphon.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.*;
    import flash.events.*;
    import flash.utils.*;

    public class LibrariesManager extends EventDispatcher
    {
        private var _aResources:Dictionary;
        private var _aResourcesUri:Array;
        private var _aResourceStates:Array;
        private var _aWaiting:Array;
        private var _loader:IResourceLoader;
        private var _waitingResources:Vector.<Uri>;
        private var _type:uint;
        private var _GarbageCollectorTimer:Timer;
        private var _currentCacheSize:int = 0;
        private var _libCurrentlyUsed:Dictionary;
        public var name:String;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(LibrariesManager));
        public static const TYPE_BONE:uint = 0;
        public static const TYPE_SKIN:uint = 1;
        private static var _cache:InfiniteCache = new InfiniteCache();
        private static var _uri:Uri;
        private static var numLM:int = 0;

        public function LibrariesManager(param1:String, param2:uint)
        {
            this._waitingResources = new Vector.<Uri>;
            this._libCurrentlyUsed = new Dictionary(true);
            this.name = param1;
            this._aResources = new Dictionary();
            this._aResourceStates = new Array();
            this._aWaiting = new Array();
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoadResource);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadFailedResource);
            this._type = param2;
            var _loc_4:* = numLM + 1;
            numLM = _loc_4;
            return;
        }// end function

        public function addResource(param1:uint, param2:Uri) : void
        {
            var _loc_3:* = null;
            if (param2 == null)
            {
                param2 = new Uri(TiphonConstants.SWF_SKULL_PATH + "666.swl");
            }
            if (!this._aResources[param1])
            {
                if (this._type == TYPE_BONE)
                {
                    _loc_3 = new AnimLibrary(param1, true);
                }
                else
                {
                    _loc_3 = new GraphicLibrary(param1, false);
                }
                this._aResources[param1] = _loc_3;
            }
            else
            {
                _loc_3 = this._aResources[param1];
            }
            if (!_loc_3.hasSwl(param2))
            {
                if (param2.tag == null)
                {
                    param2.tag = new Object();
                }
                param2.tag.id = param1;
                _log.info("[" + this.name + "] Load " + param2);
                _loc_3.updateSwfState(param2);
                this._waitingResources.push(param2);
            }
            return;
        }// end function

        public function askResource(param1:uint, param2:String, param3:Callback, param4:Callback = null) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_8:* = null;
            var _loc_9:* = false;
            var _loc_10:* = 0;
            if (!this.hasResource(param1, param2))
            {
                _log.error("Tiphon cache does not contains ressource " + param1);
            }
            else
            {
                _loc_5 = this._aResources[param1];
                if (_loc_5.hasClassAvaible(param2))
                {
                    param3.exec();
                }
                else
                {
                    if (!this._aWaiting[param1])
                    {
                        this._aWaiting[param1] = new Object();
                        this._aWaiting[param1]["ok"] = new Array();
                        this._aWaiting[param1]["ko"] = new Array();
                    }
                    _loc_6 = this._aWaiting[param1]["ok"];
                    _loc_7 = true;
                    for each (_loc_8 in _loc_6)
                    {
                        
                        if (_loc_8.method == param3.method && param3.args.length == _loc_8.args.length)
                        {
                            _loc_9 = true;
                            while (_loc_10 < _loc_8.args.length)
                            {
                                
                                if (_loc_8.args[_loc_10] != param3.args[_loc_10])
                                {
                                    _loc_9 = false;
                                    break;
                                }
                                _loc_10 = _loc_10 + 1;
                            }
                            if (_loc_9)
                            {
                                _loc_7 = false;
                                break;
                            }
                        }
                    }
                    if (_loc_7)
                    {
                        this._aWaiting[param1]["ok"].push(param3);
                    }
                    if (param4)
                    {
                        this._aWaiting[param1]["ko"].push(param4);
                    }
                    while (this._waitingResources.length)
                    {
                        
                        this._loader.load(this._waitingResources.shift(), _cache);
                    }
                }
            }
            return;
        }// end function

        public function removeResource(param1:uint) : void
        {
            if (this._aWaiting[param1])
            {
                delete this._aWaiting[param1];
            }
            delete this._aResources[param1];
            return;
        }// end function

        public function isLoaded(param1:uint, param2:String = null) : Boolean
        {
            if (this._aResources[param1] == false)
            {
                return false;
            }
            var _loc_3:* = this._aResources[param1];
            if (param2)
            {
                return _loc_3 != null && _loc_3.hasClassAvaible(param2);
            }
            return _loc_3 && _loc_3.getSwl() != null;
        }// end function

        public function hasResource(param1:uint, param2:String = null) : Boolean
        {
            var _loc_3:* = this._aResources[param1];
            return _loc_3 && _loc_3.hasClass(param2);
        }// end function

        public function getResourceById(param1:uint, param2:String = null, param3:Boolean = false) : Swl
        {
            var _loc_5:* = null;
            var _loc_4:* = this._aResources[param1];
            if (this._aResources[param1].isSingleFile && !param3)
            {
                _loc_5 = _loc_4.getSwl(null);
            }
            _loc_5 = _loc_4.getSwl(param2, param3);
            if (_loc_5 == null && param3)
            {
                _loc_4.addEventListener(SwlEvent.SWL_LOADED, this.onSwfLoaded);
            }
            return _loc_5;
        }// end function

        private function onSwfLoaded(event:Event) : void
        {
            event.currentTarget.removeEventListener(SwlEvent.SWL_LOADED, this.onSwfLoaded);
            dispatchEvent(event);
            return;
        }// end function

        public function hasAnim(param1:int, param2:String, param3:int = -1) : Boolean
        {
            var _loc_5:* = false;
            var _loc_6:* = null;
            var _loc_4:* = this._aResources[param1];
            if (this._aResources[param1].isSingleFile)
            {
                _loc_5 = false;
                if (!_loc_4.getSwl())
                {
                    _log.warn("/!\\ Attention, on test si une librairie contient une anim sans l\'avoir en mémoire. (bones: " + param1 + ", anim:" + param2 + ")");
                    return false;
                }
                for each (_loc_6 in _loc_4.getSwl().getDefinitions())
                {
                    
                    if (_loc_6.indexOf(param2 + (param3 != -1 ? ("_" + param3) : (""))) == 0)
                    {
                        _loc_5 = true;
                    }
                }
                return _loc_5;
            }
            else
            {
                return BoneIndexManager.getInstance().hasAnim(param1, param2, param3);
            }
        }// end function

        private function onLoadResource(event:ResourceLoadedEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_2:* = event.uri.tag.id == null ? (event.uri.tag) : (event.uri.tag.id);
            _log.info("Loaded " + event.uri);
            trace(this._aResources[_loc_2]);
            GraphicLibrary(this._aResources[_loc_2]).addSwl(event.resource, event.uri.uri);
            if (this._aWaiting[_loc_2] && this._aWaiting[_loc_2]["ok"])
            {
                _loc_3 = this._aWaiting[_loc_2]["ok"].length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    Callback(this._aWaiting[_loc_2]["ok"][_loc_4]).exec();
                    _loc_4 = _loc_4 + 1;
                }
                delete this._aWaiting[_loc_2];
            }
            return;
        }// end function

        private function onLoadFailedResource(event:ResourceErrorEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = event.uri.tag;
            _log.error("Unable to load " + event.uri + " (" + event.errorMsg + ")");
            delete this._aResources[_loc_2];
            this.addResource(_loc_2, _uri);
            if (this._aWaiting[_loc_2])
            {
                _loc_3 = this._aWaiting[_loc_2]["ko"];
                if (_loc_3)
                {
                    _loc_4 = _loc_3.length;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4)
                    {
                        
                        (_loc_3[_loc_5] as Callback).exec();
                        _loc_5++;
                    }
                    delete this._aWaiting[_loc_2];
                }
            }
            return;
        }// end function

    }
}
