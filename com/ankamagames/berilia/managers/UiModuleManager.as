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
   import by.blooddy.crypto.MD5;
   import com.ankamagames.jerakine.types.ASwf;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   
   public class UiModuleManager extends Object
   {
      
      public function UiModuleManager(param1:Boolean=false) {
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
            if(!param1 && (ApplicationDomain.currentDomain.hasDefinition("flash.net.ServerSocket")))
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
      
      public static function getInstance(param1:Boolean=false) : UiModuleManager {
         if(!_self)
         {
            _self = new UiModuleManager(param1);
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
      
      private var _unInitializedModule:Array;
      
      private var _useHttpServer:Boolean;
      
      private var _moduleLoaders:Dictionary;
      
      private var _loadingModule:Dictionary;
      
      private var _disabledModule:Array;
      
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
      
      public function set sharedDefinitionContainer(param1:Uri) : void {
         this._useSharedDefinition = !(param1 == null);
         if(param1)
         {
            if(this._useHttpServer)
            {
               this._sharedDefinitionLoader.load(new Uri(HttpServer.getInstance().getUrlTo(param1.fileName)),null,param1.fileType == "swf"?AdvancedSwfAdapter:null);
               _log.info("trying to load sharedDefinition.swf throught an httpServer");
               this._timeOutFrameNumber = StageShareManager.stage.frameRate * 2;
               EnterFrameDispatcher.addEventListener(this.timeOutFrameCount,"frameCount");
            }
            else
            {
               this._sharedDefinitionLoader.load(param1,null,param1.fileType == "swf"?AdvancedSwfAdapter:null);
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
      
      public function init(param1:Array, param2:Boolean) : void {
         var _loc4_:Uri = null;
         var _loc5_:File = null;
         this._filter = param1;
         this._filterInclude = param2;
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
         this._unInitializedModule = new Array();
         this._loadingModule = new Dictionary();
         this._disabledModule = [];
         if(AirScanner.hasAir())
         {
            ProtocolFactory.addProtocol("mod",ModProtocol);
         }
         else
         {
            ProtocolFactory.addProtocol("mod",ModFlashProtocol);
         }
         var _loc3_:String = LangManager.getInstance().getEntry("config.mod.path");
         if(!(_loc3_.substr(0,2) == "\\\\") && !(_loc3_.substr(1,2) == ":/"))
         {
            this._modulesRoot = new File(File.applicationDirectory.nativePath + File.separator + _loc3_);
         }
         else
         {
            this._modulesRoot = new File(_loc3_);
         }
         _loc4_ = new Uri(this._modulesRoot.nativePath + "/hash.metas");
         this._loader.load(_loc4_);
         BindsManager.getInstance().initialize();
         if(this._modulesRoot.exists)
         {
            for each (_loc5_ in this._modulesRoot.getDirectoryListing())
            {
               if(!(!_loc5_.isDirectory || _loc5_.name.charAt(0) == "."))
               {
                  if(!(param1.indexOf(_loc5_.name) == -1) == param2)
                  {
                     this.loadModule(_loc5_.name);
                  }
               }
            }
            return;
         }
         ErrorManager.addError("Impossible de trouver le dossier contenant les modules (url: " + LangManager.getInstance().getEntry("config.mod.path") + ")");
      }
      
      public function lightInit(param1:Vector.<UiModule>) : void {
         var _loc2_:UiModule = null;
         this._resetState = false;
         this._modules = new Array();
         this._modulesPaths = new Dictionary();
         for each (this._modules[_loc2_.id] in param1)
         {
            this._modulesPaths[_loc2_.id] = _loc2_.rootPath;
         }
      }
      
      public function getModules() : Array {
         return this._modules;
      }
      
      public function getModule(param1:String) : UiModule {
         return this._modules[param1];
      }
      
      public function get disabledModule() : Array {
         return this._disabledModule;
      }
      
      public function reset() : void {
         var _loc1_:UiModule = null;
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
         Shortcut.reset();
         TooltipManager.clearCache();
         Berilia.getInstance().reset();
         ApiBinder.reset();
         KernelEventsManager.getInstance().initialize();
         for each (_loc1_ in this._modules)
         {
            this.unloadModule(_loc1_.id);
         }
         this._modules = [];
         this._uiFileToLoad = 0;
         this._scriptNum = 0;
         this._moduleCount = 0;
         this._parserAvaibleCount = 2;
         this._modulesPaths = new Dictionary();
      }
      
      public function getModulePath(param1:String) : String {
         return this._modulesPaths[param1];
      }
      
      public function loadModule(param1:String) : void {
         var _loc3_:File = null;
         var _loc4_:Uri = null;
         var _loc5_:String = null;
         var _loc6_:* = 0;
         var _loc7_:String = null;
         this.unloadModule(param1);
         var _loc2_:File = this._modulesRoot.resolvePath(param1);
         if(_loc2_.exists)
         {
            _loc3_ = this.searchDmFile(_loc2_);
            if(_loc3_)
            {
               this._moduleCount++;
               this._scriptNum++;
               if(_loc3_.nativePath.indexOf("app:/") == 0)
               {
                  _loc6_ = "app:/".length;
                  _loc7_ = _loc3_.nativePath.substring(_loc6_,_loc3_.url.length);
                  _loc4_ = new Uri(_loc7_);
                  _loc5_ = _loc7_.substr(0,_loc7_.lastIndexOf("/"));
               }
               else
               {
                  _loc4_ = new Uri(_loc3_.nativePath);
                  _loc5_ = _loc3_.parent.nativePath;
               }
               _loc4_.tag = _loc3_;
               this._modulesPaths[param1] = _loc5_;
               this._loader.load(_loc4_);
            }
            else
            {
               _log.error("Cannot found .dm or .d2ui file in " + _loc2_.url);
            }
         }
      }
      
      public function unloadModule(param1:String) : void {
         var uiCtr:UiRootContainer = null;
         var ui:String = null;
         var group:UiGroup = null;
         var variables:Array = null;
         var varName:String = null;
         var apiList:Vector.<Object> = null;
         var api:Object = null;
         var id:String = param1;
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
         this._disabledModule[id] = m;
      }
      
      public function checkSharedDefinitionHash(param1:String) : void {
         var _loc2_:Uri = new Uri(param1);
      }
      
      private function onTimeOut() : void {
         var _loc1_:* = false;
         if(!_loc1_)
         {
            _log.error("SharedDefinition load Timeout");
            if(!_loc1_)
            {
               if(_loc1_)
               {
                  while(true)
                  {
                     EnterFrameDispatcher.removeEventListener(this.timeOutFrameCount);
                     if(_loc2_)
                     {
                        if(!_loc1_)
                        {
                           break;
                        }
                        break;
                     }
                  }
                  return;
               }
               while(true)
               {
                  this.switchToNoHttpMode();
               }
            }
         }
         while(true)
         {
            if(_loc2_)
            {
               EnterFrameDispatcher.removeEventListener(this.timeOutFrameCount);
               if(_loc2_)
               {
                  if(_loc1_)
                  {
                     this.switchToNoHttpMode();
                     continue;
                  }
               }
               else
               {
                  continue;
               }
            }
            return;
         }
      }
      
      private function timeOutFrameCount(param1:Event) : void {
         var _loc4_:* = true;
         var _loc5_:* = false;
         if(!_loc5_)
         {
            if(_loc5_)
            {
            }
            if(_loc4_)
            {
               _loc2_._timeOutFrameNumber = _loc3_;
            }
            if(!_loc5_)
            {
               if(_loc4_)
               {
               }
               if(this._timeOutFrameNumber <= 0)
               {
                  if(_loc5_)
                  {
                  }
               }
            }
            this.onTimeOut();
         }
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
         var _loc1_:* = true;
         var _loc2_:* = false;
         if(!_loc2_)
         {
            this._uiFileToLoad = this._uiFiles.length;
            if(_loc2_)
            {
            }
            return;
         }
         if(this._uiFiles.length)
         {
            if(_loc1_)
            {
               this._uiLoader.load(this._uiFiles,null,TxtAdapter);
               if(_loc2_)
               {
               }
            }
         }
         else
         {
            this.onAllUiChecked(null);
         }
      }
      
      private function processCachedFiles(param1:Array) : void {
         var _loc8_:* = false;
         var _loc9_:* = true;
         var _loc2_:Uri = null;
         var _loc3_:Uri = null;
         if(_loc9_)
         {
            if(_loc8_)
            {
            }
            if(!_loc8_)
            {
               if(!_loc8_)
               {
                  for each (_loc3_ in param1)
                  {
                     if(!_loc8_)
                     {
                        if(_loc9_)
                        {
                           if(!_loc8_)
                           {
                              if("css" === _loc7_)
                              {
                                 if(_loc9_)
                                 {
                                 }
                              }
                              else
                              {
                                 if(_loc9_)
                                 {
                                 }
                                 if("jpg" !== _loc7_)
                                 {
                                    if(_loc9_)
                                    {
                                    }
                                 }
                                 if("jpg" === _loc7_)
                                 {
                                 }
                              }
                              if(_loc9_)
                              {
                              }
                           }
                           if("css" === _loc7_)
                           {
                              if(_loc9_)
                              {
                                 if(_loc9_)
                                 {
                                 }
                                 if(_loc9_)
                                 {
                                 }
                              }
                              if(_loc9_)
                              {
                              }
                           }
                           else
                           {
                              if("png" !== _loc7_)
                              {
                                 if(_loc9_)
                                 {
                                 }
                              }
                              if("png" === _loc7_)
                              {
                              }
                           }
                           if(_loc9_)
                           {
                           }
                        }
                        if(_loc9_)
                        {
                           if(_loc9_)
                           {
                           }
                        }
                        else
                        {
                           if(_loc9_)
                           {
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function onLoadError(param1:ResourceErrorEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function switchToNoHttpMode() : void {
         var _loc3_:* = true;
         if(_loc3_)
         {
            this._useHttpServer = false;
            if(_loc2_)
            {
            }
            this._sharedDefinitionLoader.cancel();
            _loc1_ = new Uri("SharedDefinitions.swf");
            if(_loc3_)
            {
               _loc1_.loaderContext = new LoaderContext(false,new ApplicationDomain());
               if(_loc3_)
               {
               }
               return;
            }
            this.sharedDefinitionContainer = _loc1_;
            return;
         }
         _log.fatal("Failed Loading SharedDefinitions, Going no HttpServer Style !");
         if(!_loc2_)
         {
            this._sharedDefinitionLoader.cancel();
         }
         var _loc1_:Uri = new Uri("SharedDefinitions.swf");
         if(_loc3_)
         {
            _loc1_.loaderContext = new LoaderContext(false,new ApplicationDomain());
            if(_loc3_)
            {
            }
            return;
         }
         this.sharedDefinitionContainer = _loc1_;
      }
      
      private function onUiLoadError(param1:ResourceErrorEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onLoad(param1:ResourceLoadedEvent) : void {
         var _loc3_:* = false;
         var _loc4_:* = true;
         if(!_loc3_)
         {
            if(this._resetState)
            {
               if(_loc4_)
               {
               }
            }
            else
            {
               if(_loc4_)
               {
                  if("swf" === _loc2_)
                  {
                     if(_loc3_)
                     {
                     }
                     if(_loc3_)
                     {
                     }
                  }
                  else
                  {
                     if(!_loc3_)
                     {
                        if("swfs" === _loc2_)
                        {
                           if(_loc3_)
                           {
                           }
                        }
                        else
                        {
                           if(_loc4_)
                           {
                              if("d2ui" === _loc2_)
                              {
                                 if(_loc4_)
                                 {
                                    if(_loc3_)
                                    {
                                    }
                                 }
                                 else
                                 {
                                    if(_loc3_)
                                    {
                                    }
                                 }
                              }
                              else
                              {
                                 if(_loc4_)
                                 {
                                 }
                              }
                           }
                           if("d2ui" === _loc2_)
                           {
                              if(_loc3_)
                              {
                              }
                           }
                           else
                           {
                              if(_loc4_)
                              {
                              }
                           }
                        }
                     }
                     if("swfs" === _loc2_)
                     {
                        if(_loc3_)
                        {
                        }
                     }
                     else
                     {
                        if(_loc4_)
                        {
                        }
                        if("xml" === _loc2_)
                        {
                           if(_loc3_)
                           {
                           }
                        }
                        else
                        {
                           if(_loc4_)
                           {
                           }
                        }
                     }
                  }
               }
               if("swf" === _loc2_)
               {
                  if(_loc4_)
                  {
                  }
               }
               else
               {
                  if("metas" === _loc2_)
                  {
                     if(_loc3_)
                     {
                     }
                  }
                  else
                  {
                     if(_loc4_)
                     {
                     }
                  }
               }
            }
            if(this._resetState)
            {
               return;
            }
            return;
         }
      }
      
      private function onDMLoad(param1:ResourceLoadedEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onScriptLoadFail(param1:IOErrorEvent, param2:UiModule) : void {
         var _loc5_:* = false;
         var _loc6_:* = true;
         if(!_loc5_)
         {
            if(_loc6_)
            {
               if(_loc6_)
               {
               }
            }
            _log.error("Le script du module ");
            if(_loc6_)
            {
               if(_loc6_)
               {
                  if(_loc6_)
                  {
                     _loc3_._scriptNum = _loc4_;
                  }
               }
               if(!(_loc3_._scriptNum-1))
               {
                  if(_loc6_)
                  {
                     this.launchUiCheck();
                  }
               }
            }
         }
      }
      
      private var _moduleScriptLoadedRef:Dictionary;
      
      private function onScriptLoad(param1:ResourceLoadedEvent) : void {
         var _loc6_:* = false;
         var _loc2_:UiModule = this._unInitializedModule[param1.uri.tag];
         if(!_loc6_)
         {
            this._moduleScriptLoadedRef[_loc3_] = _loc2_;
         }
         var _loc4_:LoaderContext = new LoaderContext(false,new ApplicationDomain(this._sharedDefinition));
         if(_loc5_)
         {
            AirScanner.allowByteCodeExecution(_loc4_,true);
            if(!_loc6_)
            {
               if(_loc6_)
               {
                  while(true)
                  {
                     _loc3_.loadBytes(param1.resource as ByteArray,_loc4_);
                     if(_loc5_)
                     {
                        if(!_loc6_)
                        {
                           break;
                        }
                        break;
                     }
                  }
                  return;
               }
               while(true)
               {
                  _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onModuleScriptLoaded);
               }
            }
         }
         while(true)
         {
            if(!_loc6_)
            {
               _loc3_.loadBytes(param1.resource as ByteArray,_loc4_);
               if(_loc5_)
               {
                  if(_loc6_)
                  {
                     _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onModuleScriptLoaded);
                     continue;
                  }
               }
               else
               {
                  continue;
               }
            }
            return;
         }
      }
      
      private function onModuleScriptLoaded(param1:Event, param2:UiModule=null) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onShortcutLoad(param1:ResourceLoadedEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onHashLoaded(param1:ResourceLoadedEvent) : void {
         var _loc6_:* = false;
         var _loc2_:XML = null;
         if(!_loc6_)
         {
            if(_loc5_)
            {
            }
            if(!_loc6_)
            {
               if(_loc5_)
               {
                  for each (_loc2_ in param1.resource..file)
                  {
                     if(!_loc6_)
                     {
                        this._modulesHashs[_loc2_.@name.toString()] = _loc2_.toString();
                     }
                  }
               }
            }
         }
      }
      
      private function onAllUiChecked(param1:ResourceLoaderProgressEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function parseNextXml() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onXmlParsed(param1:ParsorEvent) : void {
         var _loc4_:* = true;
         var _loc5_:* = false;
         if(param1.uiDefinition)
         {
            param1.uiDefinition.name = XmlParsor(param1.target).url;
            UiRenderManager.getInstance().setUiDefinition(param1.uiDefinition);
            Berilia.getInstance().handler.process(new UiXmlParsedMessage(param1.uiDefinition.name));
         }
         if(_loc4_)
         {
            _loc2_._parserAvaibleCount = _loc3_;
         }
         this.parseNextXml();
      }
      
      private function onXmlParsingError(param1:ParsingErrorEvent) : void {
         var _loc3_:* = false;
         if(!_loc3_)
         {
            Berilia.getInstance().handler.process(new UiXmlParsedErrorMessage(param1.url,param1.msg));
         }
      }
      
      private function onUiLoaded(param1:ResourceLoadedEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private var _uiLoaded:Dictionary;
      
      private function searchDmFile(param1:File) : File {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: EmptyStackException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onSharedDefinitionLoad(param1:ResourceLoadedEvent) : void {
         var _loc6_:* = false;
         var _loc7_:* = true;
         if(_loc7_)
         {
            EnterFrameDispatcher.removeEventListener(this.timeOutFrameCount);
         }
         var _loc2_:ASwf = param1.resource as ASwf;
         if(_loc7_)
         {
            this._sharedDefinition = _loc2_.applicationDomain;
         }
         var _loc3_:Object = this._sharedDefinition.getDefinition("d2components::SecureComponent");
         if(!_loc6_)
         {
            _loc3_.init(SecureCenter.ACCESS_KEY,SecureCenter.unsecureContent,SecureCenter.secure,SecureCenter.unsecure,DescribeTypeCache.getVariables);
         }
         var _loc4_:* = this._sharedDefinition.getDefinition("utils::ReadOnlyData");
         (this._sharedDefinition.getDefinition("utils::ReadOnlyData")).init(SecureCenter.ACCESS_KEY,SecureCenter.unsecureContent,SecureCenter.secure,SecureCenter.unsecure);
         var _loc5_:Object = this._sharedDefinition.getDefinition("utils::DirectAccessObject");
         _loc5_.init(SecureCenter.ACCESS_KEY);
         if(_loc7_)
         {
            SecureCenter.init(_loc3_,_loc4_,_loc5_);
            this._sharedDefinitionInstance = Object(_loc2_.content);
         }
         this._loadModuleFunction = Object(_loc2_.content).loadModule;
         if(!_loc6_)
         {
            if(this._waitingInit)
            {
               this.init(this._filter,this._filterInclude);
            }
         }
         if(this._waitingInit)
         {
            this.launchModule();
         }
      }
      
      private var _loadModuleFunction:Function;
   }
}
