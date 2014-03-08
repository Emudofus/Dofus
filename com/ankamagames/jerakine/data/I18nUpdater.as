package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.types.LangMetaData;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.JerakineConstants;
   import com.ankamagames.jerakine.types.events.LangFileEvent;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class I18nUpdater extends DataUpdateManager
   {
      
      public function I18nUpdater() {
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
      
      private static var _self:I18nUpdater;
      
      public static function getInstance() : I18nUpdater {
         if(!_self)
         {
            _self = new I18nUpdater();
         }
         return _self;
      }
      
      private var _language:String;
      
      private var _overrideProvider:Uri;
      
      public function initI18n(param1:String, param2:Uri, param3:Boolean=false, param4:Uri=null) : void {
         this._language = param1;
         this._overrideProvider = param4;
         super.init(param2,param3);
      }
      
      override protected function checkFileVersion(param1:String, param2:String) : Boolean {
         return false;
      }
      
      override public function clear() : void {
         I18nFileAccessor.getInstance().close();
      }
      
      override protected function onLoaded(param1:ResourceLoadedEvent) : void {
         var _loc2_:LangMetaData = null;
         var _loc3_:Uri = null;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         switch(param1.uri.fileType)
         {
            case "d2i":
               I18nFileAccessor.getInstance().init(param1.uri);
               if(this._overrideProvider)
               {
                  I18nFileAccessor.getInstance().addOverrideFile(this._overrideProvider);
               }
               _versions[param1.uri.tag.file] = param1.uri.tag.version;
               StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_FILES_INFO,_storeKey,_versions);
               dispatchEvent(new LangFileEvent(LangFileEvent.COMPLETE,false,false,param1.uri.tag.file));
               _dataFilesLoaded = true;
               _loadedFileCount++;
               break;
            case "meta":
               _loc2_ = LangMetaData.fromXml(param1.resource,param1.uri.uri,this.checkFileVersion);
               _loc4_ = 0;
               for (_loc5_ in _loc2_.clearFile)
               {
                  if(_loc5_.indexOf("_" + this._language) != -1)
                  {
                     _loc3_ = new Uri(FileUtils.getFilePath(param1.uri.path) + "/" + _loc5_);
                     _loc3_.tag = 
                        {
                           "version":_loc2_.clearFile[_loc5_],
                           "file":FileUtils.getFileStartName(param1.uri.uri) + "." + _loc5_
                        };
                     _files.push(_loc3_);
                     _loc4_++;
                  }
               }
               if(_loc4_)
               {
                  _loader.load(_files);
               }
               else
               {
                  dispatchEvent(new Event(Event.COMPLETE));
               }
               break;
            default:
               super.onLoaded(param1);
         }
      }
   }
}
