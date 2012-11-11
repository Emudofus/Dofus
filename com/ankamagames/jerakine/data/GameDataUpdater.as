package com.ankamagames.jerakine.data
{
    import com.ankamagames.jerakine.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.utils.errors.*;

    public class GameDataUpdater extends DataUpdateManager
    {
        private static var _self:GameDataUpdater;

        public function GameDataUpdater()
        {
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        override protected function checkFileVersion(param1:String, param2:String) : Boolean
        {
            return false;
        }// end function

        override public function clear() : void
        {
            GameDataFileAccessor.getInstance().close();
            return;
        }// end function

        override protected function onLoaded(event:ResourceLoadedEvent) : void
        {
            switch(event.uri.fileType)
            {
                case "d2o":
                case "d2os":
                {
                    GameDataFileAccessor.getInstance().init(event.uri);
                    _versions[event.uri.tag.file] = event.uri.tag.version;
                    StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_FILES_INFO, _storeKey, _versions);
                    dispatchEvent(new LangFileEvent(LangFileEvent.COMPLETE, false, false, event.uri.tag.file));
                    _dataFilesLoaded = true;
                    var _loc_3:* = _loadedFileCount + 1;
                    _loadedFileCount = _loc_3;
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

        public static function getInstance() : GameDataUpdater
        {
            if (!_self)
            {
                _self = new GameDataUpdater;
            }
            return _self;
        }// end function

    }
}
