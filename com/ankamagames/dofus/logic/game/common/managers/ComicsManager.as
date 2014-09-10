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
      
      public function ComicsManager() {
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
      
      private static const _log:Logger;
      
      private static const LOCAL_COMICS_READER_API_URL:String = "http://api.ankama.lan/game/comicreader";
      
      private static const RELEASE_COMICS_READER_API_URL:String = "http://api.ankama.com/game/comicreader";
      
      private static var _self:ComicsManager;
      
      public static function getInstance() : ComicsManager {
         if(!_self)
         {
            _self = new ComicsManager();
         }
         return _self;
      }
      
      private var _apiUrl:String;
      
      private const _serviceType:String = "json";
      
      private const _formatVersion:String = "2.0";
      
      public function getComic(pComicRemoteId:String, pLanguage:String, pPreviewOnly:Boolean) : void {
         RpcServiceCenter.getInstance().makeRpcCall(this._apiUrl + "." + this._serviceType,this._serviceType,this._formatVersion,"GetComic",
            {
               "sComicId":pComicRemoteId,
               "sLanguage":pLanguage
            },this.onComicLoaded,false);
      }
      
      public function getLibrary(pAccountId:String) : void {
         RpcServiceCenter.getInstance().makeRpcCall(this._apiUrl + "." + this._serviceType,this._serviceType,this._formatVersion,"GetLibrary",{"iAccountId":pAccountId},this.onComicsLibraryLoaded,false);
      }
      
      private function onComicLoaded(pSuccess:Boolean, pResult:*, pRequestData:*) : void {
         if(pSuccess)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.ComicLoaded,pResult);
         }
      }
      
      private function onComicsLibraryLoaded(pSuccess:Boolean, pComics:*, pRequestData:*) : void {
         if(pSuccess)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.ComicsLibraryLoaded,pComics);
         }
      }
   }
}
