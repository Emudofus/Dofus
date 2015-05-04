package com.ankamagames.dofus.modules.utils
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.connection.frames.AuthentificationFrame;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.system.LoaderContext;
   import flash.filesystem.File;
   import nochump.util.zip.ZipFile;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   import com.ankamagames.dofus.modules.utils.actions.ModuleListRequestAction;
   import com.ankamagames.dofus.modules.utils.actions.ModuleInstallRequestAction;
   import com.ankamagames.dofus.modules.utils.actions.ModuleDeleteRequestAction;
   import com.ankamagames.dofus.modules.utils.actions.InstalledModuleInfoRequestAction;
   import com.ankamagames.berilia.utils.ModuleInspector;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import flash.filesystem.FileMode;
   import com.ankamagames.dofus.modules.utils.actions.ModuleInstallConfirmAction;
   import com.ankamagames.dofus.modules.utils.actions.InstalledModuleListRequestAction;
   import com.ankamagames.dofus.modules.utils.actions.ModuleInstallCancelAction;
   import com.ankamagames.jerakine.json.JSON;
   import nochump.util.zip.ZipEntry;
   import com.ankamagames.jerakine.utils.crypto.CRC32;
   
   public class ModuleInstallerFrame extends Object implements Frame
   {
      
      public function ModuleInstallerFrame()
      {
         this._installedModuleDm = new Dictionary();
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthentificationFrame));
      
      private static const _priority:int = Priority.NORMAL;
      
      private var _loader:IResourceLoader;
      
      private var _contextLoader:LoaderContext;
      
      private var _modulesDirectory:File;
      
      private var _pendingZipToInstall:ZipFile;
      
      private var _pendingZipDm:XML;
      
      private var _installedModuleDm:Dictionary;
      
      public function pushed() : Boolean
      {
         this._contextLoader = new LoaderContext();
         this._contextLoader.checkPolicyFile = true;
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadError);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoad);
         var _loc1_:String = LangManager.getInstance().getEntry("config.mod.path");
         if(!(_loc1_.substr(0,2) == "\\\\") && !(_loc1_.substr(1,2) == ":/"))
         {
            this._modulesDirectory = new File(File.applicationDirectory.nativePath + File.separator + _loc1_);
         }
         else
         {
            this._modulesDirectory = new File(_loc1_);
         }
         return true;
      }
      
      public function pulled() : Boolean
      {
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onLoadError);
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onLoad);
         return true;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:Uri = null;
         var _loc3_:Uri = null;
         var _loc4_:String = null;
         var _loc5_:XML = null;
         var _loc6_:File = null;
         var _loc7_:FileStream = null;
         var _loc8_:ByteArray = null;
         var _loc9_:* = undefined;
         switch(true)
         {
            case param1 is ModuleListRequestAction:
               _loc2_ = new Uri(ModuleListRequestAction(param1).moduleListUrl);
               _loc2_.loaderContext = this._contextLoader;
               this._loader.load(_loc2_);
               return true;
            case param1 is ModuleInstallRequestAction:
               _loc3_ = new Uri(ModuleInstallRequestAction(param1).moduleUrl);
               _loc3_.loaderContext = this._contextLoader;
               this._loader.load(_loc3_);
               return true;
            case param1 is ModuleDeleteRequestAction:
               this.deleteModule(ModuleDeleteRequestAction(param1).moduleDirectory);
               return true;
            case param1 is InstalledModuleListRequestAction:
               this.searchInstalledModule();
               return true;
            case param1 is InstalledModuleInfoRequestAction:
               _loc4_ = InstalledModuleInfoRequestAction(param1).moduleId;
               _loc5_ = this._installedModuleDm[_loc4_];
               if(!_loc5_)
               {
                  _loc5_ = ModuleInspector.getDmFile(new File(this._modulesDirectory.nativePath + File.separator + _loc4_));
                  this._installedModuleDm[_loc4_] = _loc5_;
                  if(!_loc5_)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError,7);
                     break;
                  }
               }
               _loc6_ = new File(this._modulesDirectory.nativePath + File.separator + _loc4_ + File.separator + _loc5_.script);
               _loc7_ = new FileStream();
               _loc8_ = new ByteArray();
               _loc7_.open(_loc6_,FileMode.READ);
               _loc7_.readBytes(_loc8_);
               _loc7_.close();
               _loc9_ = ModuleInspector.getScriptHookAndAction(_loc8_);
               KernelEventsManager.getInstance().processCallback(HookList.ApisHooksActionsList,_loc9_);
               return true;
            case param1 is ModuleInstallConfirmAction:
               if(ModuleInstallConfirmAction(param1).isUpdate)
               {
                  this.updateModule();
               }
               else
               {
                  this.installModule();
               }
               this._pendingZipToInstall = null;
               this._pendingZipDm = null;
               return true;
            case param1 is ModuleInstallCancelAction:
               this._pendingZipToInstall = null;
               this._pendingZipDm = null;
               KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationProgress,-1);
               return true;
         }
         return false;
      }
      
      public function get priority() : int
      {
         return _priority;
      }
      
      private function onLoad(param1:ResourceLoadedEvent) : void
      {
         var _loc2_:* = undefined;
         switch(param1.uri.fileType.toLowerCase())
         {
            case "json":
               _loc2_ = com.ankamagames.jerakine.json.JSON.decode(param1.resource,true);
               if(_loc2_ is Array)
               {
                  this.processJsonList(_loc2_);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ModuleList,[]);
               }
               break;
            case "zip":
               this._pendingZipToInstall = param1.resource;
               this.getZippedModuleInformations(param1.resource);
               break;
            default:
               KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError,2);
         }
      }
      
      private function processJsonList(param1:*) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         var _loc6_:XML = null;
         for each(_loc2_ in param1)
         {
            _loc6_ = this._installedModuleDm[_loc2_.author + "_" + _loc2_.name];
            if(_loc6_)
            {
               _loc2_.exist = true;
               _loc2_.upToDate = true;
               _loc3_ = String(_loc6_.header.version).split(".");
               _loc4_ = String(_loc2_.version).split(".");
               while(_loc3_.length < _loc4_.length)
               {
                  _loc3_.push(0);
               }
               while(_loc3_.length > _loc4_.length)
               {
                  _loc4_.push(0);
               }
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  if(_loc3_[_loc5_] < _loc4_[_loc5_])
                  {
                     _loc2_.upToDate = false;
                  }
                  _loc5_++;
               }
               _loc2_.isEnabled = _loc6_.header.isEnabled;
            }
            else
            {
               _loc2_.exist = false;
            }
         }
         KernelEventsManager.getInstance().processCallback(HookList.ModuleList,param1);
      }
      
      private function getZippedModuleInformations(param1:ZipFile) : void
      {
         var _loc3_:ZipEntry = null;
         var _loc4_:ByteArray = null;
         var _loc6_:* = undefined;
         var _loc2_:XML = ModuleInspector.getZipDmFile(param1);
         if(!_loc2_ || !ModuleInspector.checkArchiveValidity(param1))
         {
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError,3);
            return;
         }
         this._pendingZipDm = _loc2_;
         var _loc5_:String = _loc2_.script;
         for each(_loc3_ in param1.entries)
         {
            if(_loc3_.name == _loc5_)
            {
               _loc4_ = param1.getInput(_loc3_);
               break;
            }
         }
         if(_loc4_)
         {
            _loc6_ = ModuleInspector.getScriptHookAndAction(_loc4_);
            KernelEventsManager.getInstance().processCallback(HookList.ApisHooksActionsList,_loc6_);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError,3);
         }
      }
      
      private function installModule() : void
      {
         var _loc1_:ZipEntry = null;
         var _loc2_:FileStream = null;
         var _loc3_:File = null;
         var _loc4_:ByteArray = null;
         if(!this._pendingZipDm || !this._pendingZipToInstall)
         {
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError,6);
            return;
         }
         var _loc5_:File = new File(this._modulesDirectory.nativePath + File.separator + this._pendingZipDm.header.author + "_" + this._pendingZipDm.header.name);
         _loc5_.createDirectory();
         var _loc6_:int = this._pendingZipToInstall.entries.length;
         var _loc7_:* = 0;
         for each(_loc1_ in this._pendingZipToInstall.entries)
         {
            _loc7_++;
            _loc3_ = new File(_loc5_.nativePath + File.separator + _loc1_.name);
            if(!_loc3_.exists)
            {
               if(_loc1_.isDirectory())
               {
                  _loc3_.createDirectory();
               }
               else
               {
                  this.writeZipEntry(_loc4_,_loc1_,_loc2_,_loc3_,this._pendingZipToInstall);
               }
               continue;
            }
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError,6);
            return;
         }
         if(_loc7_ == _loc6_)
         {
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationProgress,1);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError,6);
         }
         this._installedModuleDm[this._pendingZipDm.header.author + "_" + this._pendingZipDm.header.name] = this._pendingZipDm;
      }
      
      private function updateModule() : void
      {
         var _loc1_:ZipEntry = null;
         var _loc2_:FileStream = null;
         var _loc3_:FileStream = null;
         var _loc4_:File = null;
         var _loc5_:ByteArray = null;
         var _loc10_:ByteArray = null;
         var _loc11_:uint = 0;
         var _loc6_:CRC32 = new CRC32();
         if(!this._pendingZipDm || !this._pendingZipToInstall)
         {
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError,3);
            return;
         }
         var _loc7_:File = new File(this._modulesDirectory.nativePath + File.separator + this._pendingZipDm.header.author + "_" + this._pendingZipDm.header.name);
         if(!_loc7_.exists)
         {
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationProgress,4);
         }
         var _loc8_:int = this._pendingZipToInstall.entries.length;
         var _loc9_:* = 0;
         for each(_loc1_ in this._pendingZipToInstall.entries)
         {
            _loc9_++;
            _loc4_ = new File(_loc7_.nativePath + File.separator + _loc1_.name);
            if(!_loc4_.exists)
            {
               if(_loc1_.isDirectory())
               {
                  _loc4_.createDirectory();
               }
               else
               {
                  this.writeZipEntry(_loc5_,_loc1_,_loc2_,_loc4_,this._pendingZipToInstall);
               }
            }
            else if(!_loc1_.isDirectory())
            {
               _loc10_ = new ByteArray();
               _loc3_ = new FileStream();
               _loc3_.open(_loc4_,FileMode.READ);
               _loc3_.readBytes(_loc10_,0,_loc3_.bytesAvailable);
               _loc3_.close();
               _loc6_.update(_loc10_,0,_loc10_.bytesAvailable);
               _loc11_ = _loc6_.getValue();
               if(_loc11_ != _loc1_.crc)
               {
                  _loc4_.deleteFile();
                  this.writeZipEntry(_loc5_,_loc1_,_loc2_,_loc4_,this._pendingZipToInstall);
               }
            }
            
         }
         if(_loc9_ == _loc8_)
         {
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationProgress,1);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError,3);
         }
      }
      
      private function writeZipEntry(param1:ByteArray, param2:ZipEntry, param3:FileStream, param4:File, param5:ZipFile) : void
      {
         var param1:ByteArray = param5.getInput(param2);
         var param3:FileStream = new FileStream();
         param3.open(param4,FileMode.WRITE);
         param3.writeBytes(param1,0,param1.bytesAvailable);
         param3.close();
      }
      
      private function deleteModule(param1:String) : void
      {
         var _loc2_:File = new File(this._modulesDirectory.nativePath + File.separator + param1);
         if(!_loc2_.exists)
         {
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError,5);
         }
         else
         {
            _loc2_.deleteDirectory(true);
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationProgress,-1);
         }
         this._installedModuleDm[param1] = null;
      }
      
      private function searchInstalledModule() : void
      {
         var _loc2_:File = null;
         var _loc4_:XML = null;
         var _loc5_:* = false;
         var _loc1_:File = this._modulesDirectory;
         var _loc3_:XML = <Root></Root>;
         for each(_loc2_ in _loc1_.getDirectoryListing())
         {
            if(_loc2_.isDirectory)
            {
               _loc4_ = ModuleInspector.getDmFile(_loc2_);
               if(_loc4_)
               {
                  _loc5_ = ModuleInspector.checkIfModuleTrusted(_loc2_.nativePath + File.separator + _loc4_.script);
                  _loc4_.header.isTrusted = _loc5_;
                  _loc4_.header.isEnabled = ModuleInspector.isModuleEnabled(_loc2_.name,_loc5_);
                  this._installedModuleDm[_loc2_.name] = _loc4_;
                  _loc3_.appendChild(_loc4_.header);
               }
            }
         }
         KernelEventsManager.getInstance().processCallback(HookList.InstalledModuleList,_loc3_.toXMLString());
      }
      
      private function onLoadError(param1:ResourceErrorEvent) : void
      {
         _log.error("Cannot load file " + param1.uri + "(" + param1.errorMsg + ")");
         if(param1.uri.fileType.toLowerCase() == "json")
         {
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError,1);
         }
         else if(param1.uri.fileType.toLowerCase() == "zip")
         {
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError,8);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError,0);
         }
         
      }
   }
}
