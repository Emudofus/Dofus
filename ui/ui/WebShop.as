package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.UtilApi;
   import flash.utils.Dictionary;
   import d2data.DofusShopArticle;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2components.GraphicContainer;
   import d2components.Grid;
   import d2components.Input;
   import d2components.Texture;
   import d2enums.ComponentHookList;
   import d2hooks.*;
   import d2actions.*;
   import flash.utils.clearInterval;
   import d2enums.DofusShopEnum;
   import d2data.DofusShopHighlight;
   import d2data.DofusShopCategory;
   import d2enums.LocationEnum;
   import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
   import flash.utils.setInterval;
   
   public class WebShop extends Object
   {
      
      public function WebShop() {
         this._compHookData = new Dictionary(true);
         this._categories = new Array();
         this._highlightCarousels = new Array();
         this._highlightImages = new Array();
         super();
      }
      
      private static var CTR_CAT_TYPE_CAT:String = "ctr_cat";
      
      private static var CTR_CAT_TYPE_SUBCAT:String = "ctr_subCat";
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var utilApi:UtilApi;
      
      public var modCommon:Object;
      
      private var _compHookData:Dictionary;
      
      private var _moneyOgr:int;
      
      private var _moneyKro:int;
      
      private var _searchCriteria:String;
      
      private var _isOnSearch:Boolean = false;
      
      private var _categories:Array;
      
      private var _openCatIndex:int;
      
      private var _currentSelectedCatId:int;
      
      private var _highlightCarousels:Array;
      
      private var _currentCarouselArticleIndex:int;
      
      private var _carouselInterval:Number;
      
      private var _highlightImages:Array;
      
      private var _isOnFrontPage:Boolean = true;
      
      private var _currentPage:uint = 1;
      
      private var _maxPage:uint = 1;
      
      private var _selectedArticle:DofusShopArticle;
      
      private var _currencyUriOgr:Object;
      
      private var _currencyUriKro:Object;
      
      public var btn_close:ButtonContainer;
      
      public var btn_buyOgrins:ButtonContainer;
      
      public var lbl_ogrins:Label;
      
      public var lbl_krozs:Label;
      
      public var btn_frontPage:ButtonContainer;
      
      public var ctr_frontDisplayButtons:GraphicContainer;
      
      public var gd_frontDisplayButtons:Grid;
      
      public var gd_categories:Grid;
      
      public var inp_search:Input;
      
      public var tx_inputBg:Texture;
      
      public var btn_startSearch:ButtonContainer;
      
      public var btn_resetSearch:ButtonContainer;
      
      public var lbl_noResult:Label;
      
      public var ctr_frontDisplay:GraphicContainer;
      
      public var ctr_carousel:GraphicContainer;
      
      public var tx_carousel:Texture;
      
      public var lbl_carouselTitle:Label;
      
      public var lbl_carouselDesc:Label;
      
      public var lbl_carouselPrice:Label;
      
      public var btn_carouselBuy:ButtonContainer;
      
      public var tx_carouselCurrency:Texture;
      
      public var ctr_carouselLeft:GraphicContainer;
      
      public var btn_carouselPrevPage:ButtonContainer;
      
      public var ctr_carouselRight:GraphicContainer;
      
      public var btn_carouselNextPage:ButtonContainer;
      
      public var tx_highlightImage0:Texture;
      
      public var tx_highlightImage1:Texture;
      
      public var gd_frontDisplayArticles:Grid;
      
      public var lbl_catTitle:Label;
      
      public var ctr_articlesDisplay:GraphicContainer;
      
      public var gd_articles:Grid;
      
      public var btn_prevPage:Object;
      
      public var btn_nextPage:Object;
      
      public var lbl_page:Object;
      
      public var tx_maskWaiting:Texture;
      
      public var tx_hourglassWaiting:Texture;
      
      public var ctr_popupArticle:GraphicContainer;
      
      public var btn_popupBuy:ButtonContainer;
      
      public var btn_popupClose:ButtonContainer;
      
      public var lbl_popupName:Label;
      
      public var lbl_popupPrice:Label;
      
      public var lbl_popupOldPrice:Label;
      
      public var tx_popupCurrency:Texture;
      
      public function main(oParam:Object = null) : void {
         this.sysApi.addHook(DofusShopHome,this.onDofusShopHome);
         this.sysApi.addHook(DofusShopMoney,this.onDofusShopMoney);
         this.sysApi.addHook(DofusShopArticlesList,this.onDofusShopArticlesList);
         this.sysApi.addHook(DofusShopSuccessfulPurchase,this.onDofusShopSuccessfulPurchase);
         this.sysApi.addHook(DofusShopError,this.onDofusShopError);
         this.uiApi.addComponentHook(this.gd_categories,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_frontDisplayButtons,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_articles,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_frontDisplayArticles,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.btn_buyOgrins,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_buyOgrins,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_buyOgrins,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_frontPage,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_startSearch,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_startSearch,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_resetSearch,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_resetSearch,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_highlightImage0,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_highlightImage1,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_carousel,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_carouselLeft,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_carouselLeft,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_carouselRight,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_carouselRight,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_carouselNextPage,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_carouselNextPage,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_carouselPrevPage,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_carouselPrevPage,ComponentHookList.ON_ROLL_OUT);
         this.ctr_frontDisplay.visible = true;
         this.ctr_articlesDisplay.visible = false;
         this.tx_maskWaiting.alpha = 0;
         this._currencyUriOgr = this.uiApi.createUri(this.uiApi.me().getConstant("ogr_uri"));
         this._currencyUriKro = this.uiApi.createUri(this.uiApi.me().getConstant("kro_uri"));
         if(oParam)
         {
            this._moneyOgr = oParam.ogrins;
            this._moneyKro = oParam.krozs;
            this.refreshMoney();
            this.onDofusShopHome(oParam.categories,oParam.frontDisplayArticles,oParam.frontDisplayMains,oParam.highlightCarousels,oParam.highlightImages);
         }
      }
      
      public function unload() : void {
         clearInterval(this._carouselInterval);
      }
      
      public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint) : void {
         switch(this.getCatLineType(data,line))
         {
            case CTR_CAT_TYPE_CAT:
            case CTR_CAT_TYPE_SUBCAT:
               componentsRef.btn_lbl_btn_cat.text = data.name;
               componentsRef.btn_cat.selected = selected;
               if((data.img) && (data.img.length > 0))
               {
                  componentsRef.tx_catIllu.uri = this.uiApi.createUri(data.img);
               }
               break;
         }
      }
      
      public function getCatLineType(data:*, line:uint) : String {
         if(!data)
         {
            return "";
         }
         switch(line)
         {
            case 0:
               if((data) && (data.parentId == -1))
               {
                  return CTR_CAT_TYPE_CAT;
               }
               return CTR_CAT_TYPE_SUBCAT;
            default:
               return CTR_CAT_TYPE_SUBCAT;
         }
      }
      
      public function getCatDataLength(data:*, selected:Boolean) : * {
         if(selected)
         {
            trace(data.title + " : " + (2 + (selected?data.subcats.length:0)));
         }
         return 2 + (selected?data.subcats.length:0);
      }
      
      public function updateArticle(data:*, components:*, selected:Boolean) : void {
         if(!this._compHookData[components.btn_buy.name])
         {
            this.uiApi.addComponentHook(components.btn_buy,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(components.btn_buy,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_buy,ComponentHookList.ON_ROLL_OUT);
         }
         this._compHookData[components.btn_buy.name] = data;
         if(data)
         {
            components.lbl_name.text = data.name;
            if(data.originalPrice > 0)
            {
               components.lbl_oldPrice.text = this.utilApi.kamasToString(data.originalPrice,"");
            }
            else
            {
               components.lbl_oldPrice.text = "";
            }
            components.lbl_price.text = this.utilApi.kamasToString(data.price,"");
            if((data.imageSmall) && (data.imageSmall.length > 0))
            {
               components.tx_picto.uri = this.uiApi.createUri(data.imageSmall);
            }
            if(data.currency == DofusShopEnum.CURRENCY_OGRINES)
            {
               components.tx_currency.uri = this._currencyUriOgr;
            }
            else if(data.currency == DofusShopEnum.CURRENCY_KROZ)
            {
               components.tx_currency.uri = this._currencyUriKro;
            }
            
            components.btn_buy.visible = true;
         }
         else
         {
            components.lbl_name.text = "";
            components.lbl_oldPrice.text = "";
            components.lbl_price.text = "";
            components.tx_picto.uri = null;
            components.tx_currency.uri = null;
            components.btn_buy.visible = false;
         }
      }
      
      public function onPopupClose() : void {
      }
      
      private function refreshMoney() : void {
         if(this._moneyOgr > -1)
         {
            this.lbl_ogrins.text = this.utilApi.kamasToString(this._moneyOgr,"");
         }
         if(this._moneyKro > -1)
         {
            this.lbl_krozs.text = this.utilApi.kamasToString(this._moneyKro,"");
         }
      }
      
      private function displayCategories(selectedCategory:Object = null, forceOpen:Boolean = false) : void {
         var myIndex:int;
         var cat:Object;
         var cat2:Object;
         var subcat:Object;
         if (!(selectedCategory)){
             selectedCategory = this.gd_categories.selectedItem;
         };
         if ((((((selectedCategory.parentId > -1)) && ((this._openCatIndex == selectedCategory.parentId)))) || ((this._openCatIndex == selectedCategory.id)))){
             this._currentSelectedCatId = selectedCategory.id;
             for each (cat2 in this.gd_categories.dataProvider) {
                 if (cat2.id == this._currentSelectedCatId){
                     break;
                 };
                 myIndex++;
             };
             if (this.gd_categories.selectedIndex != myIndex){
                 this.gd_categories.silent = true;
                 this.gd_categories.selectedIndex = myIndex;
                 this.gd_categories.silent = false;
             };
             this._currentPage = 1;
             this.sysApi.sendAction(new ShopArticlesListRequest(this._currentSelectedCatId, 1));
             this.manageWaiting();
             if (this._openCatIndex != selectedCategory.id){
                 return;
             };
         };
         var bigCatId:int = selectedCategory.id;
         if (selectedCategory.parentId > -1){
             bigCatId = selectedCategory.parentId;
         };
         var index:int = -1;
         var tempCats:Array = new Array();
         var categoryOpened:int = -1;
         for each (cat in this._categories) {
             tempCats.push(cat);
             index++;
             if (bigCatId == cat.id){
                 myIndex = index;
                 if (((!((this._currentSelectedCatId == cat.id))) || ((this._openCatIndex == 0)))){
                     categoryOpened = cat.id;
                     for each (subcat in cat.subcats) {
                         tempCats.push(subcat);
                         index++;
                         if (subcat.id == selectedCategory.id){
                             myIndex = index;
                         };
                     };
                 };
             };
         };
         if (categoryOpened >= 0){
             this._openCatIndex = categoryOpened;
         }
         else {
             this._openCatIndex = 0;
         };
         this._currentSelectedCatId = selectedCategory.id;
         this.gd_categories.dataProvider = tempCats;
         if (this.gd_categories.selectedIndex != myIndex){
             this.gd_categories.silent = true;
             this.gd_categories.selectedIndex = myIndex;
             this.gd_categories.silent = false;
         };
         this._currentPage = 1;
         this.sysApi.sendAction(new ShopArticlesListRequest(this._currentSelectedCatId, 1));
         this.manageWaiting();
      }
      
      private function showHighlightCarouselArticle(increase:Boolean = true) : void {
         if(!this._isOnFrontPage)
         {
            return;
         }
         if(increase)
         {
            this._currentCarouselArticleIndex++;
         }
         else
         {
            this._currentCarouselArticleIndex = --this._currentCarouselArticleIndex + this._highlightCarousels.length;
         }
         if((this._currentCarouselArticleIndex >= this._highlightCarousels.length) || (this._currentCarouselArticleIndex < 0))
         {
            this._currentCarouselArticleIndex = this._currentCarouselArticleIndex % this._highlightCarousels.length;
         }
         var highlight:DofusShopHighlight = this._highlightCarousels[this._currentCarouselArticleIndex];
         if(!highlight)
         {
            return;
         }
         this.tx_carousel.uri = this.uiApi.createUri(highlight.image);
         this.lbl_carouselTitle.text = highlight.name;
         this.lbl_carouselDesc.text = highlight.description;
         if(highlight.type == DofusShopEnum.HIGHLIGHT_TYPE_ARTICLE)
         {
            this.lbl_carouselPrice.text = this.utilApi.kamasToString((highlight.external as DofusShopArticle).price,"");
            this.btn_carouselBuy.visible = true;
            this.tx_carouselCurrency.visible = true;
            if((highlight.external as DofusShopArticle).currency == DofusShopEnum.CURRENCY_OGRINES)
            {
               this.tx_carouselCurrency.uri = this._currencyUriOgr;
            }
            else
            {
               this.tx_carouselCurrency.uri = this._currencyUriKro;
            }
         }
         else
         {
            this.lbl_carouselPrice.text = "";
            this.btn_carouselBuy.visible = false;
            this.tx_carouselCurrency.visible = false;
         }
      }
      
      private function showHighlightImage(image:DofusShopHighlight, slotId:int) : void {
         if(!this._isOnFrontPage)
         {
            return;
         }
         if((this["tx_highlightImage" + slotId]) && (image))
         {
            this["tx_highlightImage" + slotId].uri = this.uiApi.createUri(image.image);
         }
      }
      
      private function releaseOnHighlight(highlight:DofusShopHighlight) : void {
         var cat:DofusShopCategory;
         var customCatToOpen:Object;
         var c:Object;
         var c2:Object;
         if (!(this._isOnFrontPage)){
             return;
         };
         if (((highlight.link) && (!((highlight.link == ""))))){
             this.sysApi.goToUrl(highlight.link);
         }
         else {
             if (highlight.type == DofusShopEnum.HIGHLIGHT_TYPE_CATEGORY){
                 cat = (highlight.external as DofusShopCategory);
                 for each (c in this._categories) {
                     if (c.id == cat.id){
                         customCatToOpen = c;
                     }
                     else {
                         for each (c2 in c.subcats) {
                             if (c2.id == cat.id){
                                 customCatToOpen = c2;
                             };
                         };
                     };
                 };
                 this.displayCategories(customCatToOpen, true);
             }
             else {
                 if (highlight.type == DofusShopEnum.HIGHLIGHT_TYPE_ARTICLE){
                     this._selectedArticle = (highlight.external as DofusShopArticle);
                     this.displayArticle();
                 };
             };
         };
      }
      
      private function refreshPageNumber() : void {
         if(this._currentPage <= 1)
         {
            this.btn_prevPage.disabled = true;
         }
         else
         {
            this.btn_prevPage.disabled = false;
         }
         if(this._currentPage >= this._maxPage)
         {
            this.btn_nextPage.disabled = true;
         }
         else
         {
            this.btn_nextPage.disabled = false;
         }
         this.lbl_page.text = this._currentPage + "/" + this._maxPage;
      }
      
      private function displayArticle() : void {
         this.lbl_popupName.text = this._selectedArticle.name;
         this.lbl_popupPrice.text = this.utilApi.kamasToString(this._selectedArticle.price,"");
         this.lbl_popupOldPrice.text = this.utilApi.kamasToString(this._selectedArticle.originalPrice,"");
         if(this._selectedArticle.currency == DofusShopEnum.CURRENCY_OGRINES)
         {
            this.tx_popupCurrency.uri = this._currencyUriOgr;
            if(this._selectedArticle.price > this._moneyOgr)
            {
               this.btn_popupBuy.disabled = true;
            }
            else
            {
               this.btn_popupBuy.disabled = false;
            }
         }
         else if(this._selectedArticle.currency == DofusShopEnum.CURRENCY_KROZ)
         {
            this.tx_popupCurrency.uri = this._currencyUriKro;
            if(this._selectedArticle.price > this._moneyKro)
            {
               this.btn_popupBuy.disabled = true;
            }
            else
            {
               this.btn_popupBuy.disabled = false;
            }
         }
         
         this.ctr_popupArticle.visible = true;
      }
      
      private function manageWaiting(start:Boolean = true) : void {
         if(start)
         {
            this.tx_maskWaiting.alpha = 0.6;
            this.tx_maskWaiting.mouseEnabled = true;
            this.tx_hourglassWaiting.visible = true;
         }
         else
         {
            this.tx_maskWaiting.alpha = 0;
            this.tx_maskWaiting.mouseEnabled = false;
            this.tx_hourglassWaiting.visible = false;
         }
      }
      
      private function showSpellTooltip() : void {
      }
      
      public function onRelease(target:Object) : void {
         var carouselHighlight:DofusShopHighlight = null;
         var image0:DofusShopHighlight = null;
         var image1:DofusShopHighlight = null;
         var text:String = null;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_resetSearch:
               this._searchCriteria = null;
               this.inp_search.text = "";
               break;
            case this.btn_startSearch:
               if((!(this._searchCriteria == this.inp_search.text)) || (!(this._currentPage == 1)))
               {
                  this._currentPage = 1;
                  this._searchCriteria = this.inp_search.text;
                  this.sysApi.sendAction(new ShopSearchRequest(this._searchCriteria,1));
                  this.manageWaiting();
                  this.sysApi.log(2,"--> send   ShopSearchRequest  " + this._searchCriteria + "  1");
                  this._isOnSearch = true;
               }
               break;
            case this.btn_frontPage:
               if(!this._isOnFrontPage)
               {
                  this.sysApi.sendAction(new ShopFrontPageRequest());
                  this.sysApi.log(2,"--> send   ShopFrontPageRequest  ");
                  this._isOnSearch = false;
               }
               break;
            case this.btn_nextPage:
               if(this._currentPage + 1 <= this._maxPage)
               {
                  if(this._isOnSearch)
                  {
                     this.sysApi.sendAction(new ShopSearchRequest(this._searchCriteria,++this._currentPage));
                     this.manageWaiting();
                     this.sysApi.log(2,"--> send   ShopSearchRequest  " + this._searchCriteria + "  " + this._currentPage);
                  }
                  else
                  {
                     this.sysApi.sendAction(new ShopArticlesListRequest(this._currentSelectedCatId,++this._currentPage));
                     this.manageWaiting();
                     this.sysApi.log(2,"--> send   ShopArticlesListRequest  " + this._currentSelectedCatId + "  " + this._currentPage);
                  }
                  this.refreshPageNumber();
               }
               break;
            case this.btn_prevPage:
               if(this._currentPage - 1 >= 0)
               {
                  if(this._isOnSearch)
                  {
                     this.sysApi.sendAction(new ShopSearchRequest(this._searchCriteria,--this._currentPage));
                     this.manageWaiting();
                     this.sysApi.log(2,"--> send   ShopSearchRequest  " + this._searchCriteria + "  " + this._currentPage);
                  }
                  else
                  {
                     this.sysApi.sendAction(new ShopArticlesListRequest(this._currentSelectedCatId,--this._currentPage));
                     this.manageWaiting();
                     this.sysApi.log(2,"--> send   ShopArticlesListRequest  " + this._currentSelectedCatId + "  " + this._currentPage);
                  }
                  this.refreshPageNumber();
               }
               break;
            case this.btn_buyOgrins:
               this.sysApi.log(2,"go vers le site pour acheter des ogrines (ted)");
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.subscribe"));
               break;
            case this.ctr_carousel:
               carouselHighlight = this._highlightCarousels[this._currentCarouselArticleIndex];
               this.releaseOnHighlight(carouselHighlight);
               break;
            case this.tx_highlightImage0:
               image0 = this._highlightImages[0];
               this.releaseOnHighlight(image0);
               break;
            case this.tx_highlightImage1:
               image1 = this._highlightImages[1];
               this.releaseOnHighlight(image1);
               break;
            case this.btn_carouselBuy:
               this._selectedArticle = this._highlightCarousels[this._currentCarouselArticleIndex].external;
               this.displayArticle();
               break;
            case this.btn_carouselNextPage:
               this.showHighlightCarouselArticle();
               break;
            case this.btn_carouselPrevPage:
               this.showHighlightCarouselArticle(false);
               break;
            case this.btn_popupBuy:
               text = "Etes-vous sur de vouloir dépenser " + this._selectedArticle.price + " " + this._selectedArticle.currency + " pour 1x\'" + this._selectedArticle.name + "\' (ted) ?";
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),text,[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.onPopupBuy,this.onPopupClose],this.onPopupBuy,this.onPopupClose);
               break;
            case this.btn_popupClose:
               this._selectedArticle = null;
               this.ctr_popupArticle.visible = false;
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         var pos:Object = 
            {
               "point":LocationEnum.POINT_BOTTOM,
               "relativePoint":LocationEnum.POINT_TOP
            };
         switch(target)
         {
            case this.btn_buyOgrins:
               text = "Acheter des ogrines (ted)";
               break;
            case this.btn_startSearch:
               text = "Lancer la recherche (ted)";
               break;
            case this.btn_resetSearch:
               text = "Vider le champ de recherche (ted)";
               break;
            case this.ctr_carouselRight:
            case this.ctr_carouselLeft:
            case this.btn_carouselPrevPage:
            case this.btn_carouselNextPage:
               this.ctr_carouselRight.bgAlpha = 0.4;
               this.ctr_carouselLeft.bgAlpha = 0.4;
               this.btn_carouselNextPage.visible = true;
               this.btn_carouselPrevPage.visible = true;
               break;
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         if(((target == this.ctr_carouselRight) || (target == this.ctr_carouselLeft)) && (!(target == this.btn_carouselNextPage)) && (!(target == this.btn_carouselPrevPage)))
         {
            this.ctr_carouselRight.bgAlpha = 0;
            this.ctr_carouselLeft.bgAlpha = 0;
            this.btn_carouselNextPage.visible = false;
            this.btn_carouselPrevPage.visible = false;
         }
         else
         {
            this.uiApi.hideTooltip();
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(selectMethod != GridItemSelectMethodEnum.AUTO)
         {
            if(target == this.gd_categories)
            {
               this._searchCriteria = null;
               this.inp_search.text = "";
               this.displayCategories(target.selectedItem);
            }
            else if(this._selectedArticle == target.selectedItem)
            {
               this._selectedArticle = null;
               this.ctr_popupArticle.visible = false;
            }
            else
            {
               this._selectedArticle = target.selectedItem;
               this.displayArticle();
            }
            
         }
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
      }
      
      private function onPopupBuy() : void {
         this.sysApi.sendAction(new ShopBuyRequest(this._selectedArticle.id,1));
      }
      
      private function onDofusShopArticlesList(articles:Object, totalPages:uint) : void {
         var articlesToDisplay:Array = null;
         var a:DofusShopArticle = null;
         clearInterval(this._carouselInterval);
         this.sysApi.log(2,"onDofusShopArticlesList : " + articles.length + "     totalpages " + totalPages);
         this._isOnFrontPage = false;
         if(!this._isOnSearch)
         {
            this.lbl_catTitle.text = this.gd_categories.selectedItem.name;
         }
         else
         {
            this.lbl_catTitle.text = this.uiApi.getText("ui.search.search") + this.uiApi.getText("ui.common.colon") + this._searchCriteria;
         }
         this._maxPage = totalPages;
         if(articles.length == 0)
         {
            this.lbl_page.text = "";
            this.gd_articles.visible = false;
            this.lbl_noResult.visible = true;
            this.btn_nextPage.disabled = true;
            this.btn_prevPage.disabled = true;
         }
         else
         {
            this.refreshPageNumber();
            articlesToDisplay = new Array();
            for each(a in articles)
            {
               articlesToDisplay.push(a);
            }
            this.gd_articles.dataProvider = articlesToDisplay;
            this.gd_articles.visible = true;
            this.lbl_noResult.visible = false;
         }
         this.ctr_frontDisplay.visible = false;
         this.ctr_articlesDisplay.visible = true;
         this.manageWaiting(false);
      }
      
      private function onDofusShopSuccessfulPurchase(articleId:int) : void {
         this.sysApi.log(2,"onDofusShopSuccessfulPurchase : " + articleId);
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.information"),"L\'article " + articleId + " a bien été acheté, felicitations ! (ted)",[this.uiApi.getText("ui.common.ok")]);
      }
      
      private function onDofusShopError(errorId:String) : void {
         var text:String = null;
         this.sysApi.log(2,"onDofusShopError : " + errorId);
         switch("error_" + errorId)
         {
            case DofusShopEnum.ERROR_PURCHASE_FAILED:
               text = "L\'achat a échoué. (ted)";
               break;
            case DofusShopEnum.ERROR_PURCHASE_NO_MONEY:
               text = "L\'achat a échoué, vous n\'avez plus assez d\'argent. (ted)";
               break;
            case DofusShopEnum.ERROR_PURCHASE_NO_STOCK:
               text = "L\'achat a échoué, le produit ne semble plus être disponible. (ted)";
               break;
            case DofusShopEnum.ERROR_REQUEST_TIMED_OUT:
               text = "Le shop met trop de temps à répondre. (ted)";
               break;
            default:
               text = "Le shop a rencontré un souci d\'ordre inconnu. (ted)";
         }
         this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),text,[this.uiApi.getText("ui.common.ok")]);
      }
      
      private function onDofusShopMoney(ogrins:int, krozs:int) : void {
         this.sysApi.log(2,"onDofusShopMoney : " + ogrins + "     " + krozs);
         this._moneyOgr = ogrins;
         this._moneyKro = krozs;
         this.refreshMoney();
      }
      
      private function onDofusShopHome(categories:Object, frontDisplayArticles:Object, frontDisplayMains:Object, highlightCarousels:Object, highlightImages:Object) : void {
         var c:DofusShopCategory;
         var articlesToDisplay:Array;
         var a:DofusShopArticle;
         var hc:DofusShopHighlight;
         var hi:DofusShopHighlight;
         var i:int;
         var c2:DofusShopCategory;
         this.sysApi.log(2, "onDofusShopHome");
         this._isOnFrontPage = true;
         if (((frontDisplayMains) && ((frontDisplayMains.length > 0)))){
             this.ctr_frontDisplayButtons.visible = true;
         }
         else {
             this.ctr_frontDisplayButtons.visible = false;
         };
         this.sysApi.log(2, ("   categories " + categories.length));
         this._categories = new Array();
         var childrens:Array = new Array();
         for each (c in categories) {
             this.sysApi.log(2, ("     - " + c.name));
             childrens[c.id] = new Array();
             for each (c2 in c.children) {
                 childrens[c.id].push({
                     "id":c2.id,
                     "name":c2.name,
                     "desc":c2.description,
                     "img":c2.image,
                     "parentId":c.id,
                     "subcats":new Array()
                 });
             };
             this._categories.push({
                 "id":c.id,
                 "name":c.name,
                 "desc":c.description,
                 "img":c.image,
                 "parentId":-1,
                 "subcats":childrens[c.id]
             });
         };
         this.gd_categories.dataProvider = this._categories;
         this.sysApi.log(2, ("   articles " + frontDisplayArticles.length));
         articlesToDisplay = new Array();
         for each (a in frontDisplayArticles) {
             this.sysApi.log(2, ("     - " + a.name));
             articlesToDisplay.push(a);
         };
         this.gd_frontDisplayArticles.dataProvider = articlesToDisplay;
         this.sysApi.log(2, ("   caroussel " + highlightCarousels.length));
         this._highlightCarousels = new Array();
         for each (hc in highlightCarousels) {
             this.sysApi.log(2, ("     - " + hc.name));
             this._highlightCarousels.push(hc);
         };
         this._currentCarouselArticleIndex = (int((Math.random() * this._highlightCarousels.length)) - 1);
         this.showHighlightCarouselArticle();
         this._carouselInterval = setInterval(this.showHighlightCarouselArticle, 10000);
         this.sysApi.log(2, ("   images " + highlightImages.length));
         this._highlightImages = new Array();
         for each (hi in highlightImages) {
             this.sysApi.log(2, ("     - " + hi.name));
             this._highlightImages.push(hi);
         };
         while (i < this._highlightImages.length) {
             this.showHighlightImage(this._highlightImages[i], i);
             i++;
         };
         this.ctr_frontDisplay.visible = true;
         this.ctr_articlesDisplay.visible = false;
      }
   }
}
