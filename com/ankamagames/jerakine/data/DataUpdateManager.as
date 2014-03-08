package com.ankamagames.jerakine.data
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.JerakineConstants;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceLoaderProgressEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.types.LangMetaData;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import flash.events.Event;
   import com.ankamagames.jerakine.types.events.FileEvent;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class DataUpdateManager extends EventDispatcher
   {
      
      public function DataUpdateManager() {
         super();
      }
      
      public static const SQL_MODE:Boolean = XmlConfig.getInstance().getEntry("config.data.SQLMode") == "true";
      
      protected const _log:Logger = Log.getLogger(getQualifiedClassName(DataUpdateManager));
      
      protected var _loader:IResourceLoader;
      
      protected var _versions:Array;
      
      protected var _dataFilesLoaded:Boolean = false;
      
      protected var _files:Array;
      
      protected var _loadedFileCount:uint = 0;
      
      protected var _metaFileListe:Uri;
      
      protected var _storeKey:String;
      
      private var _clearAll:Boolean;
      
      private var _datastoreList:Array;
      
      public function init(param1:Uri, param2:Boolean=false) : void {
         this._metaFileListe = param1;
         this._storeKey = "version_" + this._metaFileListe.uri;
         this._clearAll = param2;
         if(this._clearAll)
         {
            this.clear();
         }
         this.initMetaFileListe();
      }
      
      public function initMetaFileListe() : void {
         this._versions = this._clearAll?new Array():StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_FILES_INFO,this._storeKey,new Array());
         this._files = new Array();
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._loader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onComplete);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadFailed);
         this._loader.load(this._metaFileListe);
      }
      
      public function get files() : Array {
         return this._files;
      }
      
      public function clear() : void {
      }
      
      protected function checkFileVersion(param1:String, param2:String) : Boolean {
         return this._versions[param1] == param2;
      }
      
      protected function onLoaded(param1:ResourceLoadedEvent) : void {
         var _loc2_:LangMetaData = null;
         var _loc3_:Uri = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         switch(param1.uri.fileType)
         {
            case "meta":
               _loc2_ = LangMetaData.fromXml(param1.resource,param1.uri.uri,this.checkFileVersion);
               for (_loc5_ in _loc2_.clearFile)
               {
                  _loc3_ = new Uri(FileUtils.getFilePath(param1.uri.path) + "/" + _loc5_);
                  _loc3_.tag = 
                     {
                        "version":_loc2_.clearFile[_loc5_],
                        "file":FileUtils.getFileStartName(param1.uri.uri) + "." + _loc5_
                     };
                  this._files.push(_loc3_);
               }
               if(_loc2_.clearFileCount)
               {
                  this._loader.load(this._files);
               }
               else
               {
                  dispatchEvent(new Event(Event.COMPLETE));
               }
               break;
            case "swf":
               this._dataFilesLoaded = true;
               _loc4_ = param1.resource;
               StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_FILES_INFO,_loc4_.moduleName + "_filelist",_loc4_.fileList);
               StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_FILES_INFO,_loc4_.moduleName + "_chunkLength",_loc4_.chunkLength);
               this._loadedFileCount++;
               this.processFileData(_loc4_,param1.uri);
               break;
         }
      }
      
      protected function processFileData(param1:Object, param2:Uri) : void {
      }
      
      private function onLoadFailed(param1:ResourceErrorEvent) : void {
         this._log.error("Failed " + param1.uri);
         dispatchEvent(new FileEvent(FileEvent.ERROR,param1.uri.uri,false));
      }
      
      private function onComplete(param1:ResourceLoaderProgressEvent) : void {
         if(this._dataFilesLoaded)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
   }
}
