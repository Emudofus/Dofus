package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Timer;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.OpenWebServiceAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.KrosmasterTokenRequestAction;
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
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.logic.game.common.managers.DofusShopManager;
   import com.ankamagames.dofus.logic.game.common.managers.ComicsManager;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopAuthentificationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopFrontPageRequestAction;
   import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterAuthTokenRequestMessage;
   import flash.events.TimerEvent;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   
   public class ExternalGameFrame extends Object implements Frame
   {
      
      public function ExternalGameFrame()
      {
         this._tokenRequestCallback = [];
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalGameFrame));
      
      private var _tokenRequestCallback:Array;
      
      private var _tokenRequestTimeoutTimer:Timer;
      
      private var _tokenRequestHasTimedOut:Boolean = false;
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function pulled() : Boolean
      {
         this.clearTokenRequestTimer();
         this._tokenRequestCallback.length = 0;
         return true;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:OpenWebServiceAction = null;
         var _loc3_:KrosmasterTokenRequestAction = null;
         var _loc4_:KrosmasterAuthTokenErrorMessage = null;
         var _loc5_:KrosmasterAuthTokenMessage = null;
         var _loc6_:KrosmasterInventoryRequestAction = null;
         var _loc7_:KrosmasterInventoryRequestMessage = null;
         var _loc8_:KrosmasterInventoryErrorMessage = null;
         var _loc9_:KrosmasterInventoryMessage = null;
         var _loc10_:KrosmasterTransferRequestAction = null;
         var _loc11_:KrosmasterTransferRequestMessage = null;
         var _loc12_:KrosmasterTransferMessage = null;
         var _loc13_:KrosmasterPlayingStatusAction = null;
         var _loc14_:KrosmasterPlayingStatusMessage = null;
         var _loc15_:ShopArticlesListRequestAction = null;
         var _loc16_:ShopBuyRequestAction = null;
         var _loc17_:ShopSearchRequestAction = null;
         var _loc18_:GetComicRequestAction = null;
         var _loc19_:GetComicsLibraryRequestAction = null;
         var _loc20_:Object = null;
         switch(true)
         {
            case param1 is OpenWebServiceAction:
               _loc2_ = param1 as OpenWebServiceAction;
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.OpenWebService,_loc2_.uiName,_loc2_.uiParams);
               return true;
            case param1 is KrosmasterTokenRequestAction:
               _loc3_ = param1 as KrosmasterTokenRequestAction;
               this.getIceToken();
               return true;
            case param1 is KrosmasterAuthTokenErrorMessage:
               if(this._tokenRequestHasTimedOut)
               {
                  return true;
               }
               _loc4_ = param1 as KrosmasterAuthTokenErrorMessage;
               if(this._tokenRequestCallback.length)
               {
                  this.clearTokenRequestTimer();
                  this.callOnTokenFunctions("");
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterAuthTokenError,_loc4_.reason);
               }
               return true;
            case param1 is KrosmasterAuthTokenMessage:
               if(this._tokenRequestHasTimedOut)
               {
                  return true;
               }
               _loc5_ = param1 as KrosmasterAuthTokenMessage;
               if(this._tokenRequestCallback.length)
               {
                  this.clearTokenRequestTimer();
                  this.callOnTokenFunctions(_loc5_.token);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterAuthToken,_loc5_.token);
               }
               return true;
            case param1 is KrosmasterInventoryRequestAction:
               _loc6_ = param1 as KrosmasterInventoryRequestAction;
               _loc7_ = new KrosmasterInventoryRequestMessage();
               _loc7_.initKrosmasterInventoryRequestMessage();
               ConnectionsHandler.getConnection().send(_loc7_);
               return true;
            case param1 is KrosmasterInventoryErrorMessage:
               _loc8_ = param1 as KrosmasterInventoryErrorMessage;
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterInventoryError,_loc8_.reason);
               return true;
            case param1 is KrosmasterInventoryMessage:
               _loc9_ = param1 as KrosmasterInventoryMessage;
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterInventory,_loc9_.figures);
               return true;
            case param1 is KrosmasterTransferRequestAction:
               _loc10_ = param1 as KrosmasterTransferRequestAction;
               _loc11_ = new KrosmasterTransferRequestMessage();
               _loc11_.initKrosmasterTransferRequestMessage(_loc10_.figureId);
               ConnectionsHandler.getConnection().send(_loc11_);
               return true;
            case param1 is KrosmasterTransferMessage:
               _loc12_ = param1 as KrosmasterTransferMessage;
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterTransfer,_loc12_.uid,_loc12_.failure);
               return true;
            case param1 is KrosmasterPlayingStatusAction:
               _loc13_ = param1 as KrosmasterPlayingStatusAction;
               _loc14_ = new KrosmasterPlayingStatusMessage();
               _loc14_.initKrosmasterPlayingStatusMessage(_loc13_.playing);
               ConnectionsHandler.getConnection().send(_loc14_);
               return true;
            case param1 is ShopAuthentificationRequestAction:
               if(BuildInfos.BUILD_TYPE > BuildTypeEnum.BETA)
               {
                  _loc20_ = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                  _loc20_.openInputPopup("ICE Authentication","To access the Release shop, please enter a valid ICE Token.\nClose this message to access the Local shop.",this.onTokenInput,this.onCancel);
               }
               else
               {
                  this.getIceToken(this.openShop);
               }
               return true;
            case param1 is ShopArticlesListRequestAction:
               _loc15_ = param1 as ShopArticlesListRequestAction;
               DofusShopManager.getInstance().getArticlesList(_loc15_.categoryId,_loc15_.pageId);
               return true;
            case param1 is ShopBuyRequestAction:
               _loc16_ = param1 as ShopBuyRequestAction;
               DofusShopManager.getInstance().buyArticle(_loc16_.articleId,_loc16_.quantity);
               return true;
            case param1 is ShopFrontPageRequestAction:
               DofusShopManager.getInstance().getHome();
               return true;
            case param1 is ShopSearchRequestAction:
               _loc17_ = param1 as ShopSearchRequestAction;
               DofusShopManager.getInstance().searchForArticles(_loc17_.text,_loc17_.pageId);
               return true;
            case param1 is GetComicRequestAction:
               _loc18_ = param1 as GetComicRequestAction;
               ComicsManager.getInstance().getComic(_loc18_.remoteId,_loc18_.language,_loc18_.previewOnly);
               return true;
            case param1 is GetComicsLibraryRequestAction:
               _loc19_ = param1 as GetComicsLibraryRequestAction;
               ComicsManager.getInstance().getLibrary(_loc19_.accountId);
               return true;
            default:
               return false;
         }
      }
      
      public function getIceToken(param1:Function = null) : void
      {
         this._tokenRequestHasTimedOut = false;
         if(param1 != null)
         {
            this._tokenRequestCallback.push(param1);
         }
         var _loc2_:KrosmasterAuthTokenRequestMessage = new KrosmasterAuthTokenRequestMessage();
         _loc2_.initKrosmasterAuthTokenRequestMessage();
         ConnectionsHandler.getConnection().send(_loc2_);
         this._tokenRequestTimeoutTimer = new Timer(10000,1);
         this._tokenRequestTimeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTokenRequestTimeout);
         this._tokenRequestTimeoutTimer.start();
      }
      
      private function openShop(param1:String) : void
      {
         if(!param1)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError,DofusShopEnum.ERROR_AUTHENTICATION_FAILED);
            return;
         }
         DofusShopManager.getInstance().init(param1);
      }
      
      private function onTokenRequestTimeout(param1:TimerEvent) : void
      {
         this._tokenRequestHasTimedOut = true;
         this.clearTokenRequestTimer();
         this.callOnTokenFunctions("");
      }
      
      private function callOnTokenFunctions(param1:String) : void
      {
         var _loc2_:Function = null;
         if(this._tokenRequestCallback.length)
         {
            for each(_loc2_ in this._tokenRequestCallback)
            {
               _loc2_(param1);
            }
            this._tokenRequestCallback.length = 0;
         }
      }
      
      private function clearTokenRequestTimer() : void
      {
         if(this._tokenRequestTimeoutTimer)
         {
            this._tokenRequestTimeoutTimer.stop();
            this._tokenRequestTimeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTokenRequestTimeout);
            this._tokenRequestTimeoutTimer = null;
         }
      }
      
      private function onTokenInput(param1:String) : void
      {
         DofusShopManager.getInstance().init(param1,true);
      }
      
      private function onCancel() : void
      {
         this.getIceToken(this.openShop);
      }
   }
}
