package com.ankamagames.berilia.utils
{
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import flash.system.ApplicationDomain;
    import flash.filesystem.File;
    import com.ankamagames.berilia.utils.web.HttpServer;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
    import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
    import flash.utils.setTimeout;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.jerakine.types.ASwf;

    public class ModuleScriptAnalyzer 
    {

        private static var _actionList:Dictionary;
        private static var _apiList:Dictionary;
        private static var _hookList:Dictionary;

        private var _loader:IResourceLoader;
        private var _actions:Array;
        private var _hooks:Array;
        private var _apis:Array;
        private var _readyFct:Function;

        public function ModuleScriptAnalyzer(target:UiModule, readyFct:Function, appDomain:ApplicationDomain=null, targetScriptLocation:String="")
        {
            var tmpList:Array;
            var action:String;
            var api:String;
            var hook:String;
            var uri:Uri;
            var scriptUrl:String;
            var mp:String;
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            this._actions = [];
            this._hooks = [];
            this._apis = [];
            super();
            if (!(_actionList))
            {
                _actionList = new Dictionary();
                tmpList = UiModuleManager.getInstance().sharedDefinitionInstance.getActionList();
                for each (action in tmpList)
                {
                    _actionList[action] = action;
                };
                _apiList = new Dictionary();
                tmpList = UiModuleManager.getInstance().sharedDefinitionInstance.getApiList();
                for each (api in tmpList)
                {
                    _apiList[api] = api;
                };
                _hookList = new Dictionary();
                tmpList = UiModuleManager.getInstance().sharedDefinitionInstance.getHookList();
                for each (hook in tmpList)
                {
                    _hookList[hook] = hook;
                };
            };
            this._readyFct = readyFct;
            if (!(appDomain))
            {
                if (target)
                {
                    scriptUrl = target.script;
                }
                else
                {
                    scriptUrl = targetScriptLocation;
                };
                if (ApplicationDomain.currentDomain.hasDefinition("flash.net.ServerSocket"))
                {
                    mp = File.applicationDirectory.nativePath.split("\\").join("/");
                    if (scriptUrl.indexOf(mp) != -1)
                    {
                        scriptUrl = scriptUrl.substr((scriptUrl.indexOf(mp) + mp.length));
                    };
                    scriptUrl = HttpServer.getInstance().getUrlTo(scriptUrl);
                }
                else
                {
                    throw (new Error("Need Air 2 to analyze module script"));
                };
                uri = new Uri(scriptUrl);
                this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onSwfLoaded);
                this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onSwfFailed);
                this._loader.load(uri, null, AdvancedSwfAdapter, true);
            }
            else
            {
                this.process(appDomain);
                setTimeout(readyFct, 1);
            };
        }

        public function get actions():Array
        {
            return (this._actions);
        }

        public function get hooks():Array
        {
            return (this._hooks);
        }

        public function get apis():Array
        {
            return (this._apis);
        }

        private function onSwfLoaded(e:ResourceLoadedEvent):void
        {
            var aswf:ASwf = e.resource;
            this._loader.removeEventListener(ResourceLoadedEvent.LOADED, this.onSwfLoaded);
            this._loader.removeEventListener(ResourceErrorEvent.ERROR, this.onSwfFailed);
            this.process(aswf.applicationDomain);
            this._readyFct();
        }

        private function process(appDomain:ApplicationDomain):void
        {
            var action:String;
            var hook:String;
            var api:String;
            for each (action in _actionList)
            {
                if (appDomain.hasDefinition(("d2actions::" + action)))
                {
                    this._actions.push(action);
                };
            };
            for each (hook in _hookList)
            {
                if (appDomain.hasDefinition(("d2hooks::" + hook)))
                {
                    this._hooks.push(hook);
                };
            };
            for each (api in _apiList)
            {
                if (appDomain.hasDefinition(("d2api::" + api)))
                {
                    this._apis.push(api);
                };
            };
        }

        private function onSwfFailed(e:ResourceErrorEvent):void
        {
            this._readyFct();
        }


    }
}//package com.ankamagames.berilia.utils

