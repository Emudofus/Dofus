package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.game.common.managers.DofusShopManager;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.OpenWebServiceAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.KrosmasterTokenRequestAction;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterAuthTokenRequestMessage;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterAuthTokenErrorMessage;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterAuthTokenMessage;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.KrosmasterInventoryRequestAction;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterInventoryRequestMessage;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterInventoryErrorMessage;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterInventoryMessage;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.KrosmasterTransferRequestAction;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterTransferRequestMessage;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterTransferMessage;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.KrosmasterPlayingStatusAction;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterPlayingStatusMessage;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopArticlesListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopBuyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopSearchRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.GetComicRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.GetComicsLibraryRequestAction;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.logic.game.common.managers.ComicsManager;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopAuthentificationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopFrontPageRequestAction;
   
   public class ExternalGameFrame extends Object implements Frame
   {
      
      public function ExternalGameFrame() {
         super();
      }
      
      protected static const _log:Logger;
      
      private var _dofusShopManager:DofusShopManager;
      
      private var _openingShop:Boolean = false;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var owsa:OpenWebServiceAction = null;
         var ktora:KrosmasterTokenRequestAction = null;
         var katrmsg:KrosmasterAuthTokenRequestMessage = null;
         var katemsg:KrosmasterAuthTokenErrorMessage = null;
         var katmsg:KrosmasterAuthTokenMessage = null;
         var kira:KrosmasterInventoryRequestAction = null;
         var kirmsg:KrosmasterInventoryRequestMessage = null;
         var kiemsg:KrosmasterInventoryErrorMessage = null;
         var kimsg:KrosmasterInventoryMessage = null;
         var ktra:KrosmasterTransferRequestAction = null;
         var ktrmsg:KrosmasterTransferRequestMessage = null;
         var ktmsg:KrosmasterTransferMessage = null;
         var kpsa:KrosmasterPlayingStatusAction = null;
         var kpsmsg:KrosmasterPlayingStatusMessage = null;
         var salra:ShopArticlesListRequestAction = null;
         var sbra:ShopBuyRequestAction = null;
         var ssra:ShopSearchRequestAction = null;
         var gcra:GetComicRequestAction = null;
         var gclra:GetComicsLibraryRequestAction = null;
         var commonMod:Object = null;
         switch(true)
         {
            case msg is OpenWebServiceAction:
               owsa = msg as OpenWebServiceAction;
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.OpenWebService,owsa.uiName,owsa.uiParams);
               return true;
            case msg is KrosmasterTokenRequestAction:
               ktora = msg as KrosmasterTokenRequestAction;
               katrmsg = new KrosmasterAuthTokenRequestMessage();
               katrmsg.initKrosmasterAuthTokenRequestMessage();
               ConnectionsHandler.getConnection().send(katrmsg);
               return true;
            case msg is KrosmasterAuthTokenErrorMessage:
               katemsg = msg as KrosmasterAuthTokenErrorMessage;
               if(this._openingShop)
               {
                  KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError,DofusShopEnum.ERROR_AUTHENTICATION_FAILED);
                  this._openingShop = false;
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterAuthTokenError,katemsg.reason);
               }
               return true;
            case msg is KrosmasterAuthTokenMessage:
               katmsg = msg as KrosmasterAuthTokenMessage;
               if(this._openingShop)
               {
                  this._dofusShopManager = DofusShopManager.getInstance();
                  this._dofusShopManager.init(katmsg.token);
                  this._openingShop = false;
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterAuthToken,katmsg.token);
               }
               return true;
            case msg is KrosmasterInventoryRequestAction:
               kira = msg as KrosmasterInventoryRequestAction;
               kirmsg = new KrosmasterInventoryRequestMessage();
               kirmsg.initKrosmasterInventoryRequestMessage();
               ConnectionsHandler.getConnection().send(kirmsg);
               return true;
            case msg is KrosmasterInventoryErrorMessage:
               kiemsg = msg as KrosmasterInventoryErrorMessage;
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterInventoryError,kiemsg.reason);
               return true;
            case msg is KrosmasterInventoryMessage:
               kimsg = msg as KrosmasterInventoryMessage;
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterInventory,kimsg.figures);
               return true;
            case msg is KrosmasterTransferRequestAction:
               ktra = msg as KrosmasterTransferRequestAction;
               ktrmsg = new KrosmasterTransferRequestMessage();
               ktrmsg.initKrosmasterTransferRequestMessage(ktra.figureId);
               ConnectionsHandler.getConnection().send(ktrmsg);
               return true;
            case msg is KrosmasterTransferMessage:
               ktmsg = msg as KrosmasterTransferMessage;
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterTransfer,ktmsg.uid,ktmsg.failure);
               return true;
            case msg is KrosmasterPlayingStatusAction:
               kpsa = msg as KrosmasterPlayingStatusAction;
               kpsmsg = new KrosmasterPlayingStatusMessage();
               kpsmsg.initKrosmasterPlayingStatusMessage(kpsa.playing);
               ConnectionsHandler.getConnection().send(kpsmsg);
               return true;
            case msg is ShopAuthentificationRequestAction:
               this._openingShop = true;
               if(BuildInfos.BUILD_TYPE > BuildTypeEnum.BETA)
               {
                  commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                  commonMod.openInputPopup("ICE Authentication","Please enter your ICE Token",this.onTokenInput,this.onCancel);
               }
               else
               {
                  katrmsg = new KrosmasterAuthTokenRequestMessage();
                  katrmsg.initKrosmasterAuthTokenRequestMessage();
                  ConnectionsHandler.getConnection().send(katrmsg);
               }
               return true;
            case msg is ShopArticlesListRequestAction:
               salra = msg as ShopArticlesListRequestAction;
               this._dofusShopManager.getArticlesList(salra.categoryId,salra.pageId);
               return true;
            case msg is ShopBuyRequestAction:
               sbra = msg as ShopBuyRequestAction;
               this._dofusShopManager.buyArticle(sbra.articleId,sbra.quantity);
               return true;
            case msg is ShopFrontPageRequestAction:
               this._dofusShopManager.getHome();
               return true;
            case msg is ShopSearchRequestAction:
               ssra = msg as ShopSearchRequestAction;
               this._dofusShopManager.searchForArticles(ssra.text,ssra.pageId);
               return true;
            case msg is GetComicRequestAction:
               gcra = msg as GetComicRequestAction;
               ComicsManager.getInstance().getComic(gcra.remoteId,gcra.language,gcra.previewOnly);
               return true;
            case msg is GetComicsLibraryRequestAction:
               gclra = msg as GetComicsLibraryRequestAction;
               ComicsManager.getInstance().getLibrary(gclra.accountId);
               return true;
            default:
               return false;
         }
      }
      
      private function onTokenInput(value:String) : void {
         this._openingShop = false;
         this._dofusShopManager = DofusShopManager.getInstance();
         this._dofusShopManager.init(value,true);
      }
      
      private function onCancel() : void {
         var katrmsg:KrosmasterAuthTokenRequestMessage = new KrosmasterAuthTokenRequestMessage();
         katrmsg.initKrosmasterAuthTokenRequestMessage();
         ConnectionsHandler.getConnection().send(katrmsg);
      }
   }
}
