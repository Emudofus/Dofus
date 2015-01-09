package com.ankamagames.jerakine.data
{
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.jerakine.JerakineConstants;
    import com.ankamagames.jerakine.types.events.LangFileEvent;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;

    public class GameDataUpdater extends DataUpdateManager 
    {

        private static var _self:GameDataUpdater;

        public function GameDataUpdater()
        {
            if (_self)
            {
                throw (new SingletonError());
            };
        }

        public static function getInstance():GameDataUpdater
        {
            if (!(_self))
            {
                _self = new (GameDataUpdater)();
            };
            return (_self);
        }


        override protected function checkFileVersion(sFileName:String, sVersion:String):Boolean
        {
            return (false);
        }

        override public function clear():void
        {
            GameDataFileAccessor.getInstance().close();
        }

        override protected function onLoaded(e:ResourceLoadedEvent):void
        {
            switch (e.uri.fileType)
            {
                case "d2o":
                case "d2os":
                    GameDataFileAccessor.getInstance().init(e.uri);
                    _versions[e.uri.tag.file] = e.uri.tag.version;
                    StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_FILES_INFO, _storeKey, _versions);
                    dispatchEvent(new LangFileEvent(LangFileEvent.COMPLETE, false, false, e.uri.tag.file));
                    _dataFilesLoaded = true;
                    _loadedFileCount++;
                    return;
                default:
                    super.onLoaded(e);
            };
        }


    }
}//package com.ankamagames.jerakine.data

