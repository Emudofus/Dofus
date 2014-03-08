package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.berilia.types.data.UiModule;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.dofus.modules.utils.ModuleFilestream;
   import flash.filesystem.File;
   import com.ankamagames.dofus.modules.utils.ModuleFileManager;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   
   public class FileApi extends Object implements IApi
   {
      
      public function FileApi() {
         this._openedFiles = new Dictionary();
         super();
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onError);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
      }
      
      private var _loader:IResourceLoader;
      
      private var _module:UiModule;
      
      private var _openedFiles:Dictionary;
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
      }
      
      public function destroy() : void {
         var _loc1_:* = undefined;
         this._module = null;
         for (_loc1_ in this._openedFiles)
         {
            if(_loc1_)
            {
               try
               {
                  _loc1_.close();
               }
               catch(e:Error)
               {
                  continue;
               }
            }
         }
         this._openedFiles = null;
      }
      
      public function loadXmlFile(param1:String, param2:Function, param3:Function=null) : void {
         if(FileUtils.getExtension(param1).toUpperCase() != "XML")
         {
            throw new ApiError("loadXmlFile can only load file with XML extension");
         }
         else
         {
            if(!param1)
            {
               throw new ApiError("loadXmlFile need a non-null url");
            }
            else
            {
               if(param2 == null)
               {
                  throw new ApiError("loadXmlFile need a non-null success callback function");
               }
               else
               {
                  param1 = this._module.rootPath + param1.replace("..","");
                  _loc4_ = new Uri(param1);
                  _loc4_.tag = 
                     {
                        "loadSuccessCallBack":param2,
                        "loadErrorCallBack":param3
                     };
                  this._loader.load(_loc4_);
                  return;
               }
            }
         }
      }
      
      public function trustedLoadXmlFile(param1:String, param2:Function, param3:Function=null) : void {
         if(FileUtils.getExtension(param1).toUpperCase() != "XML")
         {
            throw new ApiError("loadXmlFile can only load file with XML extension");
         }
         else
         {
            if(!param1)
            {
               throw new ApiError("loadXmlFile need a non-null url");
            }
            else
            {
               if(param2 == null)
               {
                  throw new ApiError("loadXmlFile need a non-null success callback function");
               }
               else
               {
                  _loc4_ = new Uri(param1);
                  _loc4_.tag = 
                     {
                        "loadSuccessCallBack":param2,
                        "loadErrorCallBack":param3
                     };
                  this._loader.load(_loc4_);
                  return;
               }
            }
         }
      }
      
      public function openFile(param1:String, param2:String="update") : ModuleFilestream {
         var _loc3_:ModuleFilestream = new ModuleFilestream(param1,param2,this._module);
         this._openedFiles[_loc3_] = param1;
         return _loc3_;
      }
      
      public function deleteFile(param1:String) : void {
         var param1:String = ModuleFilestream.cleanUrl(param1);
         var _loc2_:File = new File(this._module.storagePath + param1 + ".dmf");
         if((_loc2_.exists) && !_loc2_.isDirectory)
         {
            _loc2_.deleteFile();
         }
      }
      
      public function deleteDir(param1:String, param2:Boolean=true) : void {
         var param1:String = ModuleFilestream.cleanUrl(param1);
         var _loc3_:File = new File(this._module.storagePath + param1);
         if((_loc3_.exists) && (_loc3_.isDirectory))
         {
            _loc3_.deleteDirectory(param2);
         }
      }
      
      public function getDirectoryContent(param1:String=null, param2:Boolean=false, param3:Boolean=false) : Array {
         var _loc6_:Array = null;
         var _loc7_:File = null;
         var param1:String = param1?ModuleFilestream.cleanUrl(param1):"";
         var _loc4_:Array = [];
         var _loc5_:File = new File(this._module.storagePath + param1);
         if((_loc5_.exists) && (_loc5_.isDirectory))
         {
            _loc6_ = _loc5_.getDirectoryListing();
            for each (_loc7_ in _loc6_)
            {
               if(!_loc7_.isDirectory && !param2)
               {
                  _loc4_.push(_loc7_.name.substr(_loc7_.name.lastIndexOf(".dm")));
               }
               if((_loc7_.isDirectory) && !param3)
               {
                  _loc4_.push(_loc7_.name);
               }
            }
         }
         return _loc4_;
      }
      
      public function isDirectory(param1:String) : Boolean {
         var param1:String = param1?ModuleFilestream.cleanUrl(param1):"";
         var _loc2_:File = new File(this._module.storagePath + param1);
         return (_loc2_.exists) && (_loc2_.isDirectory);
      }
      
      public function createDirectory(param1:String) : void {
         var param1:String = param1?ModuleFilestream.cleanUrl(param1):"";
         var _loc2_:File = new File(this._module.storagePath + param1);
         ModuleFilestream.checkCreation(param1,this._module);
         _loc2_.createDirectory();
      }
      
      public function getAvaibleSpace() : uint {
         return ModuleFileManager.getInstance().getAvaibleSpace(this._module.id);
      }
      
      public function getUsedSpace() : uint {
         return ModuleFileManager.getInstance().getUsedSpace(this._module.id);
      }
      
      public function getMaxSpace() : uint {
         return ModuleFileManager.getInstance().getMaxSpace(this._module.id);
      }
      
      public function getUsedFileCount() : uint {
         return ModuleFileManager.getInstance().getUsedFileCount(this._module.id);
      }
      
      public function getMaxFileCount() : uint {
         return ModuleFileManager.getInstance().getMaxFileCount(this._module.id);
      }
      
      private function onLoaded(param1:ResourceLoadedEvent) : void {
         param1.uri.tag.loadSuccessCallBack(param1.resource);
      }
      
      private function onError(param1:ResourceErrorEvent) : void {
         var e:ResourceErrorEvent = param1;
         if(e.uri.tag.loadErrorCallBack)
         {
            try
            {
               e.uri.tag.loadErrorCallBack(e.errorCode,e.errorMsg);
            }
            catch(e:ArgumentError)
            {
               throw new ApiError("loadErrorCallBack on loadXmlFile function need two args : onError(errorCode : uint, errorMsg : String)");
            }
         }
      }
   }
}
