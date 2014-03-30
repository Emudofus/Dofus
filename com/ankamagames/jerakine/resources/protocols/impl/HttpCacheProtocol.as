package com.ankamagames.jerakine.resources.protocols.impl
{
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.crypto.CRC32;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.resources.protocols.AbstractFileProtocol;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.data.XmlConfig;
   import flash.filesystem.FileStream;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import com.ankamagames.jerakine.resources.adapters.impl.BinaryAdapter;
   import com.ankamagames.jerakine.resources.ResourceObserverWrapper;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
   
   public class HttpCacheProtocol extends Object implements IProtocol
   {
      
      public function HttpCacheProtocol() {
         this._dataLoading = new Dictionary(true);
         super();
         if(AirScanner.hasAir())
         {
            this._parent = new FileProtocol();
         }
         else
         {
            this._parent = new FileFlashProtocol();
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HttpCacheProtocol));
      
      private static const LIMITE_ATTEMPT_FOR_DOWNLOAD:uint = 2;
      
      private static const CACHE_FORMAT_VERSION:String = "1.0";
      
      private static const CACHE_FORMAT_TYPE:String = "D2S";
      
      private static var _cacheFilesDirectory:String;
      
      private static var _cachedFileData:Dictionary;
      
      private static var _calcCachedFileData:Dictionary = new Dictionary(true);
      
      private static var _pathCrcList:Dictionary = new Dictionary();
      
      private static var _httpDataToLoad:Vector.<Object> = new Vector.<Object>();
      
      private static var _fileDataToLoad:Vector.<Object> = new Vector.<Object>();
      
      private static var _attemptToDownloadFile:Dictionary = new Dictionary(true);
      
      private static var _totalCrcTime:int = 0;
      
      private static var _crc:CRC32 = new CRC32();
      
      private static var _buff_crc:ByteArray = new ByteArray();
      
      private static var _urlRewritePattern;
      
      private static var _urlRewriteReplace;
      
      public static function init(replacePattern:*, replaceNeedle:*) : void {
         _urlRewritePattern = replacePattern;
         _urlRewriteReplace = replaceNeedle;
      }
      
      private var _parent:AbstractFileProtocol;
      
      private var _serverRootDir:String;
      
      private var _serverRootUnversionedDir:String;
      
      private var _isLoadingFilelist:Boolean = false;
      
      private var _dataLoading:Dictionary;
      
      public function load(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, cache:ICache, forcedAdapter:Class, singleFile:Boolean) : void {
         if(this._serverRootDir == null)
         {
            this.serverRootDir = XmlConfig.getInstance().getEntry("config.root.path");
         }
         if((_cacheFilesDirectory == "") || (!_cacheFilesDirectory))
         {
            _cacheFilesDirectory = XmlConfig.getInstance().getEntry("config.streaming.filelists.directory");
         }
         if(_cachedFileData == null)
         {
            this.loadCacheFile();
         }
         if(!this._isLoadingFilelist)
         {
            if(this._dataLoading[uri] != null)
            {
               _fileDataToLoad.push(
                  {
                     "uri":uri,
                     "observer":observer,
                     "dispatchProgress":dispatchProgress,
                     "adapter":forcedAdapter
                  });
            }
            else
            {
               this.loadFile(uri,observer,dispatchProgress,forcedAdapter);
            }
         }
         else
         {
            if(this.uriIsAlreadyWaitingForHttpDownload(uri))
            {
               _fileDataToLoad.push(
                  {
                     "uri":uri,
                     "observer":observer,
                     "dispatchProgress":dispatchProgress,
                     "adapter":forcedAdapter
                  });
            }
            else
            {
               _httpDataToLoad.push(
                  {
                     "uri":uri,
                     "observer":observer,
                     "dispatchProgress":dispatchProgress,
                     "adapter":forcedAdapter
                  });
            }
         }
      }
      
      private function uriIsAlreadyWaitingForHttpDownload(uri:Uri) : Boolean {
         var data:Object = null;
         for each (data in _httpDataToLoad)
         {
            if(data.uri.path == uri.path)
            {
               return true;
            }
         }
         return false;
      }
      
      private function loadCacheFile() : void {
         var data:ByteArray = null;
         var fs:FileStream = null;
         var index:* = 0;
         var value:* = 0;
         var streamingFile:File = null;
         var dirListing:Array = null;
         this._isLoadingFilelist = true;
         var streamingFilelists:File = new File(File.applicationDirectory + File.separator + _cacheFilesDirectory);
         if((streamingFilelists.exists) && (streamingFilelists.isDirectory))
         {
            _cachedFileData = new Dictionary();
            data = new ByteArray();
            dirListing = streamingFilelists.getDirectoryListing();
            for each (streamingFile in dirListing)
            {
               data.clear();
               fs = new FileStream();
               fs.open(streamingFile,FileMode.READ);
               fs.readBytes(data,0,4);
               data.readByte();
               if(data.readMultiByte(3,"utf-8") != CACHE_FORMAT_TYPE)
               {
                  throw new Error("Format du fichier incorrect !!");
               }
               else
               {
                  data.clear();
                  fs.readBytes(data,0,4);
                  data.readByte();
                  if(data.readMultiByte(3,"utf-8") != CACHE_FORMAT_VERSION)
                  {
                     throw new Error("Version du format de fichier incorrect !!");
                  }
                  else
                  {
                     while(fs.bytesAvailable)
                     {
                        index = fs.readInt();
                        value = fs.readInt();
                        _cachedFileData[index] = value;
                     }
                     fs.close();
                     continue;
                  }
               }
            }
         }
         else
         {
            _log.fatal("Impossible de charger les fichiers de streaming !!");
         }
         this._isLoadingFilelist = false;
         if(_httpDataToLoad.length > 0)
         {
            this.loadQueueData();
         }
      }
      
      private function loadQueueData() : void {
         var file:Object = null;
         for each (file in _httpDataToLoad)
         {
            this.loadFile(file.uri,file.observer,file.dispatchProgress,file.adapter);
         }
         _httpDataToLoad = new Vector.<Object>();
      }
      
      private function loadFile(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, adapter:Class) : void {
         var data:ByteArray = null;
         var pathForCrc:String = null;
         var arrayIndex:* = 0;
         var cachedCrcFile:* = 0;
         var stream:FileStream = null;
         if(this._dataLoading[uri] != null)
         {
            _fileDataToLoad.push(
               {
                  "uri":uri,
                  "observer":observer,
                  "dispatchProgress":dispatchProgress,
                  "adapter":adapter
               });
            return;
         }
         var path:String = this.getLocalPath(uri);
         trace("load file " + path);
         var file:File = new File(path);
         if(file.exists)
         {
            data = new ByteArray();
            pathForCrc = this.getPathForCrc(uri);
            if(_pathCrcList[pathForCrc] == null)
            {
               _pathCrcList[pathForCrc] = this.getPathIntSum(pathForCrc);
            }
            arrayIndex = _pathCrcList[pathForCrc];
            if(_calcCachedFileData[arrayIndex] == null)
            {
               stream = new FileStream();
               stream.open(file,FileMode.READ);
               stream.readBytes(data,0,file.size);
               stream.close();
               _calcCachedFileData[arrayIndex] = this.getFileIntSum(data);
            }
            cachedCrcFile = 0;
            if((!(_calcCachedFileData == null)) && (!(_calcCachedFileData[arrayIndex] == null)))
            {
               cachedCrcFile = _calcCachedFileData[arrayIndex];
            }
            if((!(_cachedFileData == null)) && (cachedCrcFile == _cachedFileData[arrayIndex]) && (!(cachedCrcFile == 0)))
            {
               _log.debug(uri + " a jour: ");
               this.loadFromParent(uri,observer,dispatchProgress,adapter);
            }
            else
            {
               _log.debug(uri.path + " mise a jour necessaire");
               this._dataLoading[uri] = 
                  {
                     "uri":uri,
                     "observer":observer,
                     "dispatchProgress":dispatchProgress,
                     "adapter":adapter
                  };
               this.loadDirectlyUri(uri,dispatchProgress);
            }
         }
         else
         {
            _log.debug(uri + " inexistant");
            this._dataLoading[uri] = 
               {
                  "uri":uri,
                  "observer":observer,
                  "dispatchProgress":dispatchProgress,
                  "adapter":adapter
               };
            this.loadDirectlyUri(uri,dispatchProgress);
         }
      }
      
      private function loadDirectlyUri(uri:Uri, dispatchProgress:Boolean) : void {
         _attemptToDownloadFile[uri] = _attemptToDownloadFile[uri] == null?1:_attemptToDownloadFile[uri] + 1;
         var realPath:String = "http://" + uri.path;
         if(_urlRewritePattern)
         {
            realPath = realPath.replace(_urlRewritePattern,_urlRewriteReplace);
         }
         this._parent.initAdapter(uri,BinaryAdapter);
         this._parent.adapter.loadDirectly(uri,realPath,new ResourceObserverWrapper(this.onRemoteFileLoaded,this.onRemoteFileFailed,this.onRemoteFileProgress),dispatchProgress);
      }
      
      private function onRemoteFileLoaded(uri:Uri, resourceType:uint, resource:*) : void {
         var path:String = null;
         if(!AirScanner.isStreamingVersion())
         {
            path = this.getLocalPath(uri);
         }
         else
         {
            path = this.getPathWithoutAkamaiHack(this.getLocalPath(uri));
         }
         var f:File = new File(path);
         var fileStream:FileStream = new FileStream();
         fileStream.open(f,FileMode.WRITE);
         fileStream.position = 0;
         fileStream.writeBytes(resource);
         fileStream.close();
         if(this._dataLoading[uri] != null)
         {
            this.loadFromParent(this._dataLoading[uri].uri,this._dataLoading[uri].observer,this._dataLoading[uri].dispatchProgress,this._dataLoading[uri].adapter);
            this._dataLoading[uri] = null;
         }
      }
      
      private function removeNullValue(item:Object, index:int, vector:Vector.<Object>) : Boolean {
         return !(item == null);
      }
      
      public function getLocalPath(uri:Uri) : String {
         var newuri:String = uri.normalizedUri.split("|")[0];
         newuri = newuri.replace(this._serverRootDir,"");
         newuri = newuri.replace(this._serverRootUnversionedDir,"");
         return File.applicationDirectory.nativePath + File.separator + newuri;
      }
      
      public function getPathWithoutAkamaiHack(inStr:String) : String {
         var pattern:RegExp = new RegExp("\\/(_[0-9]*_\\/)","i");
         return inStr.replace(pattern,"/");
      }
      
      private function onRemoteFileFailed(uri:Uri, errorMsg:String, errorCode:uint) : void {
         var data:* = undefined;
         _log.warn(uri.path + ": download failed (" + errorMsg + ")");
         if((!(_attemptToDownloadFile[uri] == null)) && (_attemptToDownloadFile[uri] <= LIMITE_ATTEMPT_FOR_DOWNLOAD))
         {
            _log.warn(uri.path + ": try again");
            this.loadDirectlyUri(uri,this._dataLoading[uri].dispatchProgress);
         }
         else
         {
            _log.warn(uri.path + ": download definitively failed (" + errorMsg + ")");
            data = this._dataLoading[uri];
            if((data) && (data.observer))
            {
               IResourceObserver(data.observer).onFailed(uri,errorMsg,errorCode);
            }
         }
      }
      
      private function onRemoteFileProgress(uri:Uri, bytesLoaded:uint, bytesTotal:uint) : void {
      }
      
      private function loadFromParent(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, adapter:Class) : void {
         var d:Object = null;
         var oldUri:Uri = uri;
         if(uri.fileType == "swf")
         {
            uri = new Uri(this.getLocalPath(uri));
            uri.tag = oldUri;
            adapter = AdvancedSwfAdapter;
         }
         else
         {
            if(uri.fileType == "swl")
            {
               uri = new Uri(this.getLocalPath(uri));
               if(uri.tag == null)
               {
                  uri.tag = new Object();
               }
               uri.tag.oldUri = oldUri;
            }
            else
            {
               uri = new Uri(this.getLocalPath(uri));
               uri.tag = oldUri;
            }
         }
         this._parent.load(uri,observer,dispatchProgress,null,adapter,false);
         for each (d in _fileDataToLoad)
         {
            if((!(d == null)) && (d.uri.path == uri.path))
            {
               this._parent.load(d.uri,d.observer,d.dispatchProgress,null,d.adapter,false);
               d = null;
            }
         }
         _fileDataToLoad = _fileDataToLoad.filter(this.removeNullValue);
      }
      
      private function getPathIntSum(path:String) : int {
         _buff_crc.clear();
         _buff_crc.writeUTFBytes(path);
         _crc.reset();
         _crc.update(_buff_crc);
         return _crc.getValue();
      }
      
      private function getPathForCrc(uri:Uri) : String {
         return uri.normalizedUri.replace(this._serverRootDir,"").replace(this._serverRootUnversionedDir,"");
      }
      
      private function getFileIntSum(data:ByteArray) : int {
         _crc.reset();
         _crc.update(data);
         return _crc.getValue();
      }
      
      public function cancel() : void {
         this._parent.cancel();
      }
      
      public function free() : void {
         this._parent.free();
      }
      
      public function set serverRootDir(value:String) : void {
         this._serverRootDir = value;
         this._serverRootUnversionedDir = value.replace(new RegExp("\\/_[0-9]*_"),"");
      }
   }
}
