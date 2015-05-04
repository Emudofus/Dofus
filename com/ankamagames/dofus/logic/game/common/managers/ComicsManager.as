package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.dofus.misc.utils.RpcServiceCenter;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   
   public class ComicsManager extends Object
   {
      
      public function ComicsManager()
      {
         super();
         if(BuildInfos.BUILD_TYPE >= BuildTypeEnum.TESTING)
         {
            this._apiUrl = LOCAL_COMICS_READER_API_URL;
         }
         else
         {
            this._apiUrl = RELEASE_COMICS_READER_API_URL;
         }
      }
      
      private static const _log:Logger = Log.getLogger("ComicsManager");
      
      private static const LOCAL_COMICS_READER_API_URL:String = "http://api.ankama.lan/wizcorp/public";
      
      private static const RELEASE_COMICS_READER_API_URL:String = "http://api.ankama.com/wizcorp/public";
      
      private static var _self:ComicsManager;
      
      public static function getInstance() : ComicsManager
      {
         if(!_self)
         {
            _self = new ComicsManager();
         }
         return _self;
      }
      
      private var _apiUrl:String;
      
      private const _serviceType:String = "json";
      
      private const _formatVersion:String = "1.1";
      
      public function getComic(param1:String, param2:String, param3:Boolean) : void
      {
         RpcServiceCenter.getInstance().makeRpcCall(this._apiUrl + "." + this._serviceType,this._serviceType,this._formatVersion,"GetComic",{
            "sComicId":param1,
            "sLanguage":param2
         },this.onComicLoaded,false);
      }
      
      public function getLibrary(param1:String) : void
      {
         RpcServiceCenter.getInstance().makeRpcCall(this._apiUrl + "." + this._serviceType,this._serviceType,this._formatVersion,"GetLibrary",{"iAccountId":param1},this.onComicsLibraryLoaded,false);
      }
      
      private function onComicLoaded(param1:Boolean, param2:*, param3:*) : void
      {
         if(param1)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.ComicLoaded,param2);
         }
      }
      
      private function onComicsLibraryLoaded(param1:Boolean, param2:*, param3:*) : void
      {
         if(param1)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.ComicsLibraryLoaded,param2);
         }
      }
   }
}
