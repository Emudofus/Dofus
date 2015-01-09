package com.ankamagames.jerakine.data
{
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.jerakine.types.LangMetaData;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.jerakine.JerakineConstants;
    import com.ankamagames.jerakine.types.events.LangFileEvent;
    import com.ankamagames.jerakine.utils.files.FileUtils;
    import flash.events.Event;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;

    public class I18nUpdater extends DataUpdateManager 
    {

        private static var _self:I18nUpdater;

        private var _language:String;
        private var _overrideProvider:Uri;

        public function I18nUpdater()
        {
            if (_self)
            {
                throw (new SingletonError());
            };
        }

        public static function getInstance():I18nUpdater
        {
            if (!(_self))
            {
                _self = new (I18nUpdater)();
            };
            return (_self);
        }


        public function initI18n(language:String, metaFileListe:Uri, clearAll:Boolean=false, overrideProvider:Uri=null):void
        {
            this._language = language;
            this._overrideProvider = overrideProvider;
            super.init(metaFileListe, clearAll);
        }

        override protected function checkFileVersion(sFileName:String, sVersion:String):Boolean
        {
            return (false);
        }

        override public function clear():void
        {
            I18nFileAccessor.getInstance().close();
        }

        override protected function onLoaded(e:ResourceLoadedEvent):void
        {
            var _local_2:LangMetaData;
            var _local_3:Uri;
            var _local_4:uint;
            var file:String;
            switch (e.uri.fileType)
            {
                case "d2i":
                    I18nFileAccessor.getInstance().init(e.uri);
                    if (this._overrideProvider)
                    {
                        I18nFileAccessor.getInstance().addOverrideFile(this._overrideProvider);
                    };
                    _versions[e.uri.tag.file] = e.uri.tag.version;
                    StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_FILES_INFO, _storeKey, _versions);
                    dispatchEvent(new LangFileEvent(LangFileEvent.COMPLETE, false, false, e.uri.tag.file));
                    _dataFilesLoaded = true;
                    _loadedFileCount++;
                    return;
                case "meta":
                    _local_2 = LangMetaData.fromXml(e.resource, e.uri.uri, this.checkFileVersion);
                    _local_4 = 0;
                    for (file in _local_2.clearFile)
                    {
                        if (file.indexOf(("_" + this._language)) == -1)
                        {
                        }
                        else
                        {
                            _local_3 = new Uri(((FileUtils.getFilePath(e.uri.path) + "/") + file));
                            _local_3.tag = {
                                "version":_local_2.clearFile[file],
                                "file":((FileUtils.getFileStartName(e.uri.uri) + ".") + file)
                            };
                            _files.push(_local_3);
                            _local_4++;
                        };
                    };
                    if (_local_4)
                    {
                        _loader.load(_files);
                    }
                    else
                    {
                        dispatchEvent(new Event(Event.COMPLETE));
                    };
                    return;
                default:
                    super.onLoaded(e);
            };
        }


    }
}//package com.ankamagames.jerakine.data

