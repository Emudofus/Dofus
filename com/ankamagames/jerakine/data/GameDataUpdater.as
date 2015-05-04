package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.JerakineConstants;
   import com.ankamagames.jerakine.types.events.LangFileEvent;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class GameDataUpdater extends DataUpdateManager
   {
      
      public function GameDataUpdater()
      {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            return;
         }
      }
      
      private static var _self:GameDataUpdater;
      
      public static function getInstance() : GameDataUpdater
      {
         if(!_self)
         {
            _self = new GameDataUpdater();
         }
         return _self;
      }
      
      override protected function checkFileVersion(param1:String, param2:String) : Boolean
      {
         return false;
      }
      
      override public function clear() : void
      {
         GameDataFileAccessor.getInstance().close();
      }
      
      override protected function onLoaded(param1:ResourceLoadedEvent) : void
      {
         switch(param1.uri.fileType)
         {
            case "d2o":
            case "d2os":
               GameDataFileAccessor.getInstance().init(param1.uri);
               _versions[param1.uri.tag.file] = param1.uri.tag.version;
               StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_FILES_INFO,_storeKey,_versions);
               dispatchEvent(new LangFileEvent(LangFileEvent.COMPLETE,false,false,param1.uri.tag.file));
               _dataFilesLoaded = true;
               _loadedFileCount++;
               break;
            default:
               super.onLoaded(param1);
         }
      }
   }
}
