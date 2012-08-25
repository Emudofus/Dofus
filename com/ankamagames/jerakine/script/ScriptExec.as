package com.ankamagames.jerakine.script
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.newCache.impl.*;
    import com.ankamagames.jerakine.resources.*;
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

        public static function exec(param1:Uri, param2:IRunner, param3:Boolean = true, param4:Callback = null, param5:Callback = null) : void
        {
            if (!_prepared)
            {
                prepare();
            }
            var _loc_6:* = new Object();
            new Object().runner = param2;
            _loc_6.success = param4;
            _loc_6.error = param5;
            var _loc_7:* = param1.toSum();
            if (!param1.loaderContext)
            {
                param1.loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
            }
            if (_runners[_loc_7])
            {
                (_runners[_loc_7] as Array).push(_loc_6);
            }
            else
            {
                _runners[_loc_7] = [_loc_6];
            }
            _rld.load(param1, param3 ? (_scriptCache) : (null));
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
            var _loc_4:Object = null;
            var _loc_5:uint = 0;
            var _loc_2:* = event.uri.toSum();
            var _loc_3:Boolean = false;
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
            var _loc_3:Object = null;
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

    }
}
