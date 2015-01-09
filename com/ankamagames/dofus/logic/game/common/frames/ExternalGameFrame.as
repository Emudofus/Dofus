package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.common.managers.DofusShopManager;
    import com.ankamagames.jerakine.types.enums.Priority;
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
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopAuthentificationRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopFrontPageRequestAction;
    import com.ankamagames.jerakine.messages.Message;

    public class ExternalGameFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalGameFrame));

        private var _dofusShopManager:DofusShopManager;
        private var _iceAuthToken:String;
        private var _openingShop:Boolean = false;


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
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:KrosmasterTokenRequestAction;
            var _local_3:KrosmasterAuthTokenRequestMessage;
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
            switch (true)
            {
                case (msg is KrosmasterTokenRequestAction):
                    _local_2 = (msg as KrosmasterTokenRequestAction);
                    _local_3 = new KrosmasterAuthTokenRequestMessage();
                    _local_3.initKrosmasterAuthTokenRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_3);
                    return (true);
                case (msg is KrosmasterAuthTokenErrorMessage):
                    _local_4 = (msg as KrosmasterAuthTokenErrorMessage);
                    KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterAuthTokenError, _local_4.reason);
                    return (true);
                case (msg is KrosmasterAuthTokenMessage):
                    _local_5 = (msg as KrosmasterAuthTokenMessage);
                    this._iceAuthToken = _local_5.token;
                    if (!(this._openingShop))
                    {
                        KernelEventsManager.getInstance().processCallback(ExternalGameHookList.KrosmasterAuthToken, _local_5.token);
                    }
                    else
                    {
                        this._dofusShopManager = DofusShopManager.getInstance();
                        this._dofusShopManager.init(this._iceAuthToken);
                    };
                    this._openingShop = false;
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
                    if (!(this._dofusShopManager))
                    {
                        if (!(this._iceAuthToken))
                        {
                            this._openingShop = true;
                            _local_3 = new KrosmasterAuthTokenRequestMessage();
                            _local_3.initKrosmasterAuthTokenRequestMessage();
                            ConnectionsHandler.getConnection().send(_local_3);
                        }
                        else
                        {
                            this._dofusShopManager = DofusShopManager.getInstance();
                            this._dofusShopManager.init(this._iceAuthToken);
                        };
                    }
                    else
                    {
                        this._dofusShopManager.open();
                        this._dofusShopManager.getMoney();
                        this._dofusShopManager.getHome();
                    };
                    return (true);
                case (msg is ShopArticlesListRequestAction):
                    _local_15 = (msg as ShopArticlesListRequestAction);
                    this._dofusShopManager.getArticlesList(_local_15.categoryId, _local_15.pageId);
                    return (true);
                case (msg is ShopBuyRequestAction):
                    _local_16 = (msg as ShopBuyRequestAction);
                    this._dofusShopManager.buyArticle(_local_16.articleId, _local_16.quantity);
                    return (true);
                case (msg is ShopFrontPageRequestAction):
                    this._dofusShopManager.getHome();
                    return (true);
                case (msg is ShopSearchRequestAction):
                    _local_17 = (msg as ShopSearchRequestAction);
                    this._dofusShopManager.searchForArticles(_local_17.text, _local_17.pageId);
                    return (true);
            };
            return (false);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

