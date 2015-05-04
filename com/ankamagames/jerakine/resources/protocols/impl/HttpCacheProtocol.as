package com.ankamagames.jerakine.resources.protocols.impl
{
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.crypto.CRC32;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
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
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
   
   public class HttpCacheProtocol extends Object implements IProtocol
   {
      
      public function HttpCacheProtocol()
      {
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
      
      private static var _dataLoading:Dictionary = new Dictionary(true);
      
      private static var _httpDataToLoad:Vector.<Object> = new Vector.<Object>();
      
      private static var _fileDataToLoad:Vector.<Object> = new Vector.<Object>();
      
      private static var _attemptToDownloadFile:Dictionary = new Dictionary(true);
      
      private static var _totalCrcTime:int = 0;
      
      private static var _crc:CRC32 = new CRC32();
      
      private static var _buff_crc:ByteArray = new ByteArray();
      
      private static var _urlRewritePattern;
      
      private static var _urlRewriteReplace;
      
      private static var _remoteLoadingErrorHandler;
      
      public static function init(param1:*, param2:*, param3:Function = null) : void
      {
         _urlRewritePattern = param1;
         _urlRewriteReplace = param2;
         _remoteLoadingErrorHandler = param3;
      }
      
      private static var _pendingFail:Vector.<PendingFail>;
      
      private static const REMOTE_MIN_CHECK_INTERVAL:int = 10000;
      
      private var _parent:AbstractFileProtocol;
      
      private var _serverRootDir:String;
      
      private var _serverRootUnversionedDir:String;
      
      private var _isLoadingFilelist:Boolean = false;
      
      public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void
      {
         if(this._serverRootDir == null)
         {
            this.serverRootDir = XmlConfig.getInstance().getEntry("config.root.path");
         }
         if(_cacheFilesDirectory == "" || !_cacheFilesDirectory)
         {
            _cacheFilesDirectory = XmlConfig.getInstance().getEntry("config.streaming.filelists.directory");
         }
         if(_cachedFileData == null)
         {
            this.loadCacheFile();
         }
         if(!this._isLoadingFilelist)
         {
            if(_dataLoading[this.getLocalPath(param1)] != null)
            {
               _fileDataToLoad.push({
                  "uri":param1,
                  "observer":param2,
                  "dispatchProgress":param3,
                  "adapter":param5
               });
            }
            else
            {
               this.loadFile(param1,param2,param3,param5);
            }
         }
         else if(this.uriIsAlreadyWaitingForHttpDownload(param1))
         {
            _fileDataToLoad.push({
               "uri":param1,
               "observer":param2,
               "dispatchProgress":param3,
               "adapter":param5
            });
         }
         else
         {
            _httpDataToLoad.push({
               "uri":param1,
               "observer":param2,
               "dispatchProgress":param3,
               "adapter":param5
            });
         }
         
      }
      
      private function uriIsAlreadyWaitingForHttpDownload(param1:Uri) : Boolean
      {
         var _loc2_:Object = null;
         for each(_loc2_ in _httpDataToLoad)
         {
            if(_loc2_.uri.path == param1.path)
            {
               return true;
            }
         }
         return false;
      }
      
      private function loadCacheFile() : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:FileStream = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:File = null;
         var _loc7_:Array = null;
         this._isLoadingFilelist = true;
         var _loc1_:File = new File(File.applicationDirectory + File.separator + _cacheFilesDirectory);
         if((_loc1_.exists) && (_loc1_.isDirectory))
         {
            _cachedFileData = new Dictionary();
            _loc2_ = new ByteArray();
            _loc7_ = _loc1_.getDirectoryListing();
            for each(_loc6_ in _loc7_)
            {
               _loc2_.clear();
               _loc3_ = new FileStream();
               _loc3_.open(_loc6_,FileMode.READ);
               _loc3_.readBytes(_loc2_,0,4);
               _loc2_.readByte();
               if(_loc2_.readMultiByte(3,"utf-8") != CACHE_FORMAT_TYPE)
               {
                  throw new Error("Format du fichier incorrect !!");
               }
               else
               {
                  _loc2_.clear();
                  _loc3_.readBytes(_loc2_,0,4);
                  _loc2_.readByte();
                  if(_loc2_.readMultiByte(3,"utf-8") != CACHE_FORMAT_VERSION)
                  {
                     throw new Error("Version du format de fichier incorrect !!");
                  }
                  else
                  {
                     while(_loc3_.bytesAvailable)
                     {
                        _loc4_ = _loc3_.readInt();
                        _loc5_ = _loc3_.readInt();
                        _cachedFileData[_loc4_] = _loc5_;
                     }
                     _loc3_.close();
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
      
      private function loadQueueData() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in _httpDataToLoad)
         {
            this.loadFile(_loc1_.uri,_loc1_.observer,_loc1_.dispatchProgress,_loc1_.adapter);
         }
         _httpDataToLoad = new Vector.<Object>();
      }
      
      private function loadFile(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void
      {
         var _loc7_:ByteArray = null;
         var _loc8_:String = null;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:FileStream = null;
         var _loc5_:String = this.getLocalPath(param1);
         trace("load file " + _loc5_);
         if(_dataLoading[_loc5_] != null)
         {
            _fileDataToLoad.push({
               "uri":param1,
               "observer":param2,
               "dispatchProgress":param3,
               "adapter":param4
            });
            return;
         }
         var _loc6_:File = new File(_loc5_);
         if(_loc6_.exists)
         {
            _loc7_ = new ByteArray();
            _loc8_ = this.getPathForCrc(param1);
            if(_pathCrcList[_loc8_] == null)
            {
               _pathCrcList[_loc8_] = this.getPathIntSum(_loc8_);
            }
            _loc9_ = _pathCrcList[_loc8_];
            if(_calcCachedFileData[_loc9_] == null)
            {
               _loc11_ = new FileStream();
               _loc11_.open(_loc6_,FileMode.READ);
               _loc11_.readBytes(_loc7_,0,_loc6_.size);
               _loc11_.close();
               _calcCachedFileData[_loc9_] = this.getFileIntSum(_loc7_);
            }
            _loc10_ = 0;
            if(!(_calcCachedFileData == null) && !(_calcCachedFileData[_loc9_] == null))
            {
               _loc10_ = _calcCachedFileData[_loc9_];
            }
            if(!(_cachedFileData == null) && _loc10_ == _cachedFileData[_loc9_] && !(_loc10_ == 0))
            {
               _log.debug(param1 + " a jour: ");
               this.loadFromParent(param1,param2,param3,param4);
            }
            else
            {
               _log.debug(param1.path + " mise a jour necessaire");
               _dataLoading[_loc5_] = {
                  "uri":param1,
                  "observer":param2,
                  "dispatchProgress":param3,
                  "adapter":param4
               };
               this.loadDirectlyUri(param1,param3);
            }
         }
         else
         {
            _log.debug(param1 + " inexistant");
            _dataLoading[_loc5_] = {
               "uri":param1,
               "observer":param2,
               "dispatchProgress":param3,
               "adapter":param4
            };
            this.loadDirectlyUri(param1,param3);
         }
      }
      
      private function loadDirectlyUri(param1:Uri, param2:Boolean) : void
      {
         _attemptToDownloadFile[param1] = _attemptToDownloadFile[param1] == null?1:_attemptToDownloadFile[param1] + 1;
         var _loc3_:String = "http://" + param1.path;
         if(_urlRewritePattern)
         {
            _loc3_ = _loc3_.replace(_urlRewritePattern,_urlRewriteReplace);
         }
         this._parent.initAdapter(param1,BinaryAdapter);
         this._parent.adapter.loadDirectly(param1,_loc3_,new ResourceObserverWrapper(this.onRemoteFileLoaded,this.onRemoteFileFailed,this.onRemoteFileProgress),param2);
      }
      
      private function onRemoteFileLoaded(param1:Uri, param2:uint, param3:*) : void
      {
         var _loc4_:String = null;
         if(!AirScanner.isStreamingVersion())
         {
            _loc4_ = this.getLocalPath(param1);
         }
         else
         {
            _loc4_ = this.getPathWithoutAkamaiHack(this.getLocalPath(param1));
         }
         var _loc5_:File = new File(_loc4_);
         var _loc6_:FileStream = new FileStream();
         _loc6_.open(_loc5_,FileMode.WRITE);
         _loc6_.position = 0;
         _loc6_.writeBytes(param3);
         _loc6_.close();
         if(_dataLoading[_loc4_] != null)
         {
            this.loadFromParent(_dataLoading[_loc4_].uri,_dataLoading[_loc4_].observer,_dataLoading[_loc4_].dispatchProgress,_dataLoading[_loc4_].adapter);
            _dataLoading[_loc4_] = null;
         }
      }
      
      private function removeNullValue(param1:Object, param2:int, param3:Vector.<Object>) : Boolean
      {
         return !(param1 == null);
      }
      
      public function getLocalPath(param1:Uri) : String
      {
         var _loc2_:String = param1.normalizedUri.split("|")[0];
         _loc2_ = _loc2_.replace(this._serverRootDir,"");
         _loc2_ = _loc2_.replace(this._serverRootUnversionedDir,"");
         return File.applicationDirectory.nativePath + File.separator + _loc2_;
      }
      
      public function getPathWithoutAkamaiHack(param1:String) : String
      {
         var _loc2_:RegExp = new RegExp("\\/(_[0-9]*_\\/)","i");
         return param1.replace(_loc2_,"/");
      }
      
      private var _lastRemoteCheckTimestamp:Number = 0;
      
      private function onRemoteFileFailed(param1:Uri, param2:String, param3:uint, param4:Boolean = true) : void
      {
         var _loc5_:String = null;
         if((_pendingFail) && (param4))
         {
            _log.warn(param1.path + ": download failed (" + param2 + "), wait for remote check");
            _pendingFail.push(new PendingFail(param1,param2,param3));
            return;
         }
         _log.warn(param1.path + ": download failed (" + param2 + ")");
         if(!(_attemptToDownloadFile[param1] == null) && _attemptToDownloadFile[param1] <= LIMITE_ATTEMPT_FOR_DOWNLOAD)
         {
            _log.warn(param1.path + ": try again");
            if(!AirScanner.isStreamingVersion())
            {
               _loc5_ = this.getLocalPath(param1);
            }
            else
            {
               _loc5_ = this.getPathWithoutAkamaiHack(this.getLocalPath(param1));
            }
            this.loadDirectlyUri(param1,_dataLoading[_loc5_].dispatchProgress);
         }
         else if((param4) && !(_remoteLoadingErrorHandler == null) && getTimer() - this._lastRemoteCheckTimestamp > REMOTE_MIN_CHECK_INTERVAL)
         {
            _log.warn(param1.path + ": download failed (" + param2 + "), wait for remote check (1ft)");
            this._lastRemoteCheckTimestamp = getTimer();
            _pendingFail = new Vector.<PendingFail>();
            _pendingFail.push(new PendingFail(param1,param2,param3));
            _remoteLoadingErrorHandler(this.onRemoteLoadingErrorHandlerResponse);
         }
         else
         {
            this.definitiveFail(param1,param2,param3);
         }
         
      }
      
      private function onRemoteLoadingErrorHandlerResponse(param1:Boolean) : void
      {
         var _loc2_:PendingFail = null;
         for each(_loc2_ in _pendingFail)
         {
            if(param1)
            {
               _attemptToDownloadFile[_loc2_.uri] = 0;
               this.onRemoteFileFailed(_loc2_.uri,_loc2_.errorMsg,_loc2_.errorCode,false);
            }
            else
            {
               this.definitiveFail(_loc2_.uri,_loc2_.errorMsg,_loc2_.errorCode);
            }
         }
      }
      
      private function definitiveFail(param1:Uri, param2:String, param3:uint) : void
      {
         _log.warn(param1.path + ": download definitively failed (" + param2 + ")");
         var _loc4_:* = _dataLoading[param1];
         if((_loc4_) && (_loc4_.observer))
         {
            IResourceObserver(_loc4_.observer).onFailed(param1,param2,param3);
         }
      }
      
      private function onRemoteFileProgress(param1:Uri, param2:uint, param3:uint) : void
      {
      }
      
      private function loadFromParent(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void
      {
         var _loc7_:Object = null;
         var _loc8_:uint = 0;
         var _loc5_:Uri = param1;
         var _loc6_:String = _loc5_.path;
         if(param1.fileType == "swf")
         {
            var param1:Uri = new Uri(this.getLocalPath(param1));
            param1.tag = _loc5_;
            var param4:Class = AdvancedSwfAdapter;
         }
         else if(param1.fileType == "swl")
         {
            param1 = new Uri(this.getLocalPath(param1));
            if(param1.tag == null)
            {
               param1.tag = new Object();
            }
            param1.tag.oldUri = _loc5_;
         }
         else
         {
            param1 = new Uri(this.getLocalPath(param1));
            param1.tag = _loc5_;
         }
         
         this._parent.load(param1,param2,param3,null,param4,false);
         var _loc9_:uint = _fileDataToLoad.length;
         _loc8_ = 0;
         while(_loc8_ < _loc9_)
         {
            _loc7_ = _fileDataToLoad[_loc8_];
            if((_loc7_) && (_loc7_.uri.path == param1.path || _loc7_.uri.path == _loc6_))
            {
               this._parent.load(param1,_loc7_.observer,_loc7_.dispatchProgress,null,_loc7_.adapter,false);
               _fileDataToLoad[_loc8_] = null;
            }
            _loc8_++;
         }
         _fileDataToLoad = _fileDataToLoad.filter(this.removeNullValue);
      }
      
      private function getPathIntSum(param1:String) : int
      {
         _buff_crc.clear();
         _buff_crc.writeUTFBytes(param1);
         _crc.reset();
         _crc.update(_buff_crc);
         return _crc.getValue();
      }
      
      private function getPathForCrc(param1:Uri) : String
      {
         return param1.normalizedUri.replace(this._serverRootDir,"").replace(this._serverRootUnversionedDir,"");
      }
      
      private function getFileIntSum(param1:ByteArray) : int
      {
         _crc.reset();
         _crc.update(param1);
         return _crc.getValue();
      }
      
      public function cancel() : void
      {
         this._parent.cancel();
      }
      
      public function free() : void
      {
         this._parent.free();
      }
      
      public function set serverRootDir(param1:String) : void
      {
         this._serverRootDir = param1;
         this._serverRootUnversionedDir = param1.replace(new RegExp("\\/_[0-9]*_"),"");
      }
   }
}
import com.ankamagames.jerakine.types.Uri;

class PendingFail extends Object
{
   
   function PendingFail(param1:Uri, param2:String, param3:uint)
   {
      super();
      this.uri = param1;
      this.errorMsg = param2;
      this.errorCode = param3;
   }
   
   public var uri:Uri;
   
   public var errorMsg:String;
   
   public var errorCode:uint;
}
