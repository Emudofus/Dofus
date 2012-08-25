package com.ankamagames.jerakine.data
{
    import com.ankamagames.jerakine.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.files.*;
    import flash.events.*;

    public class I18nUpdater extends DataUpdateManager
    {
        private var _language:String;
        private var _overrideProvider:Uri;
        private static var _self:I18nUpdater;

        public function I18nUpdater()
        {
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function initI18n(param1:String, param2:Uri, param3:Boolean = false, param4:Uri = null) : void
        {
            this._language = param1;
            this._overrideProvider = param4;
            super.init(param2, param3);
            return;
        }// end function

        override protected function checkFileVersion(param1:String, param2:String) : Boolean
        {
            return false;
        }// end function

        override public function clear() : void
        {
            I18nFileAccessor.getInstance().close();
            return;
        }// end function

        override protected function onLoaded(event:ResourceLoadedEvent) : void
        {
            var _loc_2:LangMetaData = null;
            var _loc_3:Uri = null;
            var _loc_4:uint = 0;
            var _loc_5:String = null;
            switch(event.uri.fileType)
            {
                case "d2i":
                {
                    I18nFileAccessor.getInstance().init(event.uri);
                    if (this._overrideProvider)
                    {
                        I18nFileAccessor.getInstance().addOverrideFile(this._overrideProvider);
                    }
                    _versions[event.uri.tag.file] = event.uri.tag.version;
                    StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_FILES_INFO, _storeKey, _versions);
                    dispatchEvent(new LangFileEvent(LangFileEvent.COMPLETE, false, false, event.uri.tag.file));
                    _dataFilesLoaded = true;
                    var _loc_7:* = _loadedFileCount + 1;
                    _loadedFileCount = _loc_7;
                    break;
                }
                case "meta":
                {
                    _loc_2 = LangMetaData.fromXml(event.resource, event.uri.uri, this.checkFileVersion);
                    _loc_4 = 0;
                    for (_loc_5 in _loc_2.clearFile)
                    {
                        
                        if (_loc_5.indexOf("_" + this._language) == -1)
                        {
                            continue;
                        }
                        _loc_3 = new Uri(FileUtils.getFilePath(event.uri.path) + "/" + _loc_5);
                        _loc_3.tag = {version:_loc_2.clearFile[_loc_5], file:FileUtils.getFileStartName(event.uri.uri) + "." + _loc_5};
                        _files.push(_loc_3);
                        _loc_4 = _loc_4 + 1;
                    }
                    if (_loc_4)
                    {
                        _loader.load(_files);
                    }
                    else
                    {
                        dispatchEvent(new Event(Event.COMPLETE));
                    }
                    break;
                }
                default:
                {
                    super.onLoaded(event);
                    break;
                    break;
                }
            }
            return;
        }// end function

        public static function getInstance() : I18nUpdater
        {
            if (!_self)
            {
                _self = new I18nUpdater;
            }
            return _self;
        }// end function

    }
}
