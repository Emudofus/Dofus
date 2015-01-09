package com.ankamagames.dofus.logic.game.common.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import com.ankamagames.jerakine.managers.LangManager;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.dofus.misc.utils.RpcServiceCenter;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.types.event.UiUnloadEvent;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
    import com.ankamagames.dofus.logic.game.common.types.DofusShopObject;
    import com.ankamagames.dofus.types.enums.DofusShopEnum;
    import com.ankamagames.dofus.logic.game.common.types.DofusShopArticle;
    import com.ankamagames.dofus.logic.game.common.types.DofusShopCategory;
    import com.ankamagames.dofus.logic.game.common.types.DofusShopHighlight;
    import flash.events.IOErrorEvent;
    import flash.events.ErrorEvent;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;

    public class DofusShopManager 
    {

        private static const _log:Logger = Log.getLogger("DofusShopManager");
        private static const LOCAL_GAME_SERVICE_URL:String = "http://api.ankama.lan/game/";
        private static const RELEASE_GAME_SERVICE_URL:String = "http://api.ankama.com/game/";
        private static const SHOP_KEY:String = "DOFUS_INGAME";
        private static var _self:DofusShopManager;

        private var _serviceBaseUrl:String;
        private var _serviceType:String;
        private var _serviceVersion:String;
        private var _currentLocale:String;
        private var _currentPurchaseId:int;
        private var _cacheHome:Object;
        private var _cacheArticles:Array;
        private var _objectPool:Array;
        private var _lastCategory:int;
        private var _lastPage:int;
        private var _isOnHomePage:Boolean;


        public static function getInstance():DofusShopManager
        {
            if (!(_self))
            {
                _self = new (DofusShopManager)();
            };
            return (_self);
        }


        public function init(key:String, forceReleaseGameService:Boolean=false):void
        {
            this._serviceType = "json";
            this._serviceVersion = "1.0";
            this._currentLocale = LangManager.getInstance().getEntry("config.lang.current");
            this._objectPool = new Array();
            if ((((BuildInfos.BUILD_TYPE >= BuildTypeEnum.TESTING)) && (!(forceReleaseGameService))))
            {
                this._serviceBaseUrl = LOCAL_GAME_SERVICE_URL;
            }
            else
            {
                this._serviceBaseUrl = RELEASE_GAME_SERVICE_URL;
            };
            RpcServiceCenter.getInstance().makeRpcCall(((this._serviceBaseUrl + "authentification.") + this._serviceType), this._serviceType, this._serviceVersion, "Authentification", [key, PlayerManager.getInstance().server.id, PlayedCharacterManager.getInstance().id], this.onAuthentification);
            this.open();
        }

        public function open():void
        {
            Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE, this.onClose);
            this._cacheArticles = [];
        }

        public function getMoney():void
        {
            RpcServiceCenter.getInstance().makeRpcCall(((this._serviceBaseUrl + "account.") + this._serviceType), this._serviceType, this._serviceVersion, "Money", [], this.onMoney);
        }

        public function getHome():void
        {
            this._isOnHomePage = true;
            if (this._cacheHome)
            {
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopHome, this._cacheHome.categories, this._cacheHome.gondolaArticles, this._cacheHome.gondolaHeads, this._cacheHome.highlightCarousel, this._cacheHome.highlightImages);
                return;
            };
            RpcServiceCenter.getInstance().makeRpcCall(((this._serviceBaseUrl + "shop.") + this._serviceType), this._serviceType, this._serviceVersion, "Home", [SHOP_KEY, this._currentLocale], this.onHome);
        }

        public function buyArticle(articleId:int, quantity:int=1):void
        {
            this._currentPurchaseId = articleId;
            RpcServiceCenter.getInstance().makeRpcCall(((this._serviceBaseUrl + "shop.") + this._serviceType), this._serviceType, this._serviceVersion, "QuickBuy", [SHOP_KEY, this._currentLocale, articleId, quantity], this.onBuyArticle, true, false);
        }

        public function getArticlesList(category:int, page:int=1, size:int=12):void
        {
            this._isOnHomePage = false;
            this._lastCategory = category;
            this._lastPage = page;
            if (!(this._cacheArticles[category]))
            {
                this._cacheArticles[category] = new Array();
            };
            if (this._cacheArticles[category][page])
            {
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopArticlesList, this._cacheArticles[category][page].articles, this._cacheArticles[category][page].totalPages);
                this.checkPreviousAndNextArticlePages(category, page, this._cacheArticles[category][page].totalPages);
                return;
            };
            RpcServiceCenter.getInstance().makeRpcCall(((this._serviceBaseUrl + "shop.") + this._serviceType), this._serviceType, this._serviceVersion, "ArticlesList", [SHOP_KEY, this._currentLocale, category, page, size], this.onArticlesList, false);
        }

        public function searchForArticles(criteria:String, page:int=1, size:int=12):void
        {
            this._isOnHomePage = false;
            RpcServiceCenter.getInstance().makeRpcCall(((this._serviceBaseUrl + "shop.") + this._serviceType), this._serviceType, this._serviceVersion, "ArticlesSearch", [SHOP_KEY, this._currentLocale, criteria, [], page, size], this.onSearchArticles);
        }

        public function updateAfterExpiredArticle(articleId:int):void
        {
            var l:int;
            var list:Array;
            var data:DofusShopObject;
            var i:int;
            var category:int;
            var page:int;
            var categoriesToPurge:Array;
            var categoryKey:String;
            var needUpdate:Boolean;
            var pageKey:String;
            var pageObj:Object;
            if (((this._cacheHome) && (this._cacheHome.gondolaArticles)))
            {
                l = this._cacheHome.gondolaArticles.length;
                i = 0;
                while (i < l)
                {
                    if (this._cacheHome.gondolaArticles[i].id == articleId)
                    {
                        this._cacheHome.gondolaArticles.splice(i, 1);
                        if (this._isOnHomePage)
                        {
                            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopHome, this._cacheHome.categories, this._cacheHome.gondolaArticles, this._cacheHome.gondolaHeads, this._cacheHome.highlightCarousel, this._cacheHome.highlightImages);
                        };
                        break;
                    };
                    i++;
                };
            };
            if (this._cacheArticles)
            {
                categoriesToPurge = new Array();
                for (categoryKey in this._cacheArticles)
                {
                    category = parseInt(categoryKey);
                    for (pageKey in this._cacheArticles[category])
                    {
                        page = parseInt(pageKey);
                        if (categoriesToPurge.indexOf(category) != -1)
                        {
                            break;
                        };
                        if (!(this._cacheArticles[category][page].articles))
                        {
                        }
                        else
                        {
                            l = this._cacheArticles[category][page].articles.length;
                            i = 0;
                            while (i < l)
                            {
                                if (this._cacheArticles[category][page].articles[i].id == articleId)
                                {
                                    categoriesToPurge.push(category);
                                    break;
                                };
                                i++;
                            };
                        };
                    };
                };
                needUpdate = false;
                for each (category in categoriesToPurge)
                {
                    if (category == this._lastCategory)
                    {
                        needUpdate = true;
                    };
                    for each (pageObj in this._cacheArticles[category])
                    {
                        for each (data in pageObj.articles)
                        {
                            data.free();
                        };
                    };
                    delete this._cacheArticles[category];
                };
                if (((!(this._isOnHomePage)) && (needUpdate)))
                {
                    this.getArticlesList(this._lastCategory, this._lastPage);
                };
            };
        }

        private function onAuthentification(success:Boolean, params:*, request:*):void
        {
            _log.debug(("onAuthentification - " + success));
            if (success)
            {
                this.getMoney();
                this.getHome();
            }
            else
            {
                _log.error(params);
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError, DofusShopEnum.ERROR_AUTHENTICATION_FAILED);
            };
        }

        private function onMoney(success:Boolean, params:*, request:*):void
        {
            _log.debug(("onMoney - " + success));
            if (success)
            {
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopMoney, params.ogrins, params.krozs);
            }
            else
            {
                this.processCallError(params);
            };
        }

        private function onHome(success:Boolean, params:*, request:*):void
        {
            var data:Object;
            var article:DofusShopArticle;
            _log.debug(("onHome - " + success));
            if (success)
            {
                if (!(params.content))
                {
                    this.processCallError("Error: Home requested data corrupted");
                    return;
                };
                this._cacheHome = {
                    "categories":[],
                    "gondolaHead":[],
                    "gondolaArticles":[],
                    "highlightCarousel":[],
                    "highlightImages":[]
                };
                if (params.content.categories)
                {
                    for each (data in params.content.categories.categories)
                    {
                        this._cacheHome.categories.push(new DofusShopCategory(data));
                    };
                };
                if (params.content.gondolahead_article)
                {
                    for each (data in params.content.gondolahead_article.articles)
                    {
                        article = new DofusShopArticle(data);
                        if (!(article.hasExpired))
                        {
                            this._cacheHome.gondolaArticles.push(article);
                        };
                    };
                };
                if (params.content.hightlight_carousel)
                {
                    for each (data in params.content.hightlight_carousel.hightlights)
                    {
                        this._cacheHome.highlightCarousel.push(new DofusShopHighlight(data));
                    };
                };
                if (params.content.hightlight_image)
                {
                    for each (data in params.content.hightlight_image.hightlights)
                    {
                        this._cacheHome.highlightImages.push(new DofusShopHighlight(data));
                    };
                };
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopHome, this._cacheHome.categories, this._cacheHome.gondolaArticles, this._cacheHome.gondolaHeads, this._cacheHome.highlightCarousel, this._cacheHome.highlightImages);
            }
            else
            {
                this.processCallError(params);
            };
        }

        private function onArticlesList(success:Boolean, params:*, request:*):void
        {
            var articles:Array;
            var totalPages:int;
            var articleData:Object;
            var article:DofusShopArticle;
            if (!(this._cacheArticles))
            {
                return;
            };
            _log.debug(("onArticlesList - " + success));
            if (success)
            {
                articles = new Array();
                totalPages = Math.ceil((params.count / DofusShopEnum.MAX_ARTICLES_PER_PAGE));
                for each (articleData in params.articles)
                {
                    article = new DofusShopArticle(articleData);
                    if (!(article.hasExpired))
                    {
                        articles.push(article);
                    };
                };
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopArticlesList, articles, totalPages);
                this._cacheArticles[request.params[2]][request.params[3]] = {
                    "articles":articles,
                    "totalPages":totalPages
                };
                this.checkPreviousAndNextArticlePages(request.params[2], request.params[3], totalPages);
            }
            else
            {
                this.processCallError(params);
            };
        }

        private function onPreloadArticlesList(success:Boolean, params:*, request:*):void
        {
            var articles:Array;
            var totalPages:int;
            var articleData:Object;
            var article:DofusShopArticle;
            if (!(this._cacheArticles))
            {
                return;
            };
            _log.debug(("onPreloadArticlesList - " + success));
            if (success)
            {
                if (!(this._cacheArticles))
                {
                    return;
                };
                articles = new Array();
                totalPages = Math.ceil((params.count / DofusShopEnum.MAX_ARTICLES_PER_PAGE));
                for each (articleData in params.articles)
                {
                    article = new DofusShopArticle(articleData);
                    if (!(article.hasExpired))
                    {
                        articles.push(article);
                    };
                };
                this._cacheArticles[request.params[2]][request.params[3]] = {
                    "articles":articles,
                    "totalPages":totalPages
                };
            };
        }

        private function onSearchArticles(success:Boolean, params:*, request:*):void
        {
            var articles:Array;
            var totalPages:int;
            var articleData:Object;
            var article:DofusShopArticle;
            if (!(this._cacheArticles))
            {
                return;
            };
            _log.debug(("onSearchArticles - " + success));
            if (success)
            {
                articles = new Array();
                totalPages = Math.ceil((params.count / DofusShopEnum.MAX_ARTICLES_PER_PAGE));
                for each (articleData in params.articles)
                {
                    article = new DofusShopArticle(articleData);
                    if (!(article.hasExpired))
                    {
                        articles.push(article);
                    };
                };
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopArticlesList, articles, totalPages);
            }
            else
            {
                this.processCallError(params);
            };
        }

        private function onBuyArticle(success:Boolean, params:*, request:*):void
        {
            _log.debug(("onBuyArticle - " + success));
            if (success)
            {
                if (params.result)
                {
                    KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopSuccessfulPurchase, this._currentPurchaseId);
                    KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopMoney, params.ogrins, params.krozs);
                }
                else
                {
                    KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError, params.error);
                };
            }
            else
            {
                if ((((params is ErrorEvent)) && ((params.type == IOErrorEvent.NETWORK_ERROR))))
                {
                    KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError, DofusShopEnum.ERROR_PURCHASE_REQUEST_TIMED_OUT);
                }
                else
                {
                    this.processCallError(params);
                };
            };
            this._currentPurchaseId = 0;
        }

        private function onClose(event:UiUnloadEvent):void
        {
            var list:Array;
            var data:DofusShopObject;
            var page:Object;
            if ((((event.name == "webBase")) && (this._cacheHome)))
            {
                Berilia.getInstance().removeEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE, this.onClose);
                for each (list in this._cacheHome)
                {
                    for each (data in list)
                    {
                        data.free();
                    };
                    list = null;
                };
                this._cacheHome = null;
                for each (list in this._cacheArticles)
                {
                    for each (page in list)
                    {
                        for each (data in page.articles)
                        {
                            data.free();
                        };
                        page = null;
                    };
                    list = null;
                };
                this._cacheArticles = null;
            };
        }

        private function checkPreviousAndNextArticlePages(category:int, page:int, totalPages:int):void
        {
            if ((((page > 1)) && (!(this._cacheArticles[category][(page - 1)]))))
            {
                RpcServiceCenter.getInstance().makeRpcCall(((this._serviceBaseUrl + "shop.") + this._serviceType), this._serviceType, this._serviceVersion, "ArticlesList", [SHOP_KEY, this._currentLocale, category, (page - 1), DofusShopEnum.MAX_ARTICLES_PER_PAGE], this.onPreloadArticlesList);
            };
            if ((((page < totalPages)) && (!(this._cacheArticles[category][(page + 1)]))))
            {
                RpcServiceCenter.getInstance().makeRpcCall(((this._serviceBaseUrl + "shop.") + this._serviceType), this._serviceType, this._serviceVersion, "ArticlesList", [SHOP_KEY, this._currentLocale, category, (page + 1), DofusShopEnum.MAX_ARTICLES_PER_PAGE], this.onPreloadArticlesList);
            };
        }

        private function processCallError(error:*):void
        {
            _log.error(error);
            if ((((error is ErrorEvent)) && ((error.type == IOErrorEvent.NETWORK_ERROR))))
            {
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError, DofusShopEnum.ERROR_REQUEST_TIMED_OUT);
            }
            else
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, "Une erreur est survenue dans le chargement de certaines données dans la boutique, veuillez réessayer. #TED", ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.common.managers

