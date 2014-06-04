package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.misc.utils.RpcServiceCenter;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.event.UiUnloadEvent;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.logic.game.common.types.DofusShopObject;
   import com.ankamagames.dofus.logic.game.common.types.DofusShopCategory;
   import com.ankamagames.dofus.logic.game.common.types.DofusShopArticle;
   import com.ankamagames.dofus.logic.game.common.types.DofusShopHighlight;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   import flash.events.ErrorEvent;
   import flash.events.IOErrorEvent;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   
   public class DofusShopManager extends Object
   {
      
      public function DofusShopManager() {
         super();
      }
      
      private static const _log:Logger;
      
      private static const LOCAL_GAME_SERVICE_URL:String = "http://api.ankama.lan/game/";
      
      private static const RELEASE_GAME_SERVICE_URL:String = "http://api.ankama.com/game/";
      
      private static const SHOP_KEY:String = "DOFUS_INGAME";
      
      private static var _self:DofusShopManager;
      
      public static function getInstance() : DofusShopManager {
         if(!_self)
         {
            _self = new DofusShopManager();
         }
         return _self;
      }
      
      private var _serviceBaseUrl:String;
      
      private var _serviceType:String;
      
      private var _currentLocale:String;
      
      private var _currentPurchaseId:int;
      
      private var _cacheHome:Object;
      
      private var _cacheArticles:Array;
      
      private var _objectPool:Array;
      
      private var _lastCategory:int;
      
      private var _lastPage:int;
      
      private var _isOnHomePage:Boolean;
      
      public function init(key:String) : void {
         this._serviceType = "json";
         this._currentLocale = LangManager.getInstance().getEntry("config.lang.current");
         this._objectPool = new Array();
         if(BuildInfos.BUILD_TYPE >= BuildTypeEnum.TESTING)
         {
            this._serviceBaseUrl = LOCAL_GAME_SERVICE_URL;
         }
         else
         {
            this._serviceBaseUrl = RELEASE_GAME_SERVICE_URL;
         }
         RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "authentification." + this._serviceType,this._serviceType,"Authentification",[key],this.onAuthentification);
         this.open();
      }
      
      public function open() : void {
         Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE,this.onClose);
         this._cacheArticles = [];
      }
      
      public function getMoney() : void {
         RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "account." + this._serviceType,this._serviceType,"Money",[],this.onMoney);
      }
      
      public function getHome() : void {
         this._isOnHomePage = true;
         if(this._cacheHome)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopHome,this._cacheHome.categories,this._cacheHome.gondolaArticles,this._cacheHome.gondolaHeads,this._cacheHome.highlightCarousel,this._cacheHome.highlightImages);
            return;
         }
         RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "shop." + this._serviceType,this._serviceType,"Home",[SHOP_KEY,this._currentLocale],this.onHome);
      }
      
      public function buyArticle(articleId:int, quantity:int = 1) : void {
         this._currentPurchaseId = articleId;
         RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "shop." + this._serviceType,this._serviceType,"QuickBuy",[SHOP_KEY,this._currentLocale,articleId,quantity],this.onBuyArticle);
      }
      
      public function getArticlesList(category:int, page:int = 1, size:int = 12) : void {
         this._isOnHomePage = false;
         this._lastCategory = category;
         this._lastPage = page;
         if(!this._cacheArticles[category])
         {
            this._cacheArticles[category] = new Array();
         }
         if(this._cacheArticles[category][page])
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopArticlesList,this._cacheArticles[category][page].articles,this._cacheArticles[category][page].totalPages);
            this.checkPreviousAndNextArticlePages(category,page,this._cacheArticles[category][page].totalPages);
            return;
         }
         RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "shop." + this._serviceType,this._serviceType,"ArticlesList",[SHOP_KEY,this._currentLocale,category,page,size],this.onArticlesList,false);
      }
      
      public function searchForArticles(criteria:String, page:int = 1, size:int = 12) : void {
         this._isOnHomePage = false;
         RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "shop." + this._serviceType,this._serviceType,"ArticlesSearch",[SHOP_KEY,this._currentLocale,criteria,[],page,size],this.onSearchArticles);
      }
      
      public function updateAfterExpiredArticle(articleId:int) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onAuthentification(success:Boolean, params:*, request:*) : void {
         _log.debug("onAuthentification - " + success);
         if(success)
         {
            this.getMoney();
            this.getHome();
         }
         else
         {
            _log.error(params);
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError,"authFailed");
         }
      }
      
      private function onMoney(success:Boolean, params:*, request:*) : void {
         _log.debug("onMoney - " + success);
         if(success)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopMoney,params.ogrins,params.krozs);
         }
         else
         {
            this.processCallError(params);
         }
      }
      
      private function onHome(success:Boolean, params:*, request:*) : void {
         var data:Object = null;
         _log.debug("onHome - " + success);
         if(success)
         {
            if(!params.content)
            {
               this.processCallError("Error: Home requested data corrupted");
               return;
            }
            this._cacheHome = 
               {
                  "categories":[],
                  "gondolaHead":[],
                  "gondolaArticles":[],
                  "highlightCarousel":[],
                  "highlightImages":[]
               };
            if(params.content.categories)
            {
               for each(data in params.content.categories.categories)
               {
                  this._cacheHome.categories.push(new DofusShopCategory(data));
               }
            }
            if(params.content.gondolahead_article)
            {
               for each(data in params.content.gondolahead_article.articles)
               {
                  this._cacheHome.gondolaArticles.push(new DofusShopArticle(data));
               }
            }
            if(params.content.hightlight_carousel)
            {
               for each(data in params.content.hightlight_carousel.hightlights)
               {
                  this._cacheHome.highlightCarousel.push(new DofusShopHighlight(data));
               }
            }
            if(params.content.hightlight_image)
            {
               for each(data in params.content.hightlight_image.hightlights)
               {
                  this._cacheHome.highlightImages.push(new DofusShopHighlight(data));
               }
            }
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopHome,this._cacheHome.categories,this._cacheHome.gondolaArticles,this._cacheHome.gondolaHeads,this._cacheHome.highlightCarousel,this._cacheHome.highlightImages);
         }
         else
         {
            this.processCallError(params);
         }
      }
      
      private function onArticlesList(success:Boolean, params:*, request:*) : void {
         var articles:Array = null;
         var totalPages:* = 0;
         var articleData:Object = null;
         _log.debug("onArticlesList - " + success);
         if(success)
         {
            articles = new Array();
            totalPages = int(params.count / DofusShopEnum.MAX_ARTICLES_PER_PAGE);
            for each(articleData in params.articles)
            {
               articles.push(new DofusShopArticle(articleData));
            }
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopArticlesList,articles,totalPages);
            this._cacheArticles[request.params[2]][request.params[3]] = 
               {
                  "articles":articles,
                  "totalPages":totalPages
               };
            this.checkPreviousAndNextArticlePages(request.params[2],request.params[3],totalPages);
         }
         else
         {
            this.processCallError(params);
         }
      }
      
      private function onPreloadArticlesList(success:Boolean, params:*, request:*) : void {
         var articles:Array = null;
         var totalPages:* = 0;
         var articleData:Object = null;
         _log.debug("onPreloadArticlesList - " + success);
         if(success)
         {
            articles = new Array();
            totalPages = int(params.count / DofusShopEnum.MAX_ARTICLES_PER_PAGE);
            for each(articleData in params.articles)
            {
               articles.push(new DofusShopArticle(articleData));
            }
            this._cacheArticles[request.params[2]][request.params[3]] = 
               {
                  "articles":articles,
                  "totalPages":totalPages
               };
         }
      }
      
      private function onSearchArticles(success:Boolean, params:*, request:*) : void {
         var articles:Array = null;
         var articleData:Object = null;
         _log.debug("onSearchArticles - " + success);
         if(success)
         {
            articles = new Array();
            for each(articleData in params.articles)
            {
               articles.push(new DofusShopArticle(articleData));
            }
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopArticlesList,articles,int(params.count / DofusShopEnum.MAX_ARTICLES_PER_PAGE));
         }
         else
         {
            this.processCallError(params);
         }
      }
      
      private function onBuyArticle(success:Boolean, params:*, request:*) : void {
         _log.debug("onBuyArticle - " + success);
         if(success)
         {
            if(params.result)
            {
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopSuccessfulPurchase,this._currentPurchaseId);
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopMoney,params.ogrins,params.krozs);
            }
            else
            {
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError,params.error);
            }
         }
         else
         {
            this.processCallError(params);
         }
         this._currentPurchaseId = 0;
      }
      
      private function onClose(event:UiUnloadEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function checkPreviousAndNextArticlePages(category:int, page:int, totalPages:int) : void {
         if((page > 1) && (!this._cacheArticles[category][page - 1]))
         {
            RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "shop." + this._serviceType,this._serviceType,"ArticlesList",[SHOP_KEY,this._currentLocale,category,page - 1,DofusShopEnum.MAX_ARTICLES_PER_PAGE],this.onPreloadArticlesList);
         }
         if((page < totalPages) && (!this._cacheArticles[category][page + 1]))
         {
            RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "shop." + this._serviceType,this._serviceType,"ArticlesList",[SHOP_KEY,this._currentLocale,category,page + 1,DofusShopEnum.MAX_ARTICLES_PER_PAGE],this.onPreloadArticlesList);
         }
      }
      
      private function processCallError(error:*) : void {
         _log.error(error);
         if((error is ErrorEvent) && (error.type == IOErrorEvent.NETWORK_ERROR))
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError,"timedOut");
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,"Une erreur est survenue dans le chargement de certaines données dans la boutique, veuillez réessayer. #TED",ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
         }
      }
   }
}
