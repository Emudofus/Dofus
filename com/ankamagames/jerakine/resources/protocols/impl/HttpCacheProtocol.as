package com.ankamagames.jerakine.resources.protocols.impl
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.impl.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class HttpCacheProtocol extends Object implements IProtocol
    {
        private var _parent:AbstractFileProtocol;
        private var _serverRootDir:String;
        private var _isLoadingFilelist:Boolean = false;
        private var _dataLoading:Dictionary;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(HttpCacheProtocol));
        private static const LIMITE_ATTEMPT_FOR_DOWNLOAD:uint = 2;
        private static const CACHE_FORMAT_VERSION:String = "1.0";
        private static const CACHE_FORMAT_TYPE:String = "D2S";
        private static var _cacheFilesDirectory:String;
        private static var _cachedFileData:Dictionary;
        private static var _calcCachedFileData:Dictionary = new Dictionary(true);
        private static var _pathCrcList:Dictionary = new Dictionary();
        private static var _httpDataToLoad:Vector.<Object> = new Vector.<Object>;
        private static var _fileDataToLoad:Vector.<Object> = new Vector.<Object>;
        private static var _attemptToDownloadFile:Dictionary = new Dictionary(true);
        private static var _totalCrcTime:int = 0;

        public function HttpCacheProtocol()
        {
            this._dataLoading = new Dictionary(true);
            if (AirScanner.hasAir())
            {
                this._parent = new FileProtocol();
            }
            else
            {
                this._parent = new FileFlashProtocol();
            }
            return;
        }// end function

        public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void
        {
            if (this._serverRootDir == null)
            {
                this._serverRootDir = XmlConfig.getInstance().getEntry("config.root.path");
            }
            if (_cacheFilesDirectory == "")
            {
                _cacheFilesDirectory = XmlConfig.getInstance().getEntry("config.streaming.filelists.directory");
            }
            if (_cachedFileData == null)
            {
                this.loadCacheFile();
            }
            if (!this._isLoadingFilelist)
            {
                if (this._dataLoading[param1] != null)
                {
                    _fileDataToLoad.push({uri:param1, observer:param2, dispatchProgress:param3, adapter:param5});
                }
                else
                {
                    this.loadFile(param1, param2, param3, param5);
                }
            }
            else if (this.uriIsAlreadyWaitingForHttpDownload(param1))
            {
                _fileDataToLoad.push({uri:param1, observer:param2, dispatchProgress:param3, adapter:param5});
            }
            else
            {
                _httpDataToLoad.push({uri:param1, observer:param2, dispatchProgress:param3, adapter:param5});
            }
            return;
        }// end function

        private function uriIsAlreadyWaitingForHttpDownload(param1:Uri) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in _httpDataToLoad)
            {
                
                if (_loc_2.uri.path == param1.path)
                {
                    return true;
                }
            }
            return false;
        }// end function

        private function loadCacheFile() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._isLoadingFilelist = true;
            var _loc_1:* = new File(File.applicationDirectory + File.separator + _cacheFilesDirectory);
            if (_loc_1.exists && _loc_1.isDirectory)
            {
                _cachedFileData = new Dictionary();
                _loc_2 = new ByteArray();
                _loc_7 = _loc_1.getDirectoryListing();
                for each (_loc_6 in _loc_7)
                {
                    
                    _loc_2.clear();
                    _loc_3 = new FileStream();
                    _loc_3.open(_loc_6, FileMode.READ);
                    _loc_3.readBytes(_loc_2, 0, 4);
                    _loc_2.readByte();
                    if (_loc_2.readMultiByte(3, "utf-8") != CACHE_FORMAT_TYPE)
                    {
                        throw new Error("Format du fichier incorrect !!");
                    }
                    _loc_2.clear();
                    _loc_3.readBytes(_loc_2, 0, 4);
                    _loc_2.readByte();
                    if (_loc_2.readMultiByte(3, "utf-8") != CACHE_FORMAT_VERSION)
                    {
                        throw new Error("Version du format de fichier incorrect !!");
                    }
                    while (_loc_3.bytesAvailable)
                    {
                        
                        _loc_4 = _loc_3.readInt();
                        _loc_5 = _loc_3.readInt();
                        _cachedFileData[_loc_4] = _loc_5;
                    }
                    _loc_3.close();
                }
            }
            else
            {
                _log.fatal("Impossible de charger les fichiers de streaming !!");
            }
            this._isLoadingFilelist = false;
            if (_httpDataToLoad.length > 0)
            {
                this.loadQueueData();
            }
            return;
        }// end function

        private function loadQueueData() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in _httpDataToLoad)
            {
                
                this.loadFile(_loc_1.uri, _loc_1.observer, _loc_1.dispatchProgress, _loc_1.adapter);
            }
            _httpDataToLoad = new Vector.<Object>;
            return;
        }// end function

        private function loadFile(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            if (this._dataLoading[param1] != null)
            {
                _fileDataToLoad.push({uri:param1, observer:param2, dispatchProgress:param3, adapter:param4});
                return;
            }
            var _loc_5:* = this.getLocalPath(param1);
            trace("load file " + _loc_5);
            var _loc_6:* = new File(_loc_5);
            if (new File(_loc_5).exists)
            {
                _loc_7 = new ByteArray();
                _loc_8 = this.getPathForCrc(param1);
                if (_pathCrcList[_loc_8] == null)
                {
                    _log.debug("Calc crc path for " + param1.path);
                    Chrono.start("crc path file " + _loc_5);
                    _pathCrcList[_loc_8] = this.getPathIntSum(_loc_8);
                    _totalCrcTime = _totalCrcTime + Chrono.stop();
                }
                _loc_9 = _pathCrcList[_loc_8];
                if (_calcCachedFileData[_loc_9] == null)
                {
                    _log.debug("Calc CRC for file " + param1.path);
                    Chrono.start("crc file " + _loc_5);
                    _loc_11 = new FileStream();
                    _loc_11.open(_loc_6, FileMode.READ);
                    _loc_11.readBytes(_loc_7, 0, _loc_6.size);
                    _loc_11.close();
                    _calcCachedFileData[_loc_9] = this.getFileIntSum(_loc_7);
                    _totalCrcTime = _totalCrcTime + Chrono.stop();
                }
                _loc_10 = 0;
                if (_calcCachedFileData != null && _calcCachedFileData[_loc_9] != null)
                {
                    _loc_10 = _calcCachedFileData[_loc_9];
                }
                _log.warn("Total crc: " + _totalCrcTime / 1000 + " secondes");
                if (_cachedFileData != null && _loc_10 == _cachedFileData[_loc_9] && _loc_10 != 0)
                {
                    _log.debug(param1 + " a jour: ");
                    this.loadFromParent(param1, param2, param3, param4);
                }
                else
                {
                    _log.debug(param1.path + " mise a jour necessaire");
                    this._dataLoading[param1] = {uri:param1, observer:param2, dispatchProgress:param3, adapter:param4};
                    this.loadDirectlyUri(param1, param3);
                }
            }
            else
            {
                _log.debug(param1 + " inexistant");
                this._dataLoading[param1] = {uri:param1, observer:param2, dispatchProgress:param3, adapter:param4};
                this.loadDirectlyUri(param1, param3);
            }
            return;
        }// end function

        private function loadDirectlyUri(param1:Uri, param2:Boolean) : void
        {
            _attemptToDownloadFile[param1] = _attemptToDownloadFile[param1] == null ? (1) : ((_attemptToDownloadFile[param1] + 1));
            this._parent.initAdapter(param1, BinaryAdapter);
            this._parent.adapter.loadDirectly(param1, "http://" + param1.path, new ResourceObserverWrapper(this.onRemoteFileLoaded, this.onRemoteFileFailed, this.onRemoteFileProgress), param2);
            return;
        }// end function

        private function onRemoteFileLoaded(param1:Uri, param2:uint, param3) : void
        {
            var _loc_4:* = null;
            if (!AirScanner.isStreamingVersion())
            {
                _loc_4 = this.getLocalPath(param1);
            }
            else
            {
                _loc_4 = this.getPathWithoutAkamaiHack(this.getLocalPath(param1));
            }
            var _loc_5:* = new File(_loc_4);
            var _loc_6:* = new FileStream();
            new FileStream().open(_loc_5, FileMode.WRITE);
            _loc_6.position = 0;
            _loc_6.writeBytes(param3);
            _loc_6.close();
            if (this._dataLoading[param1] != null)
            {
                this.loadFromParent(this._dataLoading[param1].uri, this._dataLoading[param1].observer, this._dataLoading[param1].dispatchProgress, this._dataLoading[param1].adapter);
                this._dataLoading[param1] = null;
            }
            return;
        }// end function

        private function removeNullValue(param1:Object, param2:int, param3:Vector.<Object>) : Boolean
        {
            return param1 != null;
        }// end function

        public function getLocalPath(param1:Uri) : String
        {
            var _loc_2:* = param1.normalizedUri.split("|")[0];
            _loc_2 = _loc_2.replace(this._serverRootDir, "");
            return File.applicationDirectory.nativePath + File.separator + _loc_2;
        }// end function

        public function getPathWithoutAkamaiHack(param1:String) : String
        {
            var _loc_2:* = /\/(_[0-9]*_\/)""\/(_[0-9]*_\/)/i;
            return param1.replace(_loc_2, "/");
        }// end function

        private function onRemoteFileFailed(param1:Uri, param2:String, param3:uint) : void
        {
            _log.warn(param1.path + ": download failed (" + param2 + ")");
            if (_attemptToDownloadFile[param1] != null && _attemptToDownloadFile[param1] <= LIMITE_ATTEMPT_FOR_DOWNLOAD)
            {
                _log.warn(param1.path + ": try again");
                this.loadDirectlyUri(param1, this._dataLoading[param1].dispatchProgress);
            }
            return;
        }// end function

        private function onRemoteFileProgress(param1:Uri, param2:uint, param3:uint) : void
        {
            return;
        }// end function

        private function loadFromParent(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void
        {
            var _loc_6:* = null;
            var _loc_5:* = param1;
            if (param1.fileType == "swf")
            {
                param1 = new Uri(this.getLocalPath(param1));
                param1.tag = _loc_5;
                param4 = AdvancedSwfAdapter;
            }
            else if (param1.fileType == "swl")
            {
                param1 = new Uri(this.getLocalPath(param1));
                if (param1.tag == null)
                {
                    param1.tag = new Object();
                }
                param1.tag.oldUri = _loc_5;
            }
            else
            {
                param1 = new Uri(this.getLocalPath(param1));
                param1.tag = _loc_5;
            }
            this._parent.load(param1, param2, param3, null, param4, false);
            for each (_loc_6 in _fileDataToLoad)
            {
                
                if (_loc_6 != null && _loc_6.uri.path == param1.path)
                {
                    this._parent.load(_loc_6.uri, _loc_6.observer, _loc_6.dispatchProgress, null, _loc_6.adapter, false);
                    _loc_6 = null;
                }
            }
            _fileDataToLoad = _fileDataToLoad.filter(this.removeNullValue);
            return;
        }// end function

        private function getPathIntSum(param1:String) : int
        {
            var _loc_2:* = new CRC32();
            var _loc_3:* = new ByteArray();
            _loc_3.writeUTFBytes(param1);
            _loc_2.update(_loc_3);
            return _loc_2.getValue();
        }// end function

        private function getPathForCrc(param1:Uri) : String
        {
            return param1.normalizedUri.replace(this._serverRootDir, "");
        }// end function

        private function getFileIntSum(param1:ByteArray) : int
        {
            var _loc_2:* = new CRC32();
            _loc_2.update(param1);
            return _loc_2.getValue();
        }// end function

        public function cancel() : void
        {
            this._parent.cancel();
            return;
        }// end function

        public function free() : void
        {
            this._parent.free();
            return;
        }// end function

        public function set serverRootDir(param1:String) : void
        {
            this._serverRootDir = param1;
            return;
        }// end function

    }
}
