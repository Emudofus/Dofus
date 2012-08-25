package com.ankamagames.jerakine.data
{
    import com.ankamagames.jerakine.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.utils.files.*;
    import flash.events.*;
    import flash.utils.*;

    public class DataUpdateManager extends EventDispatcher
    {
        protected const _log:Logger;
        protected var _loader:IResourceLoader;
        protected var _versions:Array;
        protected var _dataFilesLoaded:Boolean = false;
        protected var _files:Array;
        protected var _loadedFileCount:uint = 0;
        protected var _metaFileListe:Uri;
        protected var _storeKey:String;
        private var _clearAll:Boolean;
        private var _datastoreList:Array;
        public static const SQL_MODE:Boolean = XmlConfig.getInstance().getEntry("config.data.SQLMode") == "true";

        public function DataUpdateManager()
        {
            this._log = Log.getLogger(getQualifiedClassName(DataUpdateManager));
            return;
        }// end function

        public function init(param1:Uri, param2:Boolean = false) : void
        {
            this._metaFileListe = param1;
            this._storeKey = "version_" + this._metaFileListe.uri;
            this._clearAll = param2;
            if (this._clearAll)
            {
                this.clear();
            }
            this.initMetaFileListe();
            return;
        }// end function

        public function initMetaFileListe() : void
        {
            this._versions = this._clearAll ? (new Array()) : (StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_FILES_INFO, this._storeKey, new Array()));
            this._files = new Array();
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE, this.onComplete);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadFailed);
            this._loader.load(this._metaFileListe);
            return;
        }// end function

        public function get files() : Array
        {
            return this._files;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        protected function checkFileVersion(param1:String, param2:String) : Boolean
        {
            return this._versions[param1] == param2;
        }// end function

        protected function onLoaded(event:ResourceLoadedEvent) : void
        {
            var _loc_2:LangMetaData = null;
            var _loc_3:Uri = null;
            var _loc_4:Object = null;
            var _loc_5:String = null;
            switch(event.uri.fileType)
            {
                case "meta":
                {
                    _loc_2 = LangMetaData.fromXml(event.resource, event.uri.uri, this.checkFileVersion);
                    for (_loc_5 in _loc_2.clearFile)
                    {
                        
                        _loc_3 = new Uri(FileUtils.getFilePath(event.uri.path) + "/" + _loc_5);
                        _loc_3.tag = {version:_loc_2.clearFile[_loc_5], file:FileUtils.getFileStartName(event.uri.uri) + "." + _loc_5};
                        this._files.push(_loc_3);
                    }
                    if (_loc_2.clearFileCount)
                    {
                        this._loader.load(this._files);
                    }
                    else
                    {
                        dispatchEvent(new Event(Event.COMPLETE));
                    }
                    break;
                }
                case "swf":
                {
                    this._dataFilesLoaded = true;
                    _loc_4 = event.resource;
                    StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_FILES_INFO, _loc_4.moduleName + "_filelist", _loc_4.fileList);
                    StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_FILES_INFO, _loc_4.moduleName + "_chunkLength", _loc_4.chunkLength);
                    var _loc_6:String = this;
                    var _loc_7:* = this._loadedFileCount + 1;
                    _loc_6._loadedFileCount = _loc_7;
                    this.processFileData(_loc_4, event.uri);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function processFileData(param1:Object, param2:Uri) : void
        {
            return;
        }// end function

        private function onLoadFailed(event:ResourceErrorEvent) : void
        {
            this._log.error("Failed " + event.uri);
            dispatchEvent(new FileEvent(FileEvent.ERROR, event.uri.uri, false));
            return;
        }// end function

        private function onComplete(event:ResourceLoaderProgressEvent) : void
        {
            if (this._dataFilesLoaded)
            {
                dispatchEvent(new Event(Event.COMPLETE));
            }
            return;
        }// end function

    }
}
