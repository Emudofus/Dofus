package com.ankamagames.berilia.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
    import flash.system.ApplicationDomain;
    import flash.utils.Dictionary;
    import flash.filesystem.File;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
    import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import com.ankamagames.berilia.utils.web.HttpServer;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
    import com.ankamagames.jerakine.utils.display.FrameIdManager;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.jerakine.resources.protocols.ProtocolFactory;
    import com.ankamagames.berilia.utils.ModProtocol;
    import com.ankamagames.berilia.utils.ModFlashProtocol;
    import com.ankamagames.jerakine.managers.LangManager;
    import com.ankamagames.jerakine.managers.ErrorManager;
    import com.ankamagames.berilia.types.data.UiModule;
    import __AS3__.vec.Vector;
    import com.ankamagames.berilia.types.shortcut.Shortcut;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.api.ApiBinder;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.berilia.types.data.UiGroup;
    import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
    import com.ankamagames.berilia.utils.errors.UntrustedApiCallError;
    import flash.events.Event;
    import flash.utils.getTimer;
    import com.ankamagames.berilia.types.messages.AllModulesLoadedMessage;
    import com.ankamagames.jerakine.resources.adapters.impl.TxtAdapter;
    import com.ankamagames.jerakine.newCache.ICache;
    import com.ankamagames.jerakine.utils.files.FileUtils;
    import com.ankamagames.berilia.utils.UriCacheFactory;
    import com.ankamagames.jerakine.newCache.impl.Cache;
    import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
    import com.ankamagames.berilia.types.messages.ModuleRessourceLoadFailedMessage;
    import flash.system.LoaderContext;
    import flash.filesystem.FileStream;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.utils.crypto.Signature;
    import com.ankamagames.berilia.types.data.UiData;
    import com.ankamagames.jerakine.resources.ResourceType;
    import com.ankamagames.berilia.types.data.PreCompiledUiModule;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import flash.filesystem.FileMode;
    import by.blooddy.crypto.MD5;
    import com.ankamagames.jerakine.resources.adapters.impl.SignedFileAdapter;
    import com.ankamagames.jerakine.resources.adapters.impl.BinaryAdapter;
    import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSignedFileAdapter;
    import flash.events.IOErrorEvent;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import com.ankamagames.berilia.types.messages.ModuleLoadedMessage;
    import com.ankamagames.berilia.types.shortcut.ShortcutCategory;
    import com.ankamagames.jerakine.resources.events.ResourceLoaderProgressEvent;
    import com.ankamagames.berilia.uiRender.XmlParsor;
    import com.ankamagames.berilia.types.event.ParsingErrorEvent;
    import com.ankamagames.berilia.types.messages.AllUiXmlParsedMessage;
    import com.ankamagames.berilia.types.messages.UiXmlParsedMessage;
    import com.ankamagames.berilia.types.event.ParsorEvent;
    import com.ankamagames.berilia.types.messages.UiXmlParsedErrorMessage;
    import com.ankamagames.jerakine.types.ASwf;

    public class UiModuleManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiModuleManager));
        private static const _lastModulesToUnload:Array = ["Ankama_GameUiCore", "Ankama_Common", "Ankama_Tooltips", "Ankama_ContextMenu"];
        private static var _self:UiModuleManager;

        private var _sharedDefinitionLoader:IResourceLoader;
        private var _sharedDefinition:ApplicationDomain;
        private var _useSharedDefinition:Boolean;
        private var _loader:IResourceLoader;
        private var _uiLoader:IResourceLoader;
        private var _scriptNum:uint;
        private var _modules:Array;
        private var _preprocessorIndex:Dictionary;
        private var _uiFiles:Array;
        private var _regImport:RegExp;
        private var _versions:Array;
        private var _clearUi:Array;
        private var _uiFileToLoad:uint;
        private var _moduleCount:uint = 0;
        private var _cacheLoader:IResourceLoader;
        private var _unparsedXml:Array;
        private var _unparsedXmlCount:uint;
        private var _unparsedXmlTotalCount:uint;
        private var _modulesRoot:File;
        private var _modulesPaths:Dictionary;
        private var _modulesHashs:Dictionary;
        private var _resetState:Boolean;
        private var _parserAvaibleCount:uint = 2;
        private var _moduleLaunchWaitForSharedDefinition:Boolean;
        private var _unInitializedModules:Array;
        private var _useHttpServer:Boolean;
        private var _moduleLoaders:Dictionary;
        private var _loadingModule:Dictionary;
        private var _disabledModules:Array;
        private var _sharedDefinitionInstance:Object;
        private var _timeOutFrameNumber:int;
        private var _waitingInit:Boolean;
        private var _filter:Array;
        private var _filterInclude:Boolean;
        public var isDevMode:Boolean;
        private var _moduleScriptLoadedRef:Dictionary;
        private var _uiLoaded:Dictionary;
        private var _loadModuleFunction:Function;

        public function UiModuleManager(dontUseLocalServer:Boolean=false)
        {
            this._regImport = /<Import *url *= *"([^"]*)/g;
            this._modulesHashs = new Dictionary();
            this._moduleScriptLoadedRef = new Dictionary();
            this._uiLoaded = new Dictionary();
            super();
            if (_self)
            {
                throw (new SingletonError());
            };
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadError, false, 0, true);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoad, false, 0, true);
            this._sharedDefinitionLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            this._sharedDefinitionLoader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadError, false, 0, true);
            this._sharedDefinitionLoader.addEventListener(ResourceLoadedEvent.LOADED, this.onSharedDefinitionLoad, false, 0, true);
            this._uiLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._uiLoader.addEventListener(ResourceErrorEvent.ERROR, this.onUiLoadError, false, 0, true);
            this._uiLoader.addEventListener(ResourceLoadedEvent.LOADED, this.onUiLoaded, false, 0, true);
            this._cacheLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._moduleLoaders = new Dictionary();
            this._useHttpServer = false;
            if (((!(dontUseLocalServer)) && (ApplicationDomain.currentDomain.hasDefinition("flash.net.ServerSocket"))))
            {
                this._useHttpServer = true;
            };
            if (this._useHttpServer)
            {
                HttpServer.getInstance().init(File.applicationDirectory);
            };
        }

        public static function getInstance(dontUseLocalServer:Boolean=false):UiModuleManager
        {
            if (!(_self))
            {
                _self = new (UiModuleManager)(dontUseLocalServer);
            };
            return (_self);
        }


        public function get unInitializedModules():Array
        {
            return (this._unInitializedModules);
        }

        public function get moduleCount():uint
        {
            return (this._moduleCount);
        }

        public function get unparsedXmlCount():uint
        {
            return (this._unparsedXmlCount);
        }

        public function get unparsedXmlTotalCount():uint
        {
            return (this._unparsedXmlTotalCount);
        }

        public function set sharedDefinitionContainer(path:Uri):void
        {
            var url:String;
            var sharedDefinitionUri:Uri;
            this._useSharedDefinition = !((path == null));
            if (path)
            {
                if (this._useHttpServer)
                {
                    url = HttpServer.getInstance().getUrlTo(path.fileName);
                    sharedDefinitionUri = new Uri(url);
                    _log.debug((((("sharedDefinition.swf location: " + path.uri) + " (") + url) + ")"));
                    this._sharedDefinitionLoader.load(sharedDefinitionUri, null, (((path.fileType == "swf")) ? AdvancedSwfAdapter : null));
                    _log.info("trying to load sharedDefinition.swf throught an httpServer");
                    FrameIdManager.frameId;
                    this._timeOutFrameNumber = (StageShareManager.stage.frameRate * 10);
                    EnterFrameDispatcher.addEventListener(this.timeOutFrameCount, "frameCount");
                }
                else
                {
                    this._sharedDefinitionLoader.load(path, null, (((path.fileType == "swf")) ? AdvancedSwfAdapter : null));
                    _log.info("trying to load sharedDefinition.swf the good ol' way");
                };
            };
        }

        public function get sharedDefinition():ApplicationDomain
        {
            return (this._sharedDefinition);
        }

        public function get ready():Boolean
        {
            return (!((this._sharedDefinition == null)));
        }

        public function get sharedDefinitionInstance():Object
        {
            return (this._sharedDefinitionInstance);
        }

        public function get modulesHashs():Dictionary
        {
            return (this._modulesHashs);
        }

        public function init(filter:Array, filterInclude:Boolean):void
        {
            var uri:Uri;
            var file:File;
            this._filter = filter;
            this._filterInclude = filterInclude;
            if (!(this._sharedDefinition))
            {
                this._waitingInit = true;
                return;
            };
            this._moduleLaunchWaitForSharedDefinition = false;
            this._resetState = false;
            this._modules = new Array();
            this._preprocessorIndex = new Dictionary(true);
            this._scriptNum = 0;
            this._moduleCount = 0;
            this._versions = new Array();
            this._clearUi = new Array();
            this._uiFiles = new Array();
            this._modulesPaths = new Dictionary();
            this._unInitializedModules = new Array();
            this._loadingModule = new Dictionary();
            this._disabledModules = [];
            if (AirScanner.hasAir())
            {
                ProtocolFactory.addProtocol("mod", ModProtocol);
            }
            else
            {
                ProtocolFactory.addProtocol("mod", ModFlashProtocol);
            };
            var uiRoot:String = LangManager.getInstance().getEntry("config.mod.path");
            if (((!((uiRoot.substr(0, 2) == "\\\\"))) && (!((uiRoot.substr(1, 2) == ":/")))))
            {
                this._modulesRoot = new File(((File.applicationDirectory.nativePath + File.separator) + uiRoot));
            }
            else
            {
                this._modulesRoot = new File(uiRoot);
            };
            uri = new Uri((this._modulesRoot.nativePath + "/hash.metas"));
            this._loader.load(uri);
            BindsManager.getInstance().initialize();
            if (this._modulesRoot.exists)
            {
                for each (file in this._modulesRoot.getDirectoryListing())
                {
                    if (!((!(file.isDirectory)) || ((file.name.charAt(0) == "."))))
                    {
                        if (!((filter.indexOf(file.name) == -1)) == filterInclude)
                        {
                            this.loadModule(file.name);
                        };
                    };
                };
            }
            else
            {
                ErrorManager.addError((("Impossible de trouver le dossier contenant les modules (url: " + LangManager.getInstance().getEntry("config.mod.path")) + ")"));
                return;
            };
        }

        public function lightInit(moduleList:Vector.<UiModule>):void
        {
            var m:UiModule;
            this._resetState = false;
            this._modules = new Array();
            this._modulesPaths = new Dictionary();
            for each (m in moduleList)
            {
                this._modules[m.id] = m;
                this._modulesPaths[m.id] = m.rootPath;
            };
        }

        public function getModules():Array
        {
            return (this._modules);
        }

        public function getModule(name:String, includeUnInitialized:Boolean=false):UiModule
        {
            var module:UiModule;
            if (this._modules)
            {
                module = this._modules[name];
            };
            if (((((!(module)) && (includeUnInitialized))) && (this._unInitializedModules)))
            {
                module = this._unInitializedModules[name];
            };
            return (module);
        }

        public function get disabledModules():Array
        {
            return (this._disabledModules);
        }

        public function reset():void
        {
            var module:UiModule;
            var i:int;
            _log.warn("Reset des modules");
            this._resetState = true;
            if (this._loader)
            {
                this._loader.cancel();
            };
            if (this._cacheLoader)
            {
                this._cacheLoader.cancel();
            };
            if (this._uiLoader)
            {
                this._uiLoader.cancel();
            };
            TooltipManager.clearCache();
            for each (module in this._modules)
            {
                if (_lastModulesToUnload.indexOf(module.id) != -1)
                {
                }
                else
                {
                    this.unloadModule(module.id);
                };
            };
            i = 0;
            while (i < _lastModulesToUnload.length)
            {
                if (this._modules[_lastModulesToUnload[i]])
                {
                    this.unloadModule(_lastModulesToUnload[i]);
                };
                i++;
            };
            Shortcut.reset();
            Berilia.getInstance().reset();
            ApiBinder.reset();
            KernelEventsManager.getInstance().initialize();
            this._modules = [];
            this._uiFileToLoad = 0;
            this._scriptNum = 0;
            this._moduleCount = 0;
            this._parserAvaibleCount = 2;
            this._modulesPaths = new Dictionary();
        }

        public function getModulePath(moduleName:String):String
        {
            return (this._modulesPaths[moduleName]);
        }

        public function loadModule(id:String):void
        {
            var dmFile:File;
            var uri:Uri;
            var modulePath:String;
            var len:int;
            var substr:String;
            this.unloadModule(id);
            var targetedModuleFolder:File = this._modulesRoot.resolvePath(id);
            if (targetedModuleFolder.exists)
            {
                dmFile = this.searchDmFile(targetedModuleFolder);
                if (dmFile)
                {
                    this._moduleCount++;
                    this._scriptNum++;
                    if (dmFile.nativePath.indexOf("app:/") == 0)
                    {
                        len = "app:/".length;
                        substr = dmFile.nativePath.substring(len, dmFile.url.length);
                        uri = new Uri(substr);
                        modulePath = substr.substr(0, substr.lastIndexOf("/"));
                    }
                    else
                    {
                        uri = new Uri(dmFile.nativePath);
                        modulePath = dmFile.parent.nativePath;
                    };
                    uri.tag = dmFile;
                    this._modulesPaths[id] = modulePath;
                    this._loader.load(uri);
                }
                else
                {
                    _log.error(("Cannot found .dm or .d2ui file in " + targetedModuleFolder.url));
                };
            };
        }

        public function unloadModule(id:String):void
        {
            var uiCtr:UiRootContainer;
            var ui:String;
            var group:UiGroup;
            var variables:Array;
            var varName:String;
            var apiList:Vector.<Object>;
            var api:Object;
            if (this._modules == null)
            {
                return;
            };
            var m:UiModule = this._modules[id];
            if (!(m))
            {
                return;
            };
            var moduleUiInstances:Array = [];
            for each (uiCtr in Berilia.getInstance().uiList)
            {
                if (uiCtr.uiModule == m)
                {
                    moduleUiInstances.push(uiCtr.name);
                };
            };
            for each (ui in moduleUiInstances)
            {
                Berilia.getInstance().unloadUi(ui);
            };
            for each (group in m.groups)
            {
                UiGroupManager.getInstance().removeGroup(group.name);
            };
            variables = DescribeTypeCache.getVariables(m.mainClass, true);
            for each (varName in variables)
            {
                if ((m.mainClass[varName] is Object))
                {
                    m.mainClass[varName] = null;
                };
            };
            m.destroy();
            apiList = m.apiList;
            while (apiList.length)
            {
                api = apiList.shift();
                if (((api) && (api.hasOwnProperty("destroy"))))
                {
                    try
                    {
                        var _local_3 = api;
                        (_local_3["destroy"]());
                    }
                    catch(e:UntrustedApiCallError)
                    {
                        var _local_4 = api;
                        (_local_4["destroy"](SecureCenter.ACCESS_KEY));
                    };
                };
            };
            if (((m.mainClass) && (m.mainClass.hasOwnProperty("unload"))))
            {
                _local_3 = m.mainClass;
                (_local_3["unload"]());
            };
            BindsManager.getInstance().removeEventListenerByName(("__module_" + m.id));
            KernelEventsManager.getInstance().removeEventListenerByName(("__module_" + m.id));
            delete this._modules[id];
            this._disabledModules[id] = m;
        }

        public function checkSharedDefinitionHash(hashUrl:String):void
        {
            var hashUri:Uri = new Uri(hashUrl);
        }

        private function onTimeOut():void
        {
            for (;;)
            {
                //unresolved jump
                _log.error("SharedDefinition load Timeout");
                continue;
            };
            var _local_0 = this;
            
        _label_1: 
            return;
        }

        private function timeOutFrameCount(e:Event):void
        {
            this._timeOutFrameNumber--;
            if (this._timeOutFrameNumber <= 0)
            {
                while (this.onTimeOut(), true)
                {
                    return;
                };
                var _local_0 = this;
            };
            return;
        }

        private function launchModule():void
        {
            var module:UiModule;
            var missingName:String;
            var missingModule:UiModule;
            var notLoaded:Array;
            var m:UiModule;
            var ts:uint;
            while (true)
            {
                goto _label_1;
            };
            var _local_10 = _local_10;
            
        _label_1: 
            this._moduleLaunchWaitForSharedDefinition = false;
            var modules:Array = new Array();
            for each (module in this._unInitializedModules)
            {
                if (module.trusted)
                {
                    modules.unshift(module);
                }
                else
                {
                    modules.push(module);
                };
            };
            while (modules.length > 0)
            {
                while (true)
                {
                    goto _label_2;
                };
                
            _label_2: 
                notLoaded = new Array();
                for each (m in modules)
                {
                    //unresolved jump
                    
                _label_3: 
                    missingName = ApiBinder.initApi(m.mainClass, m, this._sharedDefinition);
                    if (missingName)
                    {
                        goto _label_6;
                        
                    _label_4: 
                        notLoaded.push(m);
                        //unresolved jump
                        
                    _label_5: 
                        goto _label_4;
                        var _local_0 = this;
                        
                    _label_6: 
                        missingModule = m;
                        goto _label_5;
                    }
                    else
                    {
                        if (m.mainClass)
                        {
                            while (goto _label_8, (ts = getTimer()), true)
                            {
                                goto _label_9;
                            };
                            var _local_9 = _local_9;
                            
                        _label_7: 
                            //unresolved jump
                            
                        _label_8: 
                            delete this._unInitializedModules[m.id];
                            goto _label_7;
                            
                        _label_9: 
                            ErrorManager.tryFunction(m.mainClass.main, null, ("Une erreur est survenue lors de l'appel à la fonction main() du module " + m.id));
                        }
                        else
                        {
                            _log.error(("Impossible d'instancier la classe principale du module " + m.id));
                        };
                    };
                };
                if (notLoaded.length == modules.length)
                {
                    goto _label_11;
                };
                
            _label_10: 
                modules = notLoaded;
                continue;
                
            _label_11: 
                ErrorManager.addError(((("Le module " + missingModule.id) + " demande une référence vers un module inexistant : ") + missingName));
                goto _label_10;
                var _local_11 = _local_11;
            };
            while (Berilia.getInstance().handler.process(new AllModulesLoadedMessage()), true)
            {
                return;
            };
            _local_0 = this;
            return;
        }

        private function launchUiCheck():void
        {
            while ((this._uiFileToLoad = this._uiFiles.length), true)
            {
                goto _label_1;
            };
            var _local_0 = this;
            
        _label_1: 
            if (_local_0._uiFiles.length)
            {
                _local_0._uiLoader.load(_local_0._uiFiles, null, TxtAdapter);
            }
            else
            {
                _local_0.onAllUiChecked(null);
            };
            return;
        }

        private function processCachedFiles(files:Array):void
        {
            var uri:Uri;
            var file:Uri;
            var _local_4:ICache;
            while (true)
            {
                //unresolved jump
            };
            var _local_6 = _local_6;
            for each (file in files)
            {
                switch (file.fileType.toLowerCase())
                {
                    case "css":
                        while (true)
                        {
                            CssManager.getInstance().load(file.uri);
                            goto _label_1;
                        };
                        var _local_9 = _local_9;
                        
                    _label_1: 
                        continue;
                    case "jpg":
                    case "png":
                        while (true)
                        {
                            uri = new Uri(FileUtils.getFilePath(file.normalizedUri));
                            goto _label_3;
                        };
                        
                    _label_2: 
                        goto _label_4;
                        
                    _label_3: 
                        _local_4 = UriCacheFactory.getCacheFromUri(uri);
                        goto _label_2;
                        
                    _label_4: 
                        if (!(_local_4))
                        {
                            goto _label_6;
                        };
                        
                    _label_5: 
                        this._cacheLoader.load(file, _local_4);
                        goto _label_7;
                        
                    _label_6: 
                        _local_4 = UriCacheFactory.init(uri.uri, new Cache(files.length, new LruGarbageCollector()));
                        goto _label_5;
                        var _local_0 = this;
                        
                    _label_7: 
                        continue;
                    default:
                        while (true)
                        {
                            ErrorManager.addError((("Impossible de mettre en cache le fichier " + file.uri) + ", le type n'est pas supporté (uniquement css, jpg et png)"));
                            //unresolved jump
                        };
                        var _local_7 = _local_7;
                };
            };
            return;
        }

        private function onLoadError(e:ResourceErrorEvent):void
        {
            _log.error(("onLoadError() - " + e.errorMsg));
            var sduri:Uri = new Uri(HttpServer.getInstance().getUrlTo("SharedDefinitions.swf"));
            if (e.uri == sduri)
            {
                this.switchToNoHttpMode();
            }
            else
            {
                if (e.uri.fileType != "metas")
                {
                    Berilia.getInstance().handler.process(new ModuleRessourceLoadFailedMessage(e.uri.tag, e.uri));
                };
                switch (e.uri.fileType.toLowerCase())
                {
                    case "swfs":
                        while (true)
                        {
                            ErrorManager.addError((((("Impossible de charger le fichier " + e.uri) + " (") + e.errorMsg) + ")"));
                            //unresolved jump
                        };
                        var _local_0 = this;
                        if (!(--_local_0._scriptNum))
                        {
                            _local_0.launchUiCheck();
                        };
                        return;
                    case "metas":
                        return;
                    default:
                        ErrorManager.addError((((("Impossible de charger le fichier " + e.uri) + " (") + e.errorMsg) + ")"));
                };
            };
            return;
        }

        private function switchToNoHttpMode():void
        {
            for (;;_log.fatal("Failed Loading SharedDefinitions, Going no HttpServer Style !"), goto _label_2)
            {
                this._useHttpServer = false;
                continue;
                
            _label_1: 
                this._sharedDefinitionLoader.cancel();
                goto _label_3;
            };
            var _local_2 = _local_2;
            
        _label_2: 
            goto _label_1;
            var _local_0 = this;
            
        _label_3: 
            var sharedDefUri:Uri = new Uri("SharedDefinitions.swf");
            for (;;)
            {
                return;
                
            _label_4: 
                continue;
                sharedDefUri.loaderContext = new LoaderContext(false, new ApplicationDomain());
                goto _label_4;
                var _local_3 = _local_3;
            };
            return;
        }

        private function onUiLoadError(e:ResourceErrorEvent):void
        {
            ErrorManager.addError((((("Impossible de charger le fichier d'interface " + e.uri) + " (") + e.errorMsg) + ")"));
            Berilia.getInstance().handler.process(new ModuleRessourceLoadFailedMessage(e.uri.tag, e.uri));
            this._uiFileToLoad--;
            return;
        }

        private function onLoad(e:ResourceLoadedEvent):void
        {
            if (this._resetState)
            {
                return;
            };
            switch (e.uri.fileType.toLowerCase())
            {
                case "swf":
                case "swfs":
                    while (true)
                    {
                        this.onScriptLoad(e);
                        goto _label_1;
                    };
                    
                _label_1: 
                    return;
                case "d2ui":
                case "dm":
                    while (true)
                    {
                        this.onDMLoad(e);
                        goto _label_2;
                    };
                    var _local_0 = this;
                    
                _label_2: 
                    return;
                case "xml":
                    while (true)
                    {
                        this.onShortcutLoad(e);
                        goto _label_3;
                    };
                    
                _label_3: 
                    return;
                case "metas":
                    while (true)
                    {
                        this.onHashLoaded(e);
                        goto _label_4;
                    };
                    var _local_3 = _local_3;
                    
                _label_4: 
                    return;
            };
            return;
        }

        private function onDMLoad(e:ResourceLoadedEvent):void
        {
            var um:UiModule;
            var uiUri:Uri;
            var currentFile:File;
            var path:String;
            var scriptUrl:String;
            var scriptUri:Uri;
            var scriptFile:File;
            var fs:FileStream;
            var swfContent:ByteArray;
            var fooOutput:ByteArray;
            var sig:Signature;
            var shortcutsUri:Uri;
            var mp:String;
            var ui:UiData;
            var _local_18:Array;
            var _local_19:File;
            //unresolved jump
            
        _label_1: 
            for (;;)
            {
                continue;
                goto _label_2;
            };
            
        _label_2: 
            if (e.resourceType == ResourceType.RESOURCE_XML)
            {
                um = UiModule.createFromXml((e.resource as XML), FileUtils.getFilePath(e.uri.path), File(e.uri.tag).parent.name);
            }
            else
            {
                um = PreCompiledUiModule.fromRaw(e.resource, FileUtils.getFilePath(e.uri.path), File(e.uri.tag).parent.name);
                goto _label_4;
            };
            
        _label_3: 
            this._unInitializedModules[um.id] = um;
            goto _label_5;
            
        _label_4: 
            goto _label_3;
            
        _label_5: 
            if (um.script)
            {
                while (true)
                {
                    scriptUrl = StringUtils.convertLatinToUtf(unescape(um.script));
                    goto _label_7;
                    
                _label_6: 
                    goto _label_8;
                };
                
            _label_7: 
                scriptUri = new Uri(scriptUrl);
                goto _label_6;
                var _local_20 = _local_20;
                
            _label_8: 
                if (Berilia.getInstance().checkModuleAuthority)
                {
                    goto _label_11;
                    
                _label_9: 
                    goto _label_12;
                    
                _label_10: 
                    _log.debug(("hash " + scriptUri));
                    goto _label_9;
                    
                _label_11: 
                    scriptFile = scriptUri.toFile();
                    goto _label_10;
                    
                _label_12: 
                    if (scriptFile.exists)
                    {
                        goto _label_14;
                        while (fs.readBytes(swfContent), for (;;)
                        {
                            fs.open(scriptFile, FileMode.READ);
                            //unresolved jump
                            
                        _label_13: 
                            fs = new FileStream();
                            continue;
                            goto _label_15;
                        }, (var _local_24 = _local_24), true)
                        {
                            swfContent = new ByteArray();
                            continue;
                        };
                        
                    _label_14: 
                        goto _label_13;
                        
                    _label_15: 
                        fs.close();
                        if (scriptUri.fileType == "swf")
                        {
                            while ((um.trusted = (MD5.hashBytes(swfContent) == this._modulesHashs[scriptUri.fileName])), true)
                            {
                                goto _label_16;
                            };
                            
                        _label_16: 
                            if (!(um.trusted))
                            {
                                _log.error(("Hash incorrect pour le module " + um.id));
                            };
                        }
                        else
                        {
                            if (scriptUri.fileType == "swfs")
                            {
                                while (goto _label_17, true)
                                {
                                    sig = new Signature(SignedFileAdapter.defaultSignatureKey);
                                    goto _label_18;
                                };
                                
                            _label_17: 
                                fooOutput = new ByteArray();
                                //unresolved jump
                                
                            _label_18: 
                                if (!(sig.verify(swfContent, fooOutput)))
                                {
                                    _log.fatal(("Invalid signature in " + scriptFile.nativePath));
                                    this._moduleCount--;
                                    this._scriptNum--;
                                    goto _label_21;
                                    
                                _label_19: 
                                    return;
                                    
                                _label_20: 
                                    goto _label_19;
                                    
                                _label_21: 
                                    um.trusted = false;
                                    goto _label_20;
                                };
                                um.trusted = true;
                            };
                        };
                    }
                    else
                    {
                        ErrorManager.addError((((("Le script du module " + um.id) + " est introuvable (url: ") + scriptFile.nativePath) + ")"));
                        this._moduleCount--;
                        this._scriptNum--;
                        while ((um.trusted = false), true)
                        {
                            return;
                        };
                        return;
                    };
                }
                else
                {
                    um.trusted = true;
                };
                if (!(um.enable))
                {
                    _log.fatal((("Le module " + um.id) + " est désactivé"));
                    this._moduleCount--;
                    this._scriptNum--;
                    while ((this._disabledModules[um.id] = um), true)
                    {
                        return;
                    };
                    return;
                };
                if (um.shortcuts)
                {
                    while ((shortcutsUri = new Uri(um.shortcuts)), true)
                    {
                        while ((shortcutsUri.tag = um.id), true)
                        {
                            goto _label_23;
                        };
                        var files = files;
                        
                    _label_22: 
                        goto _label_24;
                    };
                    
                _label_23: 
                    this._loader.load(shortcutsUri);
                    goto _label_22;
                };
                
            _label_24: 
                if (((this._useHttpServer) && (!((scriptUri.fileType == "swfs")))))
                {
                    mp = File.applicationDirectory.nativePath.split("\\").join("/");
                    if (scriptUrl.indexOf(mp) != -1)
                    {
                        scriptUrl = scriptUrl.substr((scriptUrl.indexOf(mp) + mp.length));
                        goto _label_26;
                        
                    _label_25: 
                        _log.trace(("[WebServer] Load " + scriptUrl));
                        goto _label_27;
                    };
                    
                _label_26: 
                    scriptUrl = HttpServer.getInstance().getUrlTo(scriptUrl);
                    goto _label_28;
                    
                _label_27: 
                    this._loadModuleFunction(scriptUrl, this.onModuleScriptLoaded, this.onScriptLoadFail, um);
                    //unresolved jump
                    
                _label_28: 
                    goto _label_25;
                }
                else
                {
                    if (um.trusted)
                    {
                        while ((scriptUri.tag = um.id), goto _label_31, true)
                        {
                            scriptUri.loaderContext.applicationDomain = new ApplicationDomain(this._sharedDefinition);
                            goto _label_32;
                        };
                        
                    _label_29: 
                        _log.trace(("[Classic] Load " + scriptUri));
                        goto _label_33;
                        
                    _label_30: 
                        this._loadingModule[um] = um.id;
                        goto _label_29;
                        
                    _label_31: 
                        scriptUri.loaderContext = new LoaderContext();
                        //unresolved jump
                        var _local_23 = _local_23;
                        
                    _label_32: 
                        goto _label_30;
                        
                    _label_33: 
                        this._loader.load(scriptUri, null, ((!((scriptUri.fileType == "swfs"))) ? BinaryAdapter : AdvancedSignedFileAdapter));
                    }
                    else
                    {
                        this._moduleCount--;
                        this._scriptNum--;
                        while (ErrorManager.addError((((("Failed to load custom module " + um.author) + "_") + um.name) + ", because the local HTTP server is not available.")), true)
                        {
                            return;
                        };
                        var _local_22 = _local_22;
                    };
                };
            };
            files = new Array();
            if (!((um is PreCompiledUiModule)))
            {
                for each (ui in um.uis)
                {
                    if (ui.file)
                    {
                        goto _label_37;
                        
                    _label_34: 
                        continue;
                        
                    _label_35: 
                        this._uiFiles.push(uiUri);
                        goto _label_34;
                        var _local_21 = _local_21;
                        
                    _label_36: 
                        uiUri.tag = {
                            "mod":um.id,
                            "base":ui.file
                        };
                        goto _label_38;
                        
                    _label_37: 
                        uiUri = new Uri(ui.file);
                        goto _label_36;
                        
                    _label_38: 
                        goto _label_35;
                    };
                };
            };
            var root:File = this._modulesRoot.resolvePath(um.id);
            files = new Array();
            for each (path in um.cachedFiles)
            {
                currentFile = root.resolvePath(path);
                if (currentFile.exists)
                {
                    if (!(currentFile.isDirectory))
                    {
                        files.push(new Uri(((("mod://" + um.id) + "/") + path)));
                    }
                    else
                    {
                        _local_18 = currentFile.getDirectoryListing();
                        for each (_local_19 in _local_18)
                        {
                            if (!(_local_19.isDirectory))
                            {
                                goto _label_40;
                                
                            _label_39: 
                                continue;
                            };
                            
                        _label_40: 
                            files.push(new Uri(((((("mod://" + um.id) + "/") + path) + "/") + FileUtils.getFileName(_local_19.url))));
                            goto _label_39;
                        };
                    };
                };
            };
            while (this.processCachedFiles(files), true)
            {
                return;
            };
            var _local_0 = this;
            return;
        }

        private function onScriptLoadFail(e:IOErrorEvent, uiModule:UiModule):void
        {
            _log.error((("Le script du module " + uiModule.id) + " est introuvable"));
            if (!(--this._scriptNum))
            {
                this.launchUiCheck();
            };
            return;
        }

        private function onScriptLoad(e:ResourceLoadedEvent):void
        {
            while (true)
            {
                goto _label_1;
            };
            var _local_5 = _local_5;
            
        _label_1: 
            var uiModule:UiModule = this._unInitializedModules[e.uri.tag];
            var moduleLoader:Loader = new Loader();
            this._moduleScriptLoadedRef[moduleLoader] = uiModule;
            var lc:LoaderContext = new LoaderContext(false, new ApplicationDomain(this._sharedDefinition));
            for (;;moduleLoader.loadBytes((e.resource as ByteArray), lc), goto _label_2, (var _local_0 = this), continue, (uiModule = uiModule))
            {
                goto _label_3;
                
            _label_2: 
                return;
            };
            
        _label_3: 
            moduleLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onModuleScriptLoaded);
            //unresolved jump
            return;
        }

        private function onModuleScriptLoaded(e:Event, uiModule:UiModule=null):void
        {
            while (true)
            {
                goto _label_1;
            };
            
        _label_1: 
            var l:Loader = LoaderInfo(e.target).loader;
            while (l.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onModuleScriptLoaded), true)
            {
                goto _label_2;
            };
            var _local_6 = _local_6;
            
        _label_2: 
            if (!(uiModule))
            {
                goto _label_10;
                
            _label_3: 
                goto _label_7;
                
            _label_4: 
                goto _label_12;
                
            _label_5: 
                uiModule.applicationDomain = l.contentLoaderInfo.applicationDomain;
                goto _label_17;
                
            _label_6: 
                goto _label_13;
                
            _label_7: 
                _log.trace(((((("Load script " + uiModule.id) + ", ") + ((this._moduleCount - this._scriptNum) + 1)) + "/") + this._moduleCount));
                goto _label_9;
            };
            
        _label_8: 
            delete this._loadingModule[uiModule];
            goto _label_3;
            var _local_4 = _local_4;
            
        _label_9: 
            goto _label_16;
            
        _label_10: 
            uiModule = this._moduleScriptLoadedRef[l];
            goto _label_18;
            
        _label_11: 
            uiModule.mainClass = l.content;
            goto _label_15;
            
        _label_12: 
            delete this._disabledModules[uiModule.id];
            goto _label_6;
            var _local_5 = _local_5;
            
        _label_13: 
            Berilia.getInstance().handler.process(new ModuleLoadedMessage(uiModule.id));
            //unresolved jump
            
        _label_14: 
            this._modules[uiModule.id] = uiModule;
            goto _label_4;
            var _local_7 = _local_7;
            
        _label_15: 
            goto _label_14;
            
        _label_16: 
            uiModule.loader = l;
            goto _label_19;
            
        _label_17: 
            goto _label_11;
            
        _label_18: 
            goto _label_8;
            
        _label_19: 
            goto _label_5;
            if (!(--this._scriptNum))
            {
                this.launchUiCheck();
            };
            return;
        }

        private function onShortcutLoad(e:ResourceLoadedEvent):void
        {
            var category:XML;
            var cat:ShortcutCategory;
            var permanent:Boolean;
            var visible:Boolean;
            var required:Boolean;
            var holdKeys:Boolean;
            var shortcut:XML;
            while (true)
            {
                goto _label_1;
            };
            var _local_0 = this;
            
        _label_1: 
            var shortcutsXml:XML = e.resource;
            for each (category in shortcutsXml..category)
            {
                goto _label_3;
                
            _label_2: 
                goto _label_4;
                
            _label_3: 
                //unresolved jump
                
            _label_4: 
                //unresolved jump
                var _local_13 = _local_13;
                for each (shortcut in category..shortcut)
                {
                    if (((!(shortcut.@name)) || (!(shortcut.@name.toString().length))))
                    {
                        goto _label_7;
                        
                    _label_5: 
                        goto _label_8;
                        
                    _label_6: 
                        return;
                        
                    _label_7: 
                        ErrorManager.addError(("Le fichier de raccourci est mal formé, il manque la priopriété name dans le fichier " + e.uri));
                        goto _label_6;
                        var _local_14 = _local_14;
                    };
                    permanent = false;
                    goto _label_5;
                    
                _label_8: 
                    if (((shortcut.@permanent) && ((shortcut.@permanent == "true"))))
                    {
                        goto _label_10;
                    };
                    
                _label_9: 
                    visible = true;
                    goto _label_11;
                    
                _label_10: 
                    permanent = true;
                    goto _label_9;
                    var _local_11 = _local_11;
                    
                _label_11: 
                    if (((shortcut.@visible) && ((shortcut.@visible == "false"))))
                    {
                        goto _label_14;
                        
                    _label_12: 
                        goto _label_16;
                        
                    _label_13: 
                        goto _label_15;
                        
                    _label_14: 
                        visible = false;
                        goto _label_13;
                    };
                    
                _label_15: 
                    required = false;
                    goto _label_12;
                    
                _label_16: 
                    if (((shortcut.@required) && ((shortcut.@required == "true"))))
                    {
                        while ((required = true), true)
                        {
                            goto _label_17;
                        };
                    };
                    
                _label_17: 
                    holdKeys = false;
                    if (((shortcut.@holdKeys) && ((shortcut.@holdKeys == "true"))))
                    {
                        goto _label_19;
                        
                    _label_18: 
                        continue;
                        
                    _label_19: 
                        holdKeys = true;
                        goto _label_21;
                    };
                    
                _label_20: 
                    new Shortcut(shortcut.@name, (shortcut.@textfieldEnabled == "true"), LangManager.getInstance().replaceKey(shortcut.toString()), cat, !(permanent), visible, required, holdKeys, LangManager.getInstance().replaceKey(shortcut.@tooltipContent));
                    goto _label_18;
                    
                _label_21: 
                    goto _label_20;
                };
            };
            return;
        }

        private function onHashLoaded(e:ResourceLoadedEvent):void
        {
            var file:XML;
            _loop_1:
            for each (file in e.resource..file)
            {
                while (true)
                {
                    this._modulesHashs[file.@name.toString()] = file.toString();
                    continue _loop_1;
                };
                var _local_6 = _local_6;
            };
            return;
        }

        private function onAllUiChecked(e:ResourceLoaderProgressEvent):void
        {
            var module:UiModule;
            var url:String;
            var ui:UiData;
            var uiDataList:Array = new Array();
            for each (module in this._unInitializedModules)
            {
                //unresolved jump
                for each (ui in module.uis)
                {
                    uiDataList[UiData(ui).file] = ui;
                };
            };
            this._unparsedXml = [];
            _loop_1:
            for (url in this._clearUi)
            {
                //unresolved jump
                var _local_0 = this;
                
            _label_1: 
                //unresolved jump
                
            _label_2: 
                if (uiDataList[url])
                {
                    while (_local_0._unparsedXml.push(uiDataList[url]), true)
                    {
                        continue _loop_1;
                    };
                    var _local_11 = _local_11;
                };
            };
            this._unparsedXmlCount = (this._unparsedXmlTotalCount = this._unparsedXml.length);
            while (this.parseNextXml(), true)
            {
                return;
            };
            var _local_9 = _local_9;
            return;
        }

        private function parseNextXml():void
        {
            var uiData:UiData;
            var xmlParsor:XmlParsor;
            this._unparsedXmlCount = this._unparsedXml.length;
            if (this._unparsedXml.length)
            {
                if (this._parserAvaibleCount)
                {
                    this._parserAvaibleCount--;
                    for (;;continue, (xmlParsor = xmlParsor))
                    {
                        goto _label_3;
                        
                    _label_1: 
                        goto _label_5;
                        
                    _label_2: 
                        goto _label_7;
                        
                    _label_3: 
                        xmlParsor = new XmlParsor();
                        continue;
                        
                    _label_4: 
                        goto _label_6;
                        xmlParsor.rootPath = uiData.module.rootPath;
                        goto _label_4;
                    };
                    
                _label_5: 
                    xmlParsor.addEventListener(ParsingErrorEvent.ERROR, this.onXmlParsingError);
                    goto _label_2;
                    var _local_3 = _local_3;
                    
                _label_6: 
                    xmlParsor.addEventListener(Event.COMPLETE, this.onXmlParsed, false, 0, true);
                    goto _label_1;
                    var _local_0 = this;
                    
                _label_7: 
                    xmlParsor.processFile(uiData.file);
                };
            }
            else
            {
                BindsManager.getInstance().checkBinds();
                while (true)
                {
                    Berilia.getInstance().handler.process(new AllUiXmlParsedMessage());
                    goto _label_8;
                };
                var _local_6 = _local_6;
                
            _label_8: 
                if (((!(this._useSharedDefinition)) || (this._sharedDefinition)))
                {
                    this.launchModule();
                }
                else
                {
                    this._moduleLaunchWaitForSharedDefinition = true;
                };
            };
            return;
        }

        private function onXmlParsed(e:ParsorEvent):void
        {
            if (e.uiDefinition)
            {
                while ((e.uiDefinition.name = XmlParsor(e.target).url), goto _label_2, UiRenderManager.getInstance().setUiDefinition(e.uiDefinition), true)
                {
                    goto _label_1;
                };
                var _local_3 = _local_3;
                
            _label_1: 
                Berilia.getInstance().handler.process(new UiXmlParsedMessage(e.uiDefinition.name));
                //unresolved jump
                
            _label_2: 
                //unresolved jump
            };
            this._parserAvaibleCount++;
            while (this.parseNextXml(), true)
            {
                return;
            };
            var _local_5 = _local_5;
            return;
        }

        private function onXmlParsingError(e:ParsingErrorEvent):void
        {
            while (Berilia.getInstance().handler.process(new UiXmlParsedErrorMessage(e.url, e.msg)), true)
            {
                return;
            };
            var _local_3 = _local_3;
            return;
        }

        private function onUiLoaded(e:ResourceLoadedEvent):void
        {
            var res:Array;
            var filePath:String;
            var modName:String;
            var templateUri:Uri;
            while (//unresolved jump
, goto _label_2, true)
            {
                goto _label_1;
            };
            
        _label_1: 
            //unresolved jump
            var uriPos = uriPos;
            
        _label_2: 
            if (this._resetState)
            {
                return;
            };
            uriPos = this._uiFiles.indexOf(e.uri);
            this._uiFiles.splice(this._uiFiles.indexOf(e.uri), 1);
            var mod:UiModule = this._unInitializedModules[e.uri.tag.mod];
            var base:String = e.uri.tag.base;
            var md5:String = ((!((this._versions[e.uri.uri] == null))) ? this._versions[e.uri.uri] : MD5.hash((e.resource as String)));
            var versionOk:Boolean = (md5 == UiRenderManager.getInstance().getUiVersion(e.uri.uri));
            if (!(versionOk))
            {
                while ((this._clearUi[e.uri.uri] = md5), true)
                {
                    goto _label_3;
                };
                var _local_14 = _local_14;
                
            _label_3: 
                if (e.uri.tag.template)
                {
                    this._clearUi[e.uri.tag.base] = this._versions[e.uri.tag.base];
                    goto _label_5;
                };
            };
            
        _label_4: 
            this._versions[e.uri.uri] = md5;
            goto _label_6;
            
        _label_5: 
            goto _label_4;
            
        _label_6: 
            var xml:String = (e.resource as String);
            _loop_1:
            while ((res = this._regImport.exec(xml)))
            {
                while (true)
                {
                    goto _label_7;
                };
                
            _label_7: 
                filePath = LangManager.getInstance().replaceKey(res[1]);
                if (filePath.indexOf("mod://") != -1)
                {
                    while (true)
                    {
                        modName = filePath.substr(6, (filePath.indexOf("/", 6) - 6));
                        filePath = (this._modulesPaths[modName] + filePath.substr((6 + modName.length)));
                        //unresolved jump
                    };
                    var _local_12 = _local_12;
                }
                else
                {
                    if ((((filePath.indexOf(":") == -1)) && ((filePath.indexOf("ui/Ankama_Common") == -1))))
                    {
                        filePath = (mod.rootPath + filePath);
                    };
                };
                if (this._clearUi[filePath])
                {
                    this._clearUi[e.uri.uri] = md5;
                    goto _label_10;
                    
                _label_8: 
                    //unresolved jump
                    
                _label_9: 
                    this._clearUi[base] = this._versions[base];
                    goto _label_8;
                    
                _label_10: 
                    goto _label_9;
                    var _local_15 = _local_15;
                }
                else
                {
                    if (!(this._uiLoaded[filePath]))
                    {
                        while (true)
                        {
                            this._uiLoaded[filePath] = true;
                            //unresolved jump
                        };
                        this._uiFileToLoad++;
                        for (;;)
                        {
                            this._uiLoader.load(templateUri, null, TxtAdapter);
                            continue _loop_1;
                            
                        _label_11: 
                            templateUri.tag = {
                                "mod":mod.id,
                                "base":base,
                                "template":true
                            };
                            continue;
                            templateUri = new Uri(filePath);
                            goto _label_11;
                        };
                    };
                };
            };
            if (!(--this._uiFileToLoad))
            {
                while (this.onAllUiChecked(null), true)
                {
                    return;
                };
            };
            return;
        }

        private function searchDmFile(rootPath:File):File
        {
            var file:File;
            var dm:File;
            while (true)
            {
                goto _label_1;
            };
            var _local_8 = _local_8;
            
        _label_1: 
            if (rootPath.nativePath.indexOf(".svn") != -1)
            {
                return (null);
            };
            var files:Array = rootPath.getDirectoryListing();
            _loop_1:
            for each (file in files)
            {
                if (((!(file.isDirectory)) && (file.extension)))
                {
                    if (file.extension.toLowerCase() == "d2ui")
                    {
                        return (file);
                    };
                    if (((!(dm)) && ((file.extension.toLowerCase() == "dm"))))
                    {
                        while ((dm = file), true)
                        {
                            continue _loop_1;
                        };
                        var _local_6 = _local_6;
                    };
                };
            };
            if (dm)
            {
                return (dm);
            };
            for each (file in files)
            {
                if (file.isDirectory)
                {
                    while ((dm = this.searchDmFile(file)), true)
                    {
                        goto _label_2;
                    };
                    
                _label_2: 
                    if (dm)
                    {
                        break;
                    };
                };
            };
            return (dm);
        }

        private function onSharedDefinitionLoad(e:ResourceLoadedEvent):void
        {
            for (;;)
            {
                goto _label_2;
                
            _label_1: 
                //unresolved jump
                continue;
            };
            var sharedSecureComponent = sharedSecureComponent;
            
        _label_2: 
            goto _label_1;
            
        _label_3: 
            var aswf:ASwf = (e.resource as ASwf);
            this._sharedDefinition = aswf.applicationDomain;
            sharedSecureComponent = this._sharedDefinition.getDefinition("d2components::SecureComponent");
            sharedSecureComponent.init(SecureCenter.ACCESS_KEY, SecureCenter.unsecureContent, SecureCenter.secure, SecureCenter.unsecure, DescribeTypeCache.getVariables);
            var sharedReadOnlyData:Object = this._sharedDefinition.getDefinition("utils::ReadOnlyData");
            sharedReadOnlyData.init(SecureCenter.ACCESS_KEY, SecureCenter.unsecureContent, SecureCenter.secure, SecureCenter.unsecure);
            var directAccessObject:Object = this._sharedDefinition.getDefinition("utils::DirectAccessObject");
            goto _label_7;
            
        _label_4: 
            this._sharedDefinitionInstance = Object(aswf.content);
            goto _label_8;
            
        _label_5: 
            while (SecureCenter.init(sharedSecureComponent, sharedReadOnlyData, directAccessObject), goto _label_6, (this._loadModuleFunction = Object(aswf.content).loadModule), true)
            {
                goto _label_9;
            };
            
        _label_6: 
            goto _label_4;
            
        _label_7: 
            directAccessObject.init(SecureCenter.ACCESS_KEY);
            goto _label_5;
            var _local_0 = this;
            
        _label_8: 
            //unresolved jump
            
        _label_9: 
            if (_local_0._waitingInit)
            {
                while (_local_0.init(_local_0._filter, _local_0._filterInclude), true)
                {
                    goto _label_10;
                };
                var _local_6 = _local_6;
            };
            
        _label_10: 
            if (_local_0._moduleLaunchWaitForSharedDefinition)
            {
                while (_local_0.launchModule(), true)
                {
                    return;
                };
            };
            return;
        }


    }
}//package com.ankamagames.berilia.managers

