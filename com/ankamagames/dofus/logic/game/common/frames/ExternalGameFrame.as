package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Timer;
    import com.ankamagames.jerakine.types.enums.Priority;
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
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopAuthentificationRequestAction;
    import com.ankamagames.dofus.logic.game.common.managers.DofusShopManager;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopFrontPageRequestAction;
    import com.ankamagames.dofus.logic.game.common.managers.ComicsManager;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.network.messages.web.krosmaster.KrosmasterAuthTokenRequestMessage;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.types.enums.DofusShopEnum;

    public class ExternalGameFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalGameFrame));

        private var _tokenRequestCallback:Array;
        private var _tokenRequestTimeoutTimer:Timer;
        private var _tokenRequestHasTimedOut:Boolean = false;

        public function ExternalGameFrame()
        {
            this._tokenRequestCallback = [];
            super();
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function pulled():Boolean
        {
            this.clearTokenRequestTimer();
            this._tokenRequestCallback.length = 0;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:OpenWebServiceAction;
            var _local_3:KrosmasterTokenRequestAction;
            var _local_4:KrosmasterAuthTokenErrorMessage;
            var _local_5:KrosmasterAuthTokenMessage;
            var _local_6:KrosmasterInventoryRequestAction;
            var _local_7:KrosmasterInventoryRequestMessage;
            var _local_8:KrosmasterInventoryErrorMessage;
            var _local_9:KrosmasterInventoryMessage;
            var _local_10:KrosmasterTransferRequestAction;
            var _local_11:KrosmasterTransferRequestMessage;
            var _local_12:KrosmasterTransferMessage;
            var _local_13:KrosmasterPlayingStatusAction;
            var _local_14:KrosmasterPlayingStatusMessage;
            var _local_15:ShopArticlesListRequestAction;
            var _local_16:ShopBuyRequestAction;
            var _local_17:ShopSearchRequestAction;
            var _local_18:GetComicRequestAction;
            var _local_19:GetComicsLibraryRequestAction;
            var commonMod:Object;
            switch (true)
            {
                case (msg is OpenWebServiceAction):
                    _local_2 = (msg as OpenWebServiceAction);
                    KernelEventsManager.getInstance().processCallback(ExternalGameHookList.OpenWebService, _local_2.uiName, _local_2.uiParams);
                    return (true);
                case (msg is KrosmasterTokenRequestAction):
                    _local_3 = (msg as KrosmasterTokenRequestAction);
                    this.getIceToken();
                    return (true);
                case (msg is KrosmasterAuthTokenErrorMessage):
                    if (this._tokenRequestHasTimedOut)
                    {
                        return (true);
                    };
                    _local_4 = (msg as KrosmasterAuthTokenErrorMessage);
                    if (this._tokenRequestCallback.length)
                    {
                        this.clearTokenRequestTimer();
                        this.callOnTokenFunctions("");
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterAuthTokenError, _local_4.reason);
                    };
                    return (true);
                case (msg is KrosmasterAuthTokenMessage):
                    if (this._tokenRequestHasTimedOut)
                    {
                        return (true);
                    };
                    _local_5 = (msg as KrosmasterAuthTokenMessage);
                    if (this._tokenRequestCallback.length)
                    {
                        this.clearTokenRequestTimer();
                        this.callOnTokenFunctions(_local_5.token);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterAuthToken, _local_5.token);
                    };
                    return (true);
                case (msg is KrosmasterInventoryRequestAction):
                    _local_6 = (msg as KrosmasterInventoryRequestAction);
                    _local_7 = new KrosmasterInventoryRequestMessage();
                    _local_7.initKrosmasterInventoryRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_7);
                    return (true);
                case (msg is KrosmasterInventoryErrorMessage):
                    _local_8 = (msg as KrosmasterInventoryErrorMessage);
                    KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterInventoryError, _local_8.reason);
                    return (true);
                case (msg is KrosmasterInventoryMessage):
                    _local_9 = (msg as KrosmasterInventoryMessage);
                    KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterInventory, _local_9.figures);
                    return (true);
                case (msg is KrosmasterTransferRequestAction):
                    _local_10 = (msg as KrosmasterTransferRequestAction);
                    _local_11 = new KrosmasterTransferRequestMessage();
                    _local_11.initKrosmasterTransferRequestMessage(_local_10.figureId);
                    ConnectionsHandler.getConnection().send(_local_11);
                    return (true);
                case (msg is KrosmasterTransferMessage):
                    _local_12 = (msg as KrosmasterTransferMessage);
                    KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterTransfer, _local_12.uid, _local_12.failure);
                    return (true);
                case (msg is KrosmasterPlayingStatusAction):
                    _local_13 = (msg as KrosmasterPlayingStatusAction);
                    _local_14 = new KrosmasterPlayingStatusMessage();
                    _local_14.initKrosmasterPlayingStatusMessage(_local_13.playing);
                    ConnectionsHandler.getConnection().send(_local_14);
                    return (true);
                case (msg is ShopAuthentificationRequestAction):
                    if (BuildInfos.BUILD_TYPE > BuildTypeEnum.BETA)
                    {
                        commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                        commonMod.openInputPopup("ICE Authentication", "Please enter your ICE Token", this.onTokenInput, this.onCancel);
                    }
                    else
                    {
                        this.getIceToken(this.openShop);
                    };
                    return (true);
                case (msg is ShopArticlesListRequestAction):
                    _local_15 = (msg as ShopArticlesListRequestAction);
                    DofusShopManager.getInstance().getArticlesList(_local_15.categoryId, _local_15.pageId);
                    return (true);
                case (msg is ShopBuyRequestAction):
                    _local_16 = (msg as ShopBuyRequestAction);
                    DofusShopManager.getInstance().buyArticle(_local_16.articleId, _local_16.quantity);
                    return (true);
                case (msg is ShopFrontPageRequestAction):
                    DofusShopManager.getInstance().getHome();
                    return (true);
                case (msg is ShopSearchRequestAction):
                    _local_17 = (msg as ShopSearchRequestAction);
                    DofusShopManager.getInstance().searchForArticles(_local_17.text, _local_17.pageId);
                    return (true);
                case (msg is GetComicRequestAction):
                    _local_18 = (msg as GetComicRequestAction);
                    ComicsManager.getInstance().getComic(_local_18.remoteId, _local_18.language, _local_18.previewOnly);
                    return (true);
                case (msg is GetComicsLibraryRequestAction):
                    _local_19 = (msg as GetComicsLibraryRequestAction);
                    ComicsManager.getInstance().getLibrary(_local_19.accountId);
                    return (true);
            };
            return (false);
        }

        public function getIceToken(callback:Function=null):void
        {
            this._tokenRequestHasTimedOut = false;
            if (callback != null)
            {
                this._tokenRequestCallback.push(callback);
            };
            var katrmsg:KrosmasterAuthTokenRequestMessage = new KrosmasterAuthTokenRequestMessage();
            katrmsg.initKrosmasterAuthTokenRequestMessage();
            ConnectionsHandler.getConnection().send(katrmsg);
            this._tokenRequestTimeoutTimer = new Timer(10000, 1);
            this._tokenRequestTimeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTokenRequestTimeout);
            this._tokenRequestTimeoutTimer.start();
        }

        private function openShop(token:String):void
        {
            if (!(token))
            {
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError, DofusShopEnum.ERROR_AUTHENTICATION_FAILED);
                return;
            };
            DofusShopManager.getInstance().init(token);
        }

        private function onTokenRequestTimeout(event:TimerEvent):void
        {
            this._tokenRequestHasTimedOut = true;
            this.clearTokenRequestTimer();
            this.callOnTokenFunctions("");
        }

        private function callOnTokenFunctions(token:String):void
        {
            var fct:Function;
            if (this._tokenRequestCallback.length)
            {
                for each (fct in this._tokenRequestCallback)
                {
                    (fct(token));
                };
                this._tokenRequestCallback.length = 0;
            };
        }

        private function clearTokenRequestTimer():void
        {
            if (this._tokenRequestTimeoutTimer)
            {
                this._tokenRequestTimeoutTimer.stop();
                this._tokenRequestTimeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTokenRequestTimeout);
                this._tokenRequestTimeoutTimer = null;
            };
        }

        private function onTokenInput(value:String):void
        {
            DofusShopManager.getInstance().init(value, true);
        }

        private function onCancel():void
        {
            this.getIceToken(this.openShop);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

