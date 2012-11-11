package com.ankamagames.jerakine.script
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.newCache.impl.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.script.runners.*;
    import com.ankamagames.jerakine.types.*;
    import flash.system.*;
    import flash.utils.*;

    public class ScriptExec extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ScriptExec));
        private static var _prepared:Boolean;
        private static var _scriptCache:ICache;
        private static var _rld:IResourceLoader;
        private static var _runners:Dictionary;

        public function ScriptExec()
        {
            return;
        }// end function

        public static function exec(param1, param2:IRunner, param3:Boolean = true, param4:Callback = null, param5:Callback = null) : void
        {
            var _loc_6:* = null;
            var _loc_9:* = null;
            if (param1 is Uri)
            {
                _loc_6 = param1;
            }
            else if (param1 is BinaryScript)
            {
                _loc_6 = new Uri("file://fake_script_url/" + BinaryScript(param1).path);
            }
            if (!_prepared)
            {
                prepare();
            }
            var _loc_7:* = new Object();
            new Object().runner = param2;
            _loc_7.success = param4;
            _loc_7.error = param5;
            var _loc_8:* = _loc_6.toSum();
            if (!_loc_6.loaderContext)
            {
                _loc_6.loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
            }
            if (_runners[_loc_8])
            {
                (_runners[_loc_8] as Array).push(_loc_7);
            }
            else
            {
                _runners[_loc_8] = [_loc_7];
            }
            if (param1 is Uri)
            {
                _rld.load(_loc_6, param3 ? (_scriptCache) : (null));
            }
            else
            {
                _loc_9 = AdapterFactory.getAdapter(_loc_6);
                _loc_9.loadFromData(_loc_6, BinaryScript(param1).data, new ResourceObserverWrapper(onLoadedWrapper, onFailedWrapper), false);
            }
            return;
        }// end function

        private static function prepare() : void
        {
            _rld = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            _rld.addEventListener(ResourceLoadedEvent.LOADED, onLoaded);
            _rld.addEventListener(ResourceErrorEvent.ERROR, onError);
            _scriptCache = new InfiniteCache();
            _runners = new Dictionary(true);
            _prepared = true;
            return;
        }// end function

        private static function onLoaded(event:ResourceLoadedEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_2:* = event.uri.toSum();
            var _loc_3:* = false;
            if (event.resourceType != ResourceType.RESOURCE_DX)
            {
                _log.error("Cannot execute " + event.uri + "; not a script.");
                _loc_3 = true;
            }
            for each (_loc_4 in _runners[_loc_2])
            {
                
                if (_loc_3)
                {
                    if (_loc_4.error)
                    {
                        Callback(_loc_4.error).exec();
                    }
                    continue;
                }
                _loc_5 = (_loc_4.runner as IRunner).run(event.resource as Class);
                if (_loc_5)
                {
                    if (_loc_4.error)
                    {
                        Callback(_loc_4.error).exec();
                    }
                    continue;
                }
                if (_loc_4.success)
                {
                    Callback(_loc_4.success).exec();
                }
            }
            delete _runners[_loc_2];
            return;
        }// end function

        private static function onError(event:ResourceErrorEvent) : void
        {
            var _loc_3:* = null;
            _log.error("Cannot execute " + event.uri + "; script not found (" + event.errorMsg + ").");
            var _loc_2:* = event.uri.toSum();
            for each (_loc_3 in _runners[_loc_2])
            {
                
                if (_loc_3.error)
                {
                    Callback(_loc_3.error).exec();
                }
            }
            delete _runners[_loc_2];
            return;
        }// end function

        private static function onLoadedWrapper(param1:Uri, param2:uint, param3) : void
        {
            var _loc_4:* = new ResourceLoadedEvent(ResourceLoadedEvent.LOADED);
            new ResourceLoadedEvent(ResourceLoadedEvent.LOADED).uri = param1;
            _loc_4.resource = param3;
            _loc_4.resourceType = param2;
            onLoaded(_loc_4);
            return;
        }// end function

        private static function onFailedWrapper(param1:Uri, param2:String, param3:uint) : void
        {
            var _loc_4:* = new ResourceErrorEvent(ResourceErrorEvent.ERROR);
            new ResourceErrorEvent(ResourceErrorEvent.ERROR).uri = param1;
            _loc_4.errorMsg = param2;
            _loc_4.errorCode = param3;
            onError(_loc_4);
            return;
        }// end function

    }
}
