package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.managers.LangManager;
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
   import flash.events.ErrorEvent;
   import flash.events.IOErrorEvent;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   
   public class DofusShopManager extends Object
   {
      
      public function DofusShopManager()
      {
         super();
      }
      
      private static const _log:Logger = Log.getLogger("DofusShopManager");
      
      private static const SHOP_KEY:String = "DOFUS_INGAME";
      
      private static var _self:DofusShopManager;
      
      public static function getInstance() : DofusShopManager
      {
         if(!_self)
         {
            _self = new DofusShopManager();
         }
         return _self;
      }
      
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
      
      public function init(param1:String, param2:Boolean = false) : void
      {
         this._serviceType = "json";
         this._serviceVersion = "1.0";
         this._currentLocale = LangManager.getInstance().getEntry("config.lang.current");
         this._objectPool = new Array();
         if(!param2)
         {
            this._serviceBaseUrl = RpcServiceCenter.getInstance().apiDomain + "/game/";
         }
         else
         {
            this._serviceBaseUrl = "http://api.ankama.com/game/";
         }
         RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "authentification." + this._serviceType,this._serviceType,this._serviceVersion,"Authentification",[param1,PlayerManager.getInstance().server.id,PlayedCharacterManager.getInstance().id],this.onAuthentification);
         this.open();
      }
      
      public function open() : void
      {
         Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE,this.onClose);
         this._cacheArticles = [];
      }
      
      public function getMoney() : void
      {
         RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "account." + this._serviceType,this._serviceType,this._serviceVersion,"Money",[],this.onMoney);
      }
      
      public function getHome() : void
      {
         this._isOnHomePage = true;
         if(this._cacheHome)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopHome,this._cacheHome.categories,this._cacheHome.gondolaArticles,this._cacheHome.gondolaHeads,this._cacheHome.highlightCarousel,this._cacheHome.highlightImages);
            return;
         }
         RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "shop." + this._serviceType,this._serviceType,this._serviceVersion,"Home",[SHOP_KEY,this._currentLocale],this.onHome);
      }
      
      public function buyArticle(param1:int, param2:int = 1) : void
      {
         this._currentPurchaseId = param1;
         RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "shop." + this._serviceType,this._serviceType,this._serviceVersion,"QuickBuy",[SHOP_KEY,this._currentLocale,param1,param2],this.onBuyArticle,true,false);
      }
      
      public function getArticlesList(param1:int, param2:int = 1, param3:int = 12) : void
      {
         this._isOnHomePage = false;
         this._lastCategory = param1;
         this._lastPage = param2;
         if(!this._cacheArticles[param1])
         {
            this._cacheArticles[param1] = new Array();
         }
         if(this._cacheArticles[param1][param2])
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopArticlesList,this._cacheArticles[param1][param2].articles,this._cacheArticles[param1][param2].totalPages);
            this.checkPreviousAndNextArticlePages(param1,param2,this._cacheArticles[param1][param2].totalPages);
            return;
         }
         RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "shop." + this._serviceType,this._serviceType,this._serviceVersion,"ArticlesList",[SHOP_KEY,this._currentLocale,param1,param2,param3],this.onArticlesList,false);
      }
      
      public function searchForArticles(param1:String, param2:int = 1, param3:int = 12) : void
      {
         this._isOnHomePage = false;
         RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "shop." + this._serviceType,this._serviceType,this._serviceVersion,"ArticlesSearch",[SHOP_KEY,this._currentLocale,param1,[],param2,param3],this.onSearchArticles);
      }
      
      public function updateAfterExpiredArticle(param1:int) : void
      {
         var _loc2_:* = 0;
         var _loc3_:Array = null;
         var _loc4_:DofusShopObject = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:Array = null;
         var _loc9_:String = null;
         var _loc10_:* = false;
         var _loc11_:String = null;
         var _loc12_:Object = null;
         if((this._cacheHome) && (this._cacheHome.gondolaArticles))
         {
            _loc2_ = this._cacheHome.gondolaArticles.length;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               if(this._cacheHome.gondolaArticles[_loc5_].id == param1)
               {
                  this._cacheHome.gondolaArticles.splice(_loc5_,1);
                  if(this._isOnHomePage)
                  {
                     KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopHome,this._cacheHome.categories,this._cacheHome.gondolaArticles,this._cacheHome.gondolaHeads,this._cacheHome.highlightCarousel,this._cacheHome.highlightImages);
                  }
                  break;
               }
               _loc5_++;
            }
         }
         if(this._cacheArticles)
         {
            _loc8_ = new Array();
            for(_loc9_ in this._cacheArticles)
            {
               _loc6_ = parseInt(_loc9_);
               for(_loc11_ in this._cacheArticles[_loc6_])
               {
                  _loc7_ = parseInt(_loc11_);
                  if(_loc8_.indexOf(_loc6_) != -1)
                  {
                     break;
                  }
                  if(this._cacheArticles[_loc6_][_loc7_].articles)
                  {
                     _loc2_ = this._cacheArticles[_loc6_][_loc7_].articles.length;
                     _loc5_ = 0;
                     while(_loc5_ < _loc2_)
                     {
                        if(this._cacheArticles[_loc6_][_loc7_].articles[_loc5_].id == param1)
                        {
                           _loc8_.push(_loc6_);
                           break;
                        }
                        _loc5_++;
                     }
                  }
               }
            }
            _loc10_ = false;
            for each(_loc6_ in _loc8_)
            {
               if(_loc6_ == this._lastCategory)
               {
                  _loc10_ = true;
               }
               for each(_loc12_ in this._cacheArticles[_loc6_])
               {
                  for each(_loc4_ in _loc12_.articles)
                  {
                     _loc4_.free();
                  }
               }
               delete this._cacheArticles[_loc6_];
               true;
            }
            if(!this._isOnHomePage && (_loc10_))
            {
               this.getArticlesList(this._lastCategory,this._lastPage);
            }
         }
      }
      
      private function onAuthentification(param1:Boolean, param2:*, param3:*) : void
      {
         _log.debug("onAuthentification - " + param1);
         if(param1)
         {
            this.getMoney();
            this.getHome();
         }
         else
         {
            _log.error(param2);
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError,DofusShopEnum.ERROR_AUTHENTICATION_FAILED);
         }
      }
      
      private function onMoney(param1:Boolean, param2:*, param3:*) : void
      {
         _log.debug("onMoney - " + param1);
         if(param1)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopMoney,param2.ogrins,param2.krozs);
         }
         else
         {
            this.processCallError(param2);
         }
      }
      
      private function onHome(param1:Boolean, param2:*, param3:*) : void
      {
         var _loc4_:Object = null;
         var _loc5_:DofusShopArticle = null;
         _log.debug("onHome - " + param1);
         if(param1)
         {
            if(!param2.content)
            {
               this.processCallError("Error: Home requested data corrupted");
               return;
            }
            this._cacheHome = {
               "categories":[],
               "gondolaHead":[],
               "gondolaArticles":[],
               "highlightCarousel":[],
               "highlightImages":[]
            };
            if(param2.content.categories)
            {
               for each(_loc4_ in param2.content.categories.categories)
               {
                  this._cacheHome.categories.push(new DofusShopCategory(_loc4_));
               }
            }
            if(param2.content.gondolahead_article)
            {
               for each(_loc4_ in param2.content.gondolahead_article.articles)
               {
                  _loc5_ = new DofusShopArticle(_loc4_);
                  if(!_loc5_.hasExpired)
                  {
                     this._cacheHome.gondolaArticles.push(_loc5_);
                  }
               }
            }
            if(param2.content.hightlight_carousel)
            {
               for each(_loc4_ in param2.content.hightlight_carousel.hightlights)
               {
                  this._cacheHome.highlightCarousel.push(new DofusShopHighlight(_loc4_));
               }
            }
            if(param2.content.hightlight_image)
            {
               for each(_loc4_ in param2.content.hightlight_image.hightlights)
               {
                  this._cacheHome.highlightImages.push(new DofusShopHighlight(_loc4_));
               }
            }
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopHome,this._cacheHome.categories,this._cacheHome.gondolaArticles,this._cacheHome.gondolaHeads,this._cacheHome.highlightCarousel,this._cacheHome.highlightImages);
         }
         else
         {
            this.processCallError(param2);
         }
      }
      
      private function onArticlesList(param1:Boolean, param2:*, param3:*) : void
      {
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         var _loc6_:Object = null;
         var _loc7_:DofusShopArticle = null;
         if(!this._cacheArticles)
         {
            return;
         }
         _log.debug("onArticlesList - " + param1);
         if(param1)
         {
            _loc4_ = new Array();
            _loc5_ = Math.ceil(param2.count / DofusShopEnum.MAX_ARTICLES_PER_PAGE);
            for each(_loc6_ in param2.articles)
            {
               _loc7_ = new DofusShopArticle(_loc6_);
               if(!_loc7_.hasExpired)
               {
                  _loc4_.push(_loc7_);
               }
            }
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopArticlesList,_loc4_,_loc5_);
            this._cacheArticles[param3.params[2]][param3.params[3]] = {
               "articles":_loc4_,
               "totalPages":_loc5_
            };
            this.checkPreviousAndNextArticlePages(param3.params[2],param3.params[3],_loc5_);
         }
         else
         {
            this.processCallError(param2);
         }
      }
      
      private function onPreloadArticlesList(param1:Boolean, param2:*, param3:*) : void
      {
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         var _loc6_:Object = null;
         var _loc7_:DofusShopArticle = null;
         if(!this._cacheArticles)
         {
            return;
         }
         _log.debug("onPreloadArticlesList - " + param1);
         if(param1)
         {
            if(!this._cacheArticles)
            {
               return;
            }
            _loc4_ = new Array();
            _loc5_ = Math.ceil(param2.count / DofusShopEnum.MAX_ARTICLES_PER_PAGE);
            for each(_loc6_ in param2.articles)
            {
               _loc7_ = new DofusShopArticle(_loc6_);
               if(!_loc7_.hasExpired)
               {
                  _loc4_.push(_loc7_);
               }
            }
            this._cacheArticles[param3.params[2]][param3.params[3]] = {
               "articles":_loc4_,
               "totalPages":_loc5_
            };
         }
      }
      
      private function onSearchArticles(param1:Boolean, param2:*, param3:*) : void
      {
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         var _loc6_:Object = null;
         var _loc7_:DofusShopArticle = null;
         if(!this._cacheArticles)
         {
            return;
         }
         _log.debug("onSearchArticles - " + param1);
         if(param1)
         {
            _loc4_ = new Array();
            _loc5_ = Math.ceil(param2.count / DofusShopEnum.MAX_ARTICLES_PER_PAGE);
            for each(_loc6_ in param2.articles)
            {
               _loc7_ = new DofusShopArticle(_loc6_);
               if(!_loc7_.hasExpired)
               {
                  _loc4_.push(_loc7_);
               }
            }
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopArticlesList,_loc4_,_loc5_);
         }
         else
         {
            this.processCallError(param2);
         }
      }
      
      private function onBuyArticle(param1:Boolean, param2:*, param3:*) : void
      {
         _log.debug("onBuyArticle - " + param1);
         if(param1)
         {
            if(param2.result)
            {
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopSuccessfulPurchase,this._currentPurchaseId);
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopMoney,param2.ogrins,param2.krozs);
            }
            else
            {
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError,param2.error);
            }
         }
         else if(param2 is ErrorEvent && param2.type == IOErrorEvent.NETWORK_ERROR)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError,DofusShopEnum.ERROR_PURCHASE_REQUEST_TIMED_OUT);
         }
         else
         {
            this.processCallError(param2);
         }
         
         this._currentPurchaseId = 0;
      }
      
      private function onClose(param1:UiUnloadEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:DofusShopObject = null;
         var _loc4_:Object = null;
         if(param1.name == "webBase" && (this._cacheHome))
         {
            Berilia.getInstance().removeEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE,this.onClose);
            for each(_loc2_ in this._cacheHome)
            {
               for each(_loc3_ in _loc2_)
               {
                  _loc3_.free();
               }
               _loc2_ = null;
            }
            this._cacheHome = null;
            for each(_loc2_ in this._cacheArticles)
            {
               for each(_loc4_ in _loc2_)
               {
                  for each(_loc3_ in _loc4_.articles)
                  {
                     _loc3_.free();
                  }
                  _loc4_ = null;
               }
               _loc2_ = null;
            }
            this._cacheArticles = null;
         }
      }
      
      private function checkPreviousAndNextArticlePages(param1:int, param2:int, param3:int) : void
      {
         if(param2 > 1 && !this._cacheArticles[param1][param2 - 1])
         {
            RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "shop." + this._serviceType,this._serviceType,this._serviceVersion,"ArticlesList",[SHOP_KEY,this._currentLocale,param1,param2 - 1,DofusShopEnum.MAX_ARTICLES_PER_PAGE],this.onPreloadArticlesList);
         }
         if(param2 < param3 && !this._cacheArticles[param1][param2 + 1])
         {
            RpcServiceCenter.getInstance().makeRpcCall(this._serviceBaseUrl + "shop." + this._serviceType,this._serviceType,this._serviceVersion,"ArticlesList",[SHOP_KEY,this._currentLocale,param1,param2 + 1,DofusShopEnum.MAX_ARTICLES_PER_PAGE],this.onPreloadArticlesList);
         }
      }
      
      private function processCallError(param1:*) : void
      {
         _log.error(param1);
         if(param1 is ErrorEvent && param1.type == IOErrorEvent.NETWORK_ERROR)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError,DofusShopEnum.ERROR_REQUEST_TIMED_OUT);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.shop.errorApi"),ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
         }
      }
   }
}
