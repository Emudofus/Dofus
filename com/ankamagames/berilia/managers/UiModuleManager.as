package com.ankamagames.berilia.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import flash.filesystem.File;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.utils.web.HttpServer;
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
   import __AS3__.vec.Vector;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.api.ApiBinder;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.data.UiGroup;
   import com.ankamagames.berilia.utils.errors.UntrustedApiCallError;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import flash.events.Event;
   import flash.utils.getTimer;
   import com.ankamagames.berilia.types.messages.AllModulesLoadedMessage;
   import com.ankamagames.jerakine.resources.adapters.impl.TxtAdapter;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import com.ankamagames.berilia.utils.UriCacheFactory;
   import com.ankamagames.jerakine.newCache.impl.Cache;
   import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.berilia.types.messages.ModuleRessourceLoadFailedMessage;
   import flash.system.LoaderContext;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
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
   import com.ankamagames.berilia.types.event.ParsorEvent;
   import com.ankamagames.berilia.types.messages.UiXmlParsedMessage;
   import com.ankamagames.berilia.types.messages.UiXmlParsedErrorMessage;
   import com.ankamagames.jerakine.types.ASwf;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   
   public class UiModuleManager extends Object
   {
      
      public function UiModuleManager(dontUseLocalServer:Boolean=false) {
         this._regImport = new RegExp("<Import *url *= *\"([^\"]*)","g");
         this._modulesHashs = new Dictionary();
         this._moduleScriptLoadedRef = new Dictionary();
         this._uiLoaded = new Dictionary();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadError,false,0,true);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoad,false,0,true);
            this._sharedDefinitionLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            this._sharedDefinitionLoader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadError,false,0,true);
            this._sharedDefinitionLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onSharedDefinitionLoad,false,0,true);
            this._uiLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._uiLoader.addEventListener(ResourceErrorEvent.ERROR,this.onUiLoadError,false,0,true);
            this._uiLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onUiLoaded,false,0,true);
            this._cacheLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._moduleLoaders = new Dictionary();
            this._useHttpServer = false;
            if((!dontUseLocalServer) && (ApplicationDomain.currentDomain.hasDefinition("flash.net.ServerSocket")))
            {
               this._useHttpServer = true;
            }
            if(this._useHttpServer)
            {
               HttpServer.getInstance().init(File.applicationDirectory);
            }
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiModuleManager));
      
      private static var _self:UiModuleManager;
      
      public static function getInstance(dontUseLocalServer:Boolean=false) : UiModuleManager {
         if(!_self)
         {
            _self = new UiModuleManager(dontUseLocalServer);
         }
         return _self;
      }
      
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
      
      public function get unInitializedModules() : Array {
         return this._unInitializedModules;
      }
      
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
      
      public function get moduleCount() : uint {
         return this._moduleCount;
      }
      
      public function get unparsedXmlCount() : uint {
         return this._unparsedXmlCount;
      }
      
      public function get unparsedXmlTotalCount() : uint {
         return this._unparsedXmlTotalCount;
      }
      
      public function set sharedDefinitionContainer(path:Uri) : void {
         var url:String = null;
         var sharedDefinitionUri:Uri = null;
         this._useSharedDefinition = !(path == null);
         if(path)
         {
            if(this._useHttpServer)
            {
               url = HttpServer.getInstance().getUrlTo(path.fileName);
               sharedDefinitionUri = new Uri(url);
               _log.debug("sharedDefinition.swf location: " + path.uri + " (" + url + ")");
               this._sharedDefinitionLoader.load(sharedDefinitionUri,null,path.fileType == "swf"?AdvancedSwfAdapter:null);
               _log.info("trying to load sharedDefinition.swf throught an httpServer");
               this._timeOutFrameNumber = StageShareManager.stage.frameRate * 10;
               EnterFrameDispatcher.addEventListener(this.timeOutFrameCount,"frameCount");
            }
            else
            {
               this._sharedDefinitionLoader.load(path,null,path.fileType == "swf"?AdvancedSwfAdapter:null);
               _log.info("trying to load sharedDefinition.swf the good ol\' way");
            }
         }
      }
      
      public function get sharedDefinition() : ApplicationDomain {
         return this._sharedDefinition;
      }
      
      public function get ready() : Boolean {
         return !(this._sharedDefinition == null);
      }
      
      public function get sharedDefinitionInstance() : Object {
         return this._sharedDefinitionInstance;
      }
      
      public function get modulesHashs() : Dictionary {
         return this._modulesHashs;
      }
      
      public function init(filter:Array, filterInclude:Boolean) : void {
         var uri:Uri = null;
         var file:File = null;
         this._filter = filter;
         this._filterInclude = filterInclude;
         if(!this._sharedDefinition)
         {
            this._waitingInit = true;
            return;
         }
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
         if(AirScanner.hasAir())
         {
            ProtocolFactory.addProtocol("mod",ModProtocol);
         }
         else
         {
            ProtocolFactory.addProtocol("mod",ModFlashProtocol);
         }
         var uiRoot:String = LangManager.getInstance().getEntry("config.mod.path");
         if((!(uiRoot.substr(0,2) == "\\\\")) && (!(uiRoot.substr(1,2) == ":/")))
         {
            this._modulesRoot = new File(File.applicationDirectory.nativePath + File.separator + uiRoot);
         }
         else
         {
            this._modulesRoot = new File(uiRoot);
         }
         uri = new Uri(this._modulesRoot.nativePath + "/hash.metas");
         this._loader.load(uri);
         BindsManager.getInstance().initialize();
         if(this._modulesRoot.exists)
         {
            for each (file in this._modulesRoot.getDirectoryListing())
            {
               if(!((!file.isDirectory) || (file.name.charAt(0) == ".")))
               {
                  if(!(filter.indexOf(file.name) == -1) == filterInclude)
                  {
                     this.loadModule(file.name);
                  }
               }
            }
            return;
         }
         ErrorManager.addError("Impossible de trouver le dossier contenant les modules (url: " + LangManager.getInstance().getEntry("config.mod.path") + ")");
      }
      
      public function lightInit(moduleList:Vector.<UiModule>) : void {
         var m:UiModule = null;
         this._resetState = false;
         this._modules = new Array();
         this._modulesPaths = new Dictionary();
         for each (this._modules[m.id] in moduleList)
         {
            this._modulesPaths[m.id] = m.rootPath;
         }
      }
      
      public function getModules() : Array {
         return this._modules;
      }
      
      public function getModule(name:String, includeUnInitialized:Boolean=false) : UiModule {
         var module:UiModule = this._modules[name];
         if((includeUnInitialized) && (!module))
         {
            module = this._unInitializedModules[name];
         }
         return module;
      }
      
      public function get disabledModules() : Array {
         return this._disabledModules;
      }
      
      public function reset() : void {
         var module:UiModule = null;
         _log.warn("Reset des modules");
         this._resetState = true;
         if(this._loader)
         {
            this._loader.cancel();
         }
         if(this._cacheLoader)
         {
            this._cacheLoader.cancel();
         }
         if(this._uiLoader)
         {
            this._uiLoader.cancel();
         }
         TooltipManager.clearCache();
         for each (module in this._modules)
         {
            this.unloadModule(module.id);
         }
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
      
      public function getModulePath(moduleName:String) : String {
         return this._modulesPaths[moduleName];
      }
      
      public function loadModule(id:String) : void {
         var dmFile:File = null;
         var uri:Uri = null;
         var modulePath:String = null;
         var len:* = 0;
         var substr:String = null;
         this.unloadModule(id);
         var targetedModuleFolder:File = this._modulesRoot.resolvePath(id);
         if(targetedModuleFolder.exists)
         {
            dmFile = this.searchDmFile(targetedModuleFolder);
            if(dmFile)
            {
               this._moduleCount++;
               this._scriptNum++;
               if(dmFile.nativePath.indexOf("app:/") == 0)
               {
                  len = "app:/".length;
                  substr = dmFile.nativePath.substring(len,dmFile.url.length);
                  uri = new Uri(substr);
                  modulePath = substr.substr(0,substr.lastIndexOf("/"));
               }
               else
               {
                  uri = new Uri(dmFile.nativePath);
                  modulePath = dmFile.parent.nativePath;
               }
               uri.tag = dmFile;
               this._modulesPaths[id] = modulePath;
               this._loader.load(uri);
            }
            else
            {
               _log.error("Cannot found .dm or .d2ui file in " + targetedModuleFolder.url);
            }
         }
      }
      
      public function unloadModule(id:String) : void {
         var uiCtr:UiRootContainer = null;
         var ui:String = null;
         var group:UiGroup = null;
         var variables:Array = null;
         var varName:String = null;
         var apiList:Vector.<Object> = null;
         var api:Object = null;
         if(this._modules == null)
         {
            return;
         }
         var m:UiModule = this._modules[id];
         if(!m)
         {
            return;
         }
         var moduleUiInstances:Array = [];
         for each (uiCtr in Berilia.getInstance().uiList)
         {
            _log.trace("UI " + uiCtr.name + " >> " + uiCtr.uiModule.id + " (@" + uiCtr.uiModule.instanceId + ")");
            if(uiCtr.uiModule == m)
            {
               moduleUiInstances.push(uiCtr.name);
            }
         }
         for each (ui in moduleUiInstances)
         {
            Berilia.getInstance().unloadUi(ui);
         }
         for each (group in m.groups)
         {
            UiGroupManager.getInstance().removeGroup(group.name);
         }
         variables = DescribeTypeCache.getVariables(m.mainClass,true);
         for each (varName in variables)
         {
            if(m.mainClass[varName] is Object)
            {
               m.mainClass[varName] = null;
            }
         }
         m.destroy();
         apiList = m.apiList;
         while(apiList.length)
         {
            api = apiList.shift();
            if((api) && (api.hasOwnProperty("destroy")))
            {
               try
               {
                  api["destroy"]();
               }
               catch(e:UntrustedApiCallError)
               {
                  api["destroy"](SecureCenter.ACCESS_KEY);
                  continue;
               }
            }
         }
         if((m.mainClass) && (m.mainClass.hasOwnProperty("unload")))
         {
            m.mainClass["unload"]();
         }
         BindsManager.getInstance().removeEventListenerByName("__module_" + m.id);
         KernelEventsManager.getInstance().removeEventListenerByName("__module_" + m.id);
         delete this._modules[[id]];
         this._disabledModules[id] = m;
      }
      
      public function checkSharedDefinitionHash(hashUrl:String) : void {
         var hashUri:Uri = new Uri(hashUrl);
      }
      
      private function onTimeOut() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function timeOutFrameCount(e:Event) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function launchModule() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function launchUiCheck() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function processCachedFiles(files:Array) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onLoadError(e:ResourceErrorEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function switchToNoHttpMode() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onUiLoadError(e:ResourceErrorEvent) : void {
         if(_loc4_)
         {
            if(!_loc4_)
            {
               while(true)
               {
                  if(!_loc5_)
                  {
                     if(_loc4_)
                     {
                        if(_loc4_)
                        {
                           if(!_loc5_)
                           {
                              if(_loc4_)
                              {
                              }
                           }
                        }
                        if(_loc4_)
                        {
                        }
                     }
                     if(_loc4_)
                     {
                     }
                  }
                  ErrorManager.addError("Impossible de charger le fichier d\'interface ");
                  if(!_loc5_)
                  {
                     if(_loc4_)
                     {
                     }
                     if(_loc5_)
                     {
                     }
                     Berilia.getInstance().handler.process(new ModuleRessourceLoadFailedMessage(e.uri.tag,e.uri));
                     if(!_loc5_)
                     {
                        break;
                     }
                  }
                  else
                  {
                     break;
                  }
                  break;
               }
               if(_loc4_)
               {
               }
               if(_loc4_)
               {
               }
               if(!_loc5_)
               {
                  this._uiFileToLoad--;
               }
            }
            while(true)
            {
               if(!_loc4_)
               {
                  if(_loc5_)
                  {
                  }
                  Berilia.getInstance().handler.process(new ModuleRessourceLoadFailedMessage(e.uri.tag,e.uri));
                  if(_loc5_)
                  {
                  }
               }
               else
               {
                  if(!_loc5_)
                  {
                     if(_loc4_)
                     {
                        if(_loc4_)
                        {
                           if(!_loc5_)
                           {
                              if(_loc4_)
                              {
                              }
                           }
                        }
                        if(_loc4_)
                        {
                        }
                     }
                     if(_loc4_)
                     {
                     }
                  }
                  ErrorManager.addError("Impossible de charger le fichier d\'interface ");
                  if(!_loc5_)
                  {
                     if(!_loc4_)
                     {
                        continue;
                     }
                     if(_loc5_)
                     {
                     }
                     Berilia.getInstance().handler.process(new ModuleRessourceLoadFailedMessage(e.uri.tag,e.uri));
                     if(_loc5_)
                     {
                     }
                  }
               }
               if(_loc4_)
               {
               }
               if(_loc4_)
               {
               }
               if(!_loc5_)
               {
                  this._uiFileToLoad--;
               }
            }
         }
      }
      
      private function onLoad(e:ResourceLoadedEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onDMLoad(e:ResourceLoadedEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onScriptLoadFail(e:IOErrorEvent, uiModule:UiModule) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private var _moduleScriptLoadedRef:Dictionary;
      
      private function onScriptLoad(e:ResourceLoadedEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onModuleScriptLoaded(e:Event, uiModule:UiModule=null) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onShortcutLoad(e:ResourceLoadedEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onHashLoaded(e:ResourceLoadedEvent) : void {
         var _loc6_:* = true;
         if(!_loc5_)
         {
            if(_loc6_)
            {
            }
            if(!_loc5_)
            {
               if(_loc6_)
               {
                  loop0:
                  while(e.resource..file hasNext _loc3_)
                  {
                     if(_loc6_)
                     {
                     }
                     if(_loc6_)
                     {
                        if(!_loc6_)
                        {
                           while(true)
                           {
                              this._modulesHashs[file.@name.toString()] = file.toString();
                           }
                        }
                        while(true)
                        {
                           if(_loc5_)
                           {
                              break;
                           }
                           this._modulesHashs[file.@name.toString()] = file.toString();
                        }
                        if(_loc5_)
                        {
                        }
                        continue;
                     }
                     while(true)
                     {
                        if(_loc5_)
                        {
                           if(!_loc5_)
                           {
                              this._modulesHashs[file.@name.toString()] = file.toString();
                              continue;
                           }
                        }
                        if(_loc5_)
                        {
                        }
                        continue loop0;
                     }
                  }
               }
            }
         }
      }
      
      private function onAllUiChecked(e:ResourceLoaderProgressEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function parseNextXml() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onXmlParsed(e:ParsorEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onXmlParsingError(e:ParsingErrorEvent) : void {
         var _loc3_:* = false;
         if(!_loc3_)
         {
            if(_loc3_)
            {
               while(_loc3_)
               {
                  break;
               }
               return;
            }
            while(true)
            {
               if(_loc2_)
               {
               }
               Berilia.getInstance().handler.process(new UiXmlParsedErrorMessage(e.url,e.msg));
            }
         }
         while(true)
         {
            if(_loc2_)
            {
               if(_loc3_)
               {
                  if(_loc2_)
                  {
                  }
                  Berilia.getInstance().handler.process(new UiXmlParsedErrorMessage(e.url,e.msg));
                  continue;
               }
            }
            return;
         }
      }
      
      private function onUiLoaded(e:ResourceLoadedEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private var _uiLoaded:Dictionary;
      
      private function searchDmFile(rootPath:File) : File {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onSharedDefinitionLoad(e:ResourceLoadedEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private var _loadModuleFunction:Function;
   }
}
