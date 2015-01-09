package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.UtilApi;
    import d2api.DataApi;
    import d2api.PlayedCharacterApi;
    import flash.utils.Dictionary;
    import d2data.DofusShopArticle;
    import __AS3__.vec.Vector;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.Texture;
    import d2components.Grid;
    import d2components.Input;
    import d2components.TextArea;
    import d2components.EntityDisplayer;
    import d2hooks.DofusShopHome;
    import d2hooks.DofusShopMoney;
    import d2hooks.DofusShopArticlesList;
    import d2hooks.DofusShopSuccessfulPurchase;
    import d2hooks.DofusShopError;
    import d2hooks.AccessoryPreview;
    import d2enums.ComponentHookList;
    import d2enums.ShortcutHookListEnum;
    import d2actions.ShopAuthentificationRequest;
    import flash.utils.clearInterval;
    import d2enums.DofusShopEnum;
    import d2actions.ShopArticlesListRequest;
    import d2actions.ShopFrontPageRequest;
    import d2data.DofusShopHighlight;
    import d2data.DofusShopCategory;
    import d2data.ItemWrapper;
    import d2data.EffectInstance;
    import d2data.Incarnation;
    import d2data.Emoticon;
    import d2data.Companion;
    import d2enums.DirectionsEnum;
    import d2actions.AccessoryPreviewRequest;
    import d2actions.ShopSearchRequest;
    import flash.utils.setInterval;
    import d2hooks.OpenSet;
    import d2enums.LocationEnum;
    import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
    import d2actions.ShopBuyRequest;
    import d2hooks.*;
    import d2actions.*;
    import __AS3__.vec.*;

    public class WebShop 
    {

        private static var CTR_CAT_TYPE_CAT:String = "ctr_cat";
        private static var CTR_CAT_TYPE_SUBCAT:String = "ctr_subCat";
        private static var CTR_CAT_TYPE_SUBSUBCAT:String = "ctr_subSubCat";
        private static var CURRENCY_OGRINES:int = 0;
        private static var CURRENCY_KROZS:int = 1;
        private static var ARTICLE_TYPE_ITEM:int = 0;
        private static var ARTICLE_TYPE_PACK:int = 1;
        private static var ARTICLE_TYPE_ITEM_FROM_PACK:int = 2;
        public static const RING_TYPE_ID:uint = 9;
        public static const AMULET_TYPE_ID:uint = 1;
        public static const BOOTS_TYPE_ID:uint = 11;
        public static const BELT_TYPE_ID:uint = 10;
        public static const SHIELD_TYPE_ID:uint = 82;
        public static const CLOAK_TYPE_ID:uint = 17;
        public static const BACKPACK_TYPE_ID:uint = 81;
        public static const HAT_TYPE_ID:uint = 16;
        public static const PET_TYPE_ID:uint = 18;
        public static const PETSMOUNT_TYPE_ID:uint = 121;
        public static const LIVINGITEM_TYPE_ID:uint = 113;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var utilApi:UtilApi;
        public var dataApi:DataApi;
        public var playerApi:PlayedCharacterApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _compHookData:Dictionary;
        private var _moneyOgr:int;
        private var _moneyKro:int;
        private var _currentCurrency:int = 0;
        private var _searchCriteria:String;
        private var _isOnSearch:Boolean = false;
        private var _categories:Array;
        private var _categoriesOpened:Array;
        private var _currentSelectedCatId:int;
        private var _highlightCarousels:Array;
        private var _currentCarouselArticleIndex:int;
        private var _carouselInterval:Number;
        private var _highlightImages:Array;
        private var _isOnFrontPage:Boolean = true;
        private var _currentPage:uint = 1;
        private var _maxPage:uint = 1;
        private var _selectedArticle:DofusShopArticle;
        private var _articleType:int;
        private var _direction:int = 3;
        private var _nbDirectionMax:int = 8;
        private var _animation:String;
        private var _currentGIDsPreview:Vector.<uint>;
        private var _currentPreviewLook:Object;
        private var _currentItemBuyName:String;
        private var _currencyUriOgr:Object;
        private var _currencyUriKro:Object;
        private var _goToArticleParams:Object;
        public var ctr_shop:GraphicContainer;
        public var btn_buyOgrins:ButtonContainer;
        public var lbl_money:Label;
        public var tx_money:Texture;
        public var gd_categories:Grid;
        public var inp_search:Input;
        public var tx_inputBg:Texture;
        public var btn_startSearch:ButtonContainer;
        public var btn_resetSearch:ButtonContainer;
        public var lbl_noResult:Label;
        public var ctr_frontDisplay:GraphicContainer;
        public var ctr_shopLoader:GraphicContainer;
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
        public var ctr_articlesDisplay:GraphicContainer;
        public var gd_articles:Grid;
        public var btn_prevPage:Object;
        public var btn_nextPage:Object;
        public var lbl_page:Object;
        public var ctr_articlesLoader:GraphicContainer;
        public var ctr_popupArticle:GraphicContainer;
        public var tx_popupBackground:Texture;
        public var btn_popupClose:ButtonContainer;
        public var ctr_popupItemWrapper:GraphicContainer;
        public var ctr_popupItemPack:GraphicContainer;
        public var lbl_popupPackName:Label;
        public var lbl_popupPackLevel:Label;
        public var lbl_popupPackDescription:TextArea;
        public var tx_popupPackImage:Texture;
        public var ctr_popupPackSetDetails:GraphicContainer;
        public var entityCtr:GraphicContainer;
        public var ed_popupChar:EntityDisplayer;
        public var btn_popupReplay:ButtonContainer;
        public var btn_popupRightArrow:ButtonContainer;
        public var btn_popupLeftArrow:ButtonContainer;
        public var ctr_popupSetItems:GraphicContainer;
        public var gd_setItems:Grid;
        public var ctr_popupPrice:GraphicContainer;
        public var ctr_popupOldPrice:GraphicContainer;
        public var lbl_popupOldPrice:Label;
        public var lbl_popupPrice:Label;
        public var tx_popupCurrency:Texture;
        public var tx_popupOldCurrency:Texture;
        public var btn_popupBuy:ButtonContainer;

        public function WebShop()
        {
            this._compHookData = new Dictionary(true);
            this._categories = new Array();
            this._categoriesOpened = new Array();
            this._highlightCarousels = new Array();
            this._highlightImages = new Array();
            this._currentGIDsPreview = new Vector.<uint>();
            super();
        }

        public function main(oParam:Object=null):void
        {
            this.sysApi.addHook(DofusShopHome, this.onDofusShopHome);
            this.sysApi.addHook(DofusShopMoney, this.onDofusShopMoney);
            this.sysApi.addHook(DofusShopArticlesList, this.onDofusShopArticlesList);
            this.sysApi.addHook(DofusShopSuccessfulPurchase, this.onDofusShopSuccessfulPurchase);
            this.sysApi.addHook(DofusShopError, this.onDofusShopError);
            this.sysApi.addHook(AccessoryPreview, this.onAccessoryPreview);
            this.uiApi.addComponentHook(this.gd_categories, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.gd_articles, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.gd_frontDisplayArticles, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.btn_buyOgrins, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_buyOgrins, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_buyOgrins, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_startSearch, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_startSearch, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_resetSearch, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_resetSearch, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_highlightImage0, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.tx_highlightImage1, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ctr_carousel, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ctr_carouselLeft, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_carouselLeft, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_carouselLeft, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ctr_carouselRight, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_carouselRight, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_carouselRight, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_carouselNextPage, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_carouselNextPage, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_carouselPrevPage, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_carouselPrevPage, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_popupReplay, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_popupReplay, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.gd_setItems, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.gd_setItems, ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addComponentHook(this.gd_setItems, ComponentHookList.ON_ITEM_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_popupPackImage, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ctr_popupPackSetDetails, ComponentHookList.ON_RELEASE);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI, this.onShortcut);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortcut);
            this.ctr_frontDisplay.visible = true;
            this.ctr_articlesDisplay.visible = false;
            this.ctr_carouselLeft.handCursor = true;
            this.ctr_carouselRight.handCursor = true;
            this._currencyUriOgr = this.uiApi.createUri(this.uiApi.me().getConstant("ogr_uri"));
            this._currencyUriKro = this.uiApi.createUri(this.uiApi.me().getConstant("kro_uri"));
            if (((oParam) && (oParam.hasOwnProperty("articleId"))))
            {
                this._goToArticleParams = {
                    "categoryId":oParam.categoryId,
                    "page":oParam.page,
                    "articleId":oParam.articleId
                };
            };
            if (((oParam) && (oParam.hasOwnProperty("frontDisplayMains"))))
            {
                this._moneyOgr = oParam.ogrins;
                this._moneyKro = oParam.krozs;
                this.refreshMoney();
                this.onDofusShopHome(oParam.categories, oParam.frontDisplayArticles, oParam.frontDisplayMains, oParam.highlightCarousels, oParam.highlightImages);
            }
            else
            {
                this.sysApi.sendAction(new ShopAuthentificationRequest());
            };
        }

        public function unload():void
        {
            clearInterval(this._carouselInterval);
            this.uiApi.unloadUi("itemBoxPop");
        }

        public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint):void
        {
            switch (this.getCatLineType(data, line))
            {
                case CTR_CAT_TYPE_CAT:
                case CTR_CAT_TYPE_SUBCAT:
                case CTR_CAT_TYPE_SUBSUBCAT:
                    componentsRef.lbl_catName.text = data.name;
                    componentsRef.btn_cat.selected = selected;
                    break;
            };
        }

        public function getCatLineType(data:*, line:uint):String
        {
            if (!(data))
            {
                return ("");
            };
            switch (line)
            {
                case 0:
                    if (((data) && ((data.level == 0))))
                    {
                        return (CTR_CAT_TYPE_CAT);
                    };
                    if (((data) && ((data.level == 1))))
                    {
                        return (CTR_CAT_TYPE_SUBCAT);
                    };
                    return (CTR_CAT_TYPE_SUBSUBCAT);
                default:
                    return (CTR_CAT_TYPE_SUBCAT);
            };
        }

        public function getCatDataLength(data:*, selected:Boolean)
        {
            if (selected)
            {
                trace(((data.title + " : ") + (2 + ((selected) ? data.subcats.length : 0))));
            };
            return ((2 + ((selected) ? data.subcats.length : 0)));
        }

        public function updateArticle(data:*, components:*, selected:Boolean):void
        {
            if (!(this._compHookData[components.btn_buy.name]))
            {
                this.uiApi.addComponentHook(components.btn_buy, ComponentHookList.ON_RELEASE);
                this.uiApi.addComponentHook(components.btn_buy, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.btn_buy, ComponentHookList.ON_ROLL_OUT);
            };
            this._compHookData[components.btn_buy.name] = data;
            if (!(this._compHookData[components.btn_article.name]))
            {
                this.uiApi.addComponentHook(components.btn_article, ComponentHookList.ON_RELEASE);
            };
            this._compHookData[components.btn_article.name] = data;
            if (!(this._compHookData[components.ctr_article.name]))
            {
                this.uiApi.addComponentHook(components.ctr_article, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(components.ctr_article, ComponentHookList.ON_ROLL_OUT);
            };
            this._compHookData[components.ctr_article.name] = data;
            if (data)
            {
                components.lbl_name.text = data.name;
                components.lbl_price.text = this.utilApi.kamasToString(data.price, "");
                if (data.imageSwf)
                {
                    components.tx_picto.uri = data.imageSwf;
                }
                else
                {
                    if (((data.imageNormal) && ((data.imageNormal.length > 0))))
                    {
                        components.tx_picto.uri = this.uiApi.createUri(data.imageNormal);
                    }
                    else
                    {
                        if (((data.imageSmall) && ((data.imageSmall.length > 0))))
                        {
                            components.tx_picto.uri = this.uiApi.createUri(data.imageSmall);
                        };
                    };
                };
                if (((((data.isNew) || ((data.originalPrice > 0)))) || ((data.stock == 0))))
                {
                    components.tx_banner.visible = true;
                    if (data.stock == 0)
                    {
                        components.lbl_banner.text = this.uiApi.getText("ui.shop.soldOut");
                        components.tx_banner.gotoAndStop = 3;
                        components.btn_article.disabled = true;
                        components.btn_buy.disabled = true;
                    }
                    else
                    {
                        components.btn_article.disabled = false;
                        components.btn_buy.disabled = false;
                        if (data.originalPrice > 0)
                        {
                            components.lbl_banner.text = this.uiApi.getText("ui.shop.sales");
                            components.tx_banner.gotoAndStop = 2;
                        }
                        else
                        {
                            if (data.isNew)
                            {
                                components.lbl_banner.text = this.uiApi.getText("ui.common.new");
                                components.tx_banner.gotoAndStop = 1;
                            };
                        };
                    };
                }
                else
                {
                    components.tx_banner.visible = false;
                    components.lbl_banner.text = "";
                    components.btn_article.disabled = false;
                    components.btn_buy.disabled = false;
                };
                if (data.currency == DofusShopEnum.CURRENCY_OGRINES)
                {
                    components.tx_currency.uri = this._currencyUriOgr;
                }
                else
                {
                    if (data.currency == DofusShopEnum.CURRENCY_KROZ)
                    {
                        components.tx_currency.uri = this._currencyUriKro;
                    };
                };
                components.btn_buy.visible = true;
                components.ctr_article.alpha = 1;
            }
            else
            {
                components.lbl_name.text = "";
                components.lbl_price.text = "";
                components.tx_picto.uri = null;
                components.tx_currency.uri = null;
                components.tx_banner.visible = false;
                components.lbl_banner.text = "";
                components.btn_article.disabled = false;
                components.btn_buy.visible = false;
                components.ctr_article.alpha = 0.5;
            };
        }

        public function onPopupClose():void
        {
            this._currentItemBuyName = null;
        }

        private function refreshMoney():void
        {
            if (this._currentCurrency == CURRENCY_OGRINES)
            {
                this.lbl_money.text = this.utilApi.kamasToString(this._moneyOgr, "");
                this.btn_buyOgrins.visible = true;
                this.tx_money.uri = this._currencyUriOgr;
            }
            else
            {
                this.lbl_money.text = this.utilApi.kamasToString(this._moneyKro, "");
                this.btn_buyOgrins.visible = false;
                this.tx_money.uri = this._currencyUriKro;
            };
        }

        private function displayCategories(selectedCategory:Object=null, forceOpen:Boolean=false):void
        {
            var myIndex:int;
            var cat:Object;
            var parentId:int;
            var cat2:Object;
            var subcat:Object;
            var subsubcat:Object;
            if (!(selectedCategory))
            {
                selectedCategory = this.gd_categories.selectedItem;
            };
            if ((((selectedCategory.id == 342)) && (!((this._currentSelectedCatId == 342)))))
            {
                this._currentCurrency = CURRENCY_KROZS;
                this.refreshMoney();
            };
            if (((!((selectedCategory.id == 342))) && ((this._currentSelectedCatId == 342))))
            {
                this._currentCurrency = CURRENCY_OGRINES;
                this.refreshMoney();
            };
            var refreshCats:Boolean;
            if (this._categoriesOpened.indexOf(selectedCategory.id) == -1)
            {
                refreshCats = true;
            };
            if ((((selectedCategory.parentIds.length > 0)) && ((this._categoriesOpened.length > 0))))
            {
                for each (parentId in selectedCategory.parentIds)
                {
                    if (this._categoriesOpened.indexOf(parentId) == -1)
                    {
                        refreshCats = true;
                        break;
                    };
                };
            };
            if (!(refreshCats))
            {
                this._currentSelectedCatId = selectedCategory.id;
                for each (cat2 in this.gd_categories.dataProvider)
                {
                    if (cat2.id == this._currentSelectedCatId)
                    {
                        break;
                    };
                    myIndex++;
                };
                if (this.gd_categories.selectedIndex != myIndex)
                {
                    this.gd_categories.silent = true;
                    this.gd_categories.selectedIndex = myIndex;
                    this.gd_categories.silent = false;
                };
                if (this._currentSelectedCatId != 327)
                {
                    this._currentPage = ((this._goToArticleParams) ? this._goToArticleParams.page : 1);
                    this.sysApi.sendAction(new ShopArticlesListRequest(this._currentSelectedCatId, this._currentPage));
                    this.manageWaiting();
                };
                if (this._categoriesOpened.indexOf(selectedCategory.id) == -1)
                {
                    return;
                };
            };
            var index:int = -1;
            var tempCats:Array = new Array();
            var categoriesOpened:Array = new Array();
            for each (cat in this._categories)
            {
                tempCats.push(cat);
                index++;
                if (((!((selectedCategory.parentIds.indexOf(cat.id) == -1))) || ((selectedCategory.id == cat.id))))
                {
                    myIndex = index;
                    if ((((this._categoriesOpened.indexOf(cat.id) == -1)) || ((cat.id == 327))))
                    {
                        categoriesOpened.push(cat.id);
                        for each (subcat in cat.subcats)
                        {
                            tempCats.push(subcat);
                            index++;
                            if (((!((selectedCategory.parentIds.indexOf(subcat.id) == -1))) || ((selectedCategory.id == subcat.id))))
                            {
                                myIndex = index;
                                if (this._categoriesOpened.indexOf(subcat.id) == -1)
                                {
                                    categoriesOpened.push(cat.id);
                                    for each (subsubcat in subcat.subcats)
                                    {
                                        tempCats.push(subsubcat);
                                        index++;
                                        if (subsubcat.id == selectedCategory.id)
                                        {
                                            myIndex = index;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (categoriesOpened.length > 0)
            {
                this._categoriesOpened = categoriesOpened;
            }
            else
            {
                this._categoriesOpened = new Array();
            };
            this._currentSelectedCatId = selectedCategory.id;
            this.gd_categories.dataProvider = tempCats;
            if (this.gd_categories.selectedIndex != myIndex)
            {
                this.gd_categories.silent = true;
                this.gd_categories.selectedIndex = myIndex;
                this.gd_categories.silent = false;
            };
            if (this._currentSelectedCatId == 327)
            {
                if (!(this._isOnFrontPage))
                {
                    this.sysApi.sendAction(new ShopFrontPageRequest());
                    this._isOnSearch = false;
                };
            }
            else
            {
                this._currentPage = ((this._goToArticleParams) ? this._goToArticleParams.page : 1);
                this.sysApi.sendAction(new ShopArticlesListRequest(this._currentSelectedCatId, this._currentPage));
                this.manageWaiting();
            };
        }

        private function showHighlightCarouselArticle(increase:Boolean=true):void
        {
            var dsa:DofusShopArticle;
            if (!(this._isOnFrontPage))
            {
                return;
            };
            if (increase)
            {
                this._currentCarouselArticleIndex++;
            }
            else
            {
                this._currentCarouselArticleIndex = (--this._currentCarouselArticleIndex + this._highlightCarousels.length);
            };
            if ((((this._currentCarouselArticleIndex >= this._highlightCarousels.length)) || ((this._currentCarouselArticleIndex < 0))))
            {
                this._currentCarouselArticleIndex = (this._currentCarouselArticleIndex % this._highlightCarousels.length);
            };
            var highlight:DofusShopHighlight = this._highlightCarousels[this._currentCarouselArticleIndex];
            if (!(highlight))
            {
                return;
            };
            this.tx_carousel.uri = this.uiApi.createUri(highlight.image);
            this.lbl_carouselTitle.text = highlight.name;
            this.lbl_carouselDesc.text = highlight.description;
            if (highlight.type == DofusShopEnum.HIGHLIGHT_TYPE_ARTICLE)
            {
                dsa = (highlight.external as DofusShopArticle);
                if (dsa)
                {
                    this.lbl_carouselPrice.text = this.utilApi.kamasToString(dsa.price, "");
                    this.btn_carouselBuy.visible = true;
                    this.tx_carouselCurrency.visible = true;
                    if (dsa.currency == DofusShopEnum.CURRENCY_OGRINES)
                    {
                        this.tx_carouselCurrency.uri = this._currencyUriOgr;
                    }
                    else
                    {
                        this.tx_carouselCurrency.uri = this._currencyUriKro;
                    };
                };
            }
            else
            {
                this.lbl_carouselPrice.text = "";
                this.btn_carouselBuy.visible = false;
                this.tx_carouselCurrency.visible = false;
            };
        }

        private function showHighlightImage(image:DofusShopHighlight, slotId:int):void
        {
            if (!(this._isOnFrontPage))
            {
                return;
            };
            if (((this[("tx_highlightImage" + slotId)]) && (image)))
            {
                this[("tx_highlightImage" + slotId)].uri = this.uiApi.createUri(image.image);
            };
        }

        private function releaseOnHighlight(highlight:DofusShopHighlight):void
        {
            var cat:DofusShopCategory;
            var customCatToOpen:Object;
            var c:Object;
            var c2:Object;
            if (((!(this._isOnFrontPage)) || (!(highlight))))
            {
                return;
            };
            if (((highlight.link) && (!((highlight.link == "")))))
            {
                this.sysApi.goToUrl(highlight.link);
            }
            else
            {
                if (highlight.type == DofusShopEnum.HIGHLIGHT_TYPE_CATEGORY)
                {
                    cat = (highlight.external as DofusShopCategory);
                    for each (c in this._categories)
                    {
                        if (c.id == cat.id)
                        {
                            customCatToOpen = c;
                        }
                        else
                        {
                            for each (c2 in c.subcats)
                            {
                                if (c2.id == cat.id)
                                {
                                    customCatToOpen = c2;
                                };
                            };
                        };
                    };
                    this.displayCategories(customCatToOpen, true);
                }
                else
                {
                    if (highlight.type == DofusShopEnum.HIGHLIGHT_TYPE_ARTICLE)
                    {
                        this._selectedArticle = (highlight.external as DofusShopArticle);
                        this.displayArticle();
                    };
                };
            };
        }

        private function refreshPageNumber():void
        {
            if (this._currentPage <= 1)
            {
                this.btn_prevPage.disabled = true;
            }
            else
            {
                this.btn_prevPage.disabled = false;
            };
            if (this._currentPage >= this._maxPage)
            {
                this.btn_nextPage.disabled = true;
            }
            else
            {
                this.btn_nextPage.disabled = false;
            };
            this.lbl_page.text = ((this._currentPage + "/") + this._maxPage);
        }

        private function displayArticle(item:ItemWrapper=null):void
        {
            var itemw:ItemWrapper;
            var incarnationId:int;
            var emoteId:int;
            var sidekickId:int;
            var effect:EffectInstance;
            var incarnation:Incarnation;
            var emoticon:Emoticon;
            var animName:String;
            var sidekick:Companion;
            var setItems:Array;
            var ref:Object;
            var content:Object;
            var iw:ItemWrapper;
            var hardLook:String;
            var thisIsASet:Boolean;
            var level:int;
            var articleItemSetId:int;
            var iws:ItemWrapper;
            var effectS:EffectInstance;
            var incarnationS:Incarnation;
            var requestPreview:Boolean;
            var index:*;
            var gid:uint;
            if (((!(this._selectedArticle)) && (!(item))))
            {
                this.sysApi.log(32, " Aucun objet selectionné !");
                return;
            };
            var gidsToPreview:Vector.<uint> = new Vector.<uint>();
            this._animation = "";
            this._nbDirectionMax = 8;
            if (item)
            {
                itemw = item;
                this.modCommon.createItemBox("itemBoxPop", this.ctr_popupItemWrapper, itemw);
                this.ctr_popupItemWrapper.visible = true;
                this.ctr_popupItemPack.visible = false;
                this._articleType = ARTICLE_TYPE_ITEM_FROM_PACK;
            }
            else
            {
                if (((((this._selectedArticle.gids) && ((this._selectedArticle.gids.length == 1)))) && (!((this._selectedArticle.gids[0] == 7805)))))
                {
                    itemw = this.dataApi.getItemWrapper(this._selectedArticle.gids[0], 0, 0, 1);
                    if (itemw)
                    {
                        this.modCommon.createItemBox("itemBoxPop", this.ctr_popupItemWrapper, itemw);
                    }
                    else
                    {
                        this.sysApi.log(32, (("L'item " + this._selectedArticle.gids[0]) + " ne semble pas exister !"));
                    };
                    this.ctr_popupItemWrapper.visible = true;
                    this.ctr_popupItemPack.visible = false;
                    this._articleType = ARTICLE_TYPE_ITEM;
                }
                else
                {
                    this.lbl_popupPackName.text = this._selectedArticle.name;
                    this.lbl_popupPackDescription.text = this._selectedArticle.description;
                    this.tx_popupPackImage.uri = this.uiApi.createUri(this._selectedArticle.imageNormal);
                    this.ctr_popupItemWrapper.visible = false;
                    this.ctr_popupItemPack.visible = true;
                    this._articleType = ARTICLE_TYPE_PACK;
                };
            };
            var look:Object = this.utilApi.getRealTiphonEntityLook(this.playerApi.getPlayedCharacterInfo().id, true);
            if (look.getBone() == 2)
            {
                look.setBone(1);
            };
            if ((((((this._articleType == ARTICLE_TYPE_ITEM)) || ((this._articleType == ARTICLE_TYPE_ITEM_FROM_PACK)))) && (itemw)))
            {
                incarnationId = -1;
                emoteId = -1;
                sidekickId = -1;
                for each (effect in itemw.possibleEffects)
                {
                    if (effect.effectId == 669)
                    {
                        incarnationId = int(effect.parameter0);
                        break;
                    };
                    if (effect.effectId == 10)
                    {
                        emoteId = int(effect.parameter0);
                        break;
                    };
                    if (effect.effectId == 1161)
                    {
                        sidekickId = int(effect.parameter2);
                        break;
                    };
                };
                if (incarnationId > -1)
                {
                    incarnation = this.dataApi.getIncarnation(incarnationId);
                    if (incarnation)
                    {
                        if (this.playerApi.getPlayedCharacterInfo().sex == 1)
                        {
                            look = incarnation.lookFemale;
                        }
                        else
                        {
                            look = incarnation.lookMale;
                        };
                        this._nbDirectionMax = 4;
                    };
                }
                else
                {
                    if (emoteId > -1)
                    {
                        emoticon = this.dataApi.getEmoticon(emoteId);
                        if (emoticon)
                        {
                            animName = ((("AnimEmote" + emoticon.defaultAnim.charAt(0).toUpperCase()) + emoticon.defaultAnim.substr(1).toLowerCase()) + "_0");
                            this._animation = animName;
                        };
                    }
                    else
                    {
                        if (sidekickId > -1)
                        {
                            sidekick = this.dataApi.getCompanion(sidekickId);
                            if (sidekick)
                            {
                                look = sidekick.look;
                                this._nbDirectionMax = 4;
                            };
                        }
                        else
                        {
                            if (itemw.isWeapon)
                            {
                                gidsToPreview.push(itemw.objectGID);
                                this._animation = "AnimEmoteWeap_0";
                            }
                            else
                            {
                                switch (itemw.typeId)
                                {
                                    case HAT_TYPE_ID:
                                    case CLOAK_TYPE_ID:
                                    case BACKPACK_TYPE_ID:
                                    case SHIELD_TYPE_ID:
                                    case PET_TYPE_ID:
                                    case PETSMOUNT_TYPE_ID:
                                        gidsToPreview.push(itemw.objectGID);
                                        break;
                                };
                            };
                        };
                    };
                };
            };
            if ((((this._articleType == ARTICLE_TYPE_ITEM_FROM_PACK)) || ((this._articleType == ARTICLE_TYPE_PACK))))
            {
                setItems = new Array();
                for each (ref in this._selectedArticle.references)
                {
                    if (((ref) && (ref.content)))
                    {
                        for each (content in ref.content)
                        {
                            if (((((content) && ((typeof(content) == "object")))) && (content.hasOwnProperty("id"))))
                            {
                                iw = this.dataApi.getItemWrapper(parseInt(content.id), 0, 0, ref.quantity);
                                setItems.push(iw);
                                if ((((iw.category == 0)) && ((this._articleType == ARTICLE_TYPE_PACK))))
                                {
                                    gidsToPreview.push(iw.objectGID);
                                    if (iw.isWeapon)
                                    {
                                        this._animation = "AnimEmoteWeap_0";
                                    };
                                }
                                else
                                {
                                    if (iw.objectGID == 7805)
                                    {
                                        hardLook = look.toString();
                                        if (hardLook.indexOf("@") > -1)
                                        {
                                            hardLook = (hardLook.split("@")[0] + "}");
                                        };
                                        look = hardLook.replace("{1|", (((((("{639||1=" + look.getColor(3).color) + ",2=") + look.getColor(4).color) + ",3=") + look.getColor(5).color) + "|120|2@0={2|"));
                                        look = (look + "}");
                                    };
                                };
                            };
                        };
                    };
                };
                if (this._articleType == ARTICLE_TYPE_PACK)
                {
                    thisIsASet = true;
                    level = 0;
                    articleItemSetId = -1;
                    for each (iws in setItems)
                    {
                        if (!(iws))
                        {
                        }
                        else
                        {
                            if (iws.level > level)
                            {
                                level = iws.level;
                            };
                            if (((!(iws.belongsToSet)) || (((!((iws.itemSetId == articleItemSetId))) && ((articleItemSetId > -1))))))
                            {
                                thisIsASet = false;
                            }
                            else
                            {
                                articleItemSetId = iws.itemSetId;
                            };
                            for each (effectS in iws.possibleEffects)
                            {
                                if (effectS.effectId == 669)
                                {
                                    incarnationS = this.dataApi.getIncarnation(int(effectS.parameter0));
                                    if (incarnationS)
                                    {
                                        gidsToPreview = new Vector.<uint>();
                                        if (this.playerApi.getPlayedCharacterInfo().sex == 1)
                                        {
                                            look = incarnationS.lookFemale;
                                        }
                                        else
                                        {
                                            look = incarnationS.lookMale;
                                        };
                                        this._nbDirectionMax = 4;
                                    };
                                };
                            };
                        };
                    };
                    this.lbl_popupPackLevel.text = ((this.uiApi.getText("ui.common.short.level") + " ") + level);
                    if (thisIsASet)
                    {
                        this.ctr_popupPackSetDetails.visible = true;
                    }
                    else
                    {
                        this.ctr_popupPackSetDetails.visible = false;
                    };
                };
                this.ctr_popupSetItems.visible = true;
                this.gd_setItems.width = ((setItems.length * 48) + 2);
                this.gd_setItems.dataProvider = setItems;
                this.ctr_popupPrice.y = ((this.ctr_popupSetItems.y + this.ctr_popupSetItems.height) + 15);
                this.tx_popupBackground.height = ((415 + this.ctr_popupSetItems.height) + 25);
                this.uiApi.me().render();
            }
            else
            {
                this.ctr_popupSetItems.visible = false;
                this.ctr_popupPrice.y = this.ctr_popupSetItems.y;
                this.tx_popupBackground.height = 415;
                this.uiApi.me().render();
            };
            var previousX:Number = this.ed_popupChar.x;
            var previousY:Number = this.ed_popupChar.y;
            var previousW:Number = this.ed_popupChar.width;
            var previousH:Number = this.ed_popupChar.height;
            this.uiApi.removeComponentHook(this.ed_popupChar, "onEntityReady");
            this.ed_popupChar.removeFromParent();
            this.ed_popupChar.remove();
            this.ed_popupChar = (this.uiApi.createComponent("EntityDisplayer") as EntityDisplayer);
            this.ed_popupChar.useFade = false;
            this.ed_popupChar.clearSubEntities = false;
            this.ed_popupChar.x = previousX;
            this.ed_popupChar.y = previousY;
            this.ed_popupChar.width = previousW;
            this.ed_popupChar.height = previousH;
            this.uiApi.addChild(this.entityCtr, this.ed_popupChar);
            this.btn_popupReplay.visible = false;
            if (this._animation)
            {
                if ((((((((this._direction == DirectionsEnum.DIRECTION_EAST)) || ((this._direction == DirectionsEnum.DIRECTION_NORTH)))) || ((this._direction == DirectionsEnum.DIRECTION_SOUTH)))) || ((this._direction == DirectionsEnum.DIRECTION_WEST))))
                {
                    this._direction = ((this._direction + 1) % 8);
                };
                this.uiApi.addComponentHook(this.ed_popupChar, "onEntityReady");
            };
            this.ed_popupChar.direction = this._direction;
            if (((gidsToPreview) && ((gidsToPreview.length > 0))))
            {
                requestPreview = false;
                if (this._currentGIDsPreview.length == gidsToPreview.length)
                {
                    for (index in gidsToPreview)
                    {
                        if (this._currentGIDsPreview[index] != gidsToPreview[index])
                        {
                            requestPreview = true;
                            break;
                        };
                    };
                }
                else
                {
                    requestPreview = true;
                };
                if (requestPreview)
                {
                    this._currentGIDsPreview = new Vector.<uint>();
                    for each (gid in gidsToPreview)
                    {
                        this._currentGIDsPreview.push(gid);
                    };
                    this.sysApi.sendAction(new AccessoryPreviewRequest(gidsToPreview));
                }
                else
                {
                    this.onAccessoryPreview(this._currentPreviewLook);
                };
            }
            else
            {
                this.ed_popupChar.look = look;
                if (this._animation)
                {
                    this.btn_popupReplay.visible = true;
                };
            };
            this.lbl_popupPrice.text = this.utilApi.kamasToString(this._selectedArticle.price, "");
            if (this._selectedArticle.originalPrice == 0)
            {
                this.ctr_popupOldPrice.visible = false;
            }
            else
            {
                this.lbl_popupOldPrice.text = this.utilApi.kamasToString(this._selectedArticle.originalPrice, "");
                this.ctr_popupOldPrice.visible = true;
            };
            if (this._selectedArticle.currency == DofusShopEnum.CURRENCY_OGRINES)
            {
                this.tx_popupCurrency.uri = this._currencyUriOgr;
                this.tx_popupOldCurrency.uri = this._currencyUriOgr;
                if (this._selectedArticle.price > this._moneyOgr)
                {
                    this.btn_popupBuy.disabled = true;
                }
                else
                {
                    this.btn_popupBuy.disabled = false;
                };
            }
            else
            {
                if (this._selectedArticle.currency == DofusShopEnum.CURRENCY_KROZ)
                {
                    this.tx_popupCurrency.uri = this._currencyUriKro;
                    this.tx_popupOldCurrency.uri = this._currencyUriKro;
                    if (this._selectedArticle.price > this._moneyKro)
                    {
                        this.btn_popupBuy.disabled = true;
                    }
                    else
                    {
                        this.btn_popupBuy.disabled = false;
                    };
                };
            };
            this.ctr_popupArticle.visible = true;
        }

        public function onEntityReady(entity:*):void
        {
            this.uiApi.removeComponentHook(this.ed_popupChar, "onEntityReady");
            this.ed_popupChar.setAnimationAndDirection(this._animation, this._direction);
        }

        private function manageWaiting(visible:Boolean=true):void
        {
            this.ctr_articlesLoader.visible = visible;
            this.ctr_articlesLoader.mouseEnabled = visible;
        }

        private function wheelChara(sens:int):void
        {
            this._direction = (((this._direction + sens) + 8) % 8);
            if ((((this._nbDirectionMax == 4)) && (((this._direction % 2) == 0))))
            {
                this._direction = (((this._direction + sens) + 8) % 8);
            };
            this.ed_popupChar.direction = this._direction;
        }

        public function onRelease(target:Object):void
        {
            var _local_2:DofusShopHighlight;
            var _local_3:DofusShopHighlight;
            var _local_4:DofusShopHighlight;
            var _local_5:Object;
            var _local_6:Object;
            var text:String;
            var text2:String;
            switch (target)
            {
                case this.btn_resetSearch:
                    this._searchCriteria = null;
                    this.inp_search.text = "";
                    this._isOnSearch = false;
                    break;
                case this.btn_startSearch:
                    if (((!((this._searchCriteria == this.inp_search.text))) || (!((this._currentPage == 1)))))
                    {
                        this._currentPage = 1;
                        this._searchCriteria = this.inp_search.text;
                        this.sysApi.sendAction(new ShopSearchRequest(this._searchCriteria, 1));
                        this.manageWaiting();
                        this._isOnSearch = true;
                    };
                    break;
                case this.btn_nextPage:
                    if ((this._currentPage + 1) <= this._maxPage)
                    {
                        if (this._isOnSearch)
                        {
                            this.sysApi.sendAction(new ShopSearchRequest(this._searchCriteria, ++this._currentPage));
                        }
                        else
                        {
                            this.sysApi.sendAction(new ShopArticlesListRequest(this._currentSelectedCatId, ++this._currentPage));
                        };
                        this.manageWaiting();
                        this.refreshPageNumber();
                    };
                    break;
                case this.btn_prevPage:
                    if ((this._currentPage - 1) >= 0)
                    {
                        if (this._isOnSearch)
                        {
                            this.sysApi.sendAction(new ShopSearchRequest(this._searchCriteria, --this._currentPage));
                        }
                        else
                        {
                            this.sysApi.sendAction(new ShopArticlesListRequest(this._currentSelectedCatId, --this._currentPage));
                        };
                        this.manageWaiting();
                        this.refreshPageNumber();
                    };
                    break;
                case this.btn_buyOgrins:
                    this.sysApi.goToUrl(this.uiApi.getText("ui.link.buyOgrine"));
                    break;
                case this.ctr_carousel:
                    _local_2 = this._highlightCarousels[this._currentCarouselArticleIndex];
                    this.releaseOnHighlight(_local_2);
                    break;
                case this.tx_highlightImage0:
                    _local_3 = this._highlightImages[0];
                    this.releaseOnHighlight(_local_3);
                    break;
                case this.tx_highlightImage1:
                    _local_4 = this._highlightImages[1];
                    this.releaseOnHighlight(_local_4);
                    break;
                case this.btn_carouselBuy:
                    this._selectedArticle = this._highlightCarousels[this._currentCarouselArticleIndex].external;
                    this.displayArticle();
                    break;
                case this.btn_carouselNextPage:
                case this.ctr_carouselRight:
                    this.showHighlightCarouselArticle();
                    clearInterval(this._carouselInterval);
                    this._carouselInterval = setInterval(this.showHighlightCarouselArticle, 10000);
                    break;
                case this.btn_carouselPrevPage:
                case this.ctr_carouselLeft:
                    this.showHighlightCarouselArticle(false);
                    clearInterval(this._carouselInterval);
                    this._carouselInterval = setInterval(this.showHighlightCarouselArticle, 10000);
                    break;
                case this.btn_popupBuy:
                    if (!(this._currentItemBuyName))
                    {
                        this._currentItemBuyName = this._selectedArticle.name;
                        text = this.uiApi.getText("ui.shop.buyConfirm", this._selectedArticle.name, this.utilApi.kamasToString(this._selectedArticle.price, this._selectedArticle.currency));
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), text, [this.uiApi.getText("ui.common.ok"), this.uiApi.getText("ui.common.cancel")], [this.onPopupBuy, this.onPopupClose], this.onPopupBuy, this.onPopupClose);
                    };
                    break;
                case this.btn_popupClose:
                    this._selectedArticle = null;
                    this.ctr_popupArticle.visible = false;
                    break;
                case this.btn_popupReplay:
                    if (this._animation != "")
                    {
                        if ((((((((this._direction == DirectionsEnum.DIRECTION_EAST)) || ((this._direction == DirectionsEnum.DIRECTION_NORTH)))) || ((this._direction == DirectionsEnum.DIRECTION_SOUTH)))) || ((this._direction == DirectionsEnum.DIRECTION_WEST))))
                        {
                            this._direction = ((this._direction + 1) % 8);
                            this.ed_popupChar.direction = this._direction;
                        };
                        this.ed_popupChar.setAnimationAndDirection(this._animation, this._direction);
                    };
                    break;
                case this.btn_popupLeftArrow:
                    this.wheelChara(1);
                    break;
                case this.btn_popupRightArrow:
                    this.wheelChara(-1);
                    break;
                case this.tx_popupPackImage:
                    this.displayArticle();
                    break;
                case this.ctr_popupPackSetDetails:
                    if (this._articleType != ARTICLE_TYPE_PACK)
                    {
                        break;
                    };
                    _local_5 = this.dataApi.getItemWrapper(this._selectedArticle.gids[0], 0, 0, 1);
                    this.sysApi.dispatchHook(OpenSet, _local_5);
                    break;
                default:
                    if (target.name.indexOf("btn_buy") != -1)
                    {
                        _local_6 = this._compHookData[target.name];
                        if (!(this._currentItemBuyName))
                        {
                            this._currentItemBuyName = _local_6.name;
                            this._selectedArticle = (_local_6 as DofusShopArticle);
                            text2 = this.uiApi.getText("ui.shop.buyConfirm", _local_6.name, this.utilApi.kamasToString(_local_6.price, _local_6.currency));
                            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), text2, [this.uiApi.getText("ui.common.ok"), this.uiApi.getText("ui.common.cancel")], [this.onPopupBuy, this.onPopupClose], this.onPopupBuy, this.onPopupClose);
                        };
                    }
                    else
                    {
                        if (target.name.indexOf("btn_article") != -1)
                        {
                            if (this._selectedArticle == this._compHookData[target.name])
                            {
                                this._selectedArticle = null;
                                this.ctr_popupArticle.visible = false;
                            }
                            else
                            {
                                this._selectedArticle = this._compHookData[target.name];
                                this.displayArticle();
                            };
                        };
                    };
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            switch (target)
            {
                case this.btn_buyOgrins:
                    text = this.uiApi.getText("ui.shop.buyOgrines");
                    break;
                case this.btn_startSearch:
                    text = this.uiApi.getText("ui.search.launch");
                    break;
                case this.btn_resetSearch:
                    text = this.uiApi.getText("ui.search.clear");
                    break;
                case this.btn_popupReplay:
                    text = this.uiApi.getText("ui.shop.replayEmote");
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
                default:
                    if (target.name.indexOf("btn_buy") != -1)
                    {
                        text = this.uiApi.getText("ui.common.buy");
                    }
                    else
                    {
                        if (target.name.indexOf("ctr_article") != -1)
                        {
                            (this.uiApi.getUi(this.uiApi.me().name).getElement(target.name.replace("ctr_article", "tx_bg")) as Texture).gotoAndStop = 2;
                        };
                    };
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            if ((((((target == this.ctr_carouselRight)) || ((target == this.ctr_carouselLeft)))) && (((!((target == this.btn_carouselNextPage))) && (!((target == this.btn_carouselPrevPage)))))))
            {
                this.ctr_carouselRight.bgAlpha = 0;
                this.ctr_carouselLeft.bgAlpha = 0;
                this.btn_carouselNextPage.visible = false;
                this.btn_carouselPrevPage.visible = false;
            }
            else
            {
                if (target.name.indexOf("ctr_article") != -1)
                {
                    (this.uiApi.getUi(this.uiApi.me().name).getElement(target.name.replace("ctr_article", "tx_bg")) as Texture).gotoAndStop = 1;
                }
                else
                {
                    this.uiApi.hideTooltip();
                };
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (selectMethod != GridItemSelectMethodEnum.AUTO)
            {
                if (target == this.gd_categories)
                {
                    this._searchCriteria = null;
                    this.inp_search.text = "";
                    this._isOnSearch = false;
                    this.displayCategories(target.selectedItem);
                }
                else
                {
                    if (target == this.gd_setItems)
                    {
                        this.displayArticle(target.selectedItem);
                    };
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
        }

        public function onShortcut(s:String):Boolean
        {
            if ((((s == ShortcutHookListEnum.VALID_UI)) && (this.inp_search.haveFocus)))
            {
                if (((!((this._searchCriteria == this.inp_search.text))) || (!((this._currentPage == 1)))))
                {
                    this._currentPage = 1;
                    this._searchCriteria = this.inp_search.text;
                    this.sysApi.sendAction(new ShopSearchRequest(this._searchCriteria, 1));
                    this.manageWaiting();
                    this._isOnSearch = true;
                };
                return (true);
            };
            if ((((s == ShortcutHookListEnum.CLOSE_UI)) && (this.ctr_popupArticle.visible)))
            {
                this.ctr_popupArticle.visible = false;
                return (true);
            };
            return (false);
        }

        private function onPopupBuy():void
        {
            this.sysApi.sendAction(new ShopBuyRequest(this._selectedArticle.id, 1));
        }

        private function onAccessoryPreview(look:Object):void
        {
            if (look)
            {
                this._currentPreviewLook = look;
                if (this._animation != "")
                {
                    this.btn_popupReplay.visible = true;
                };
            }
            else
            {
                look = this.utilApi.getRealTiphonEntityLook(this.playerApi.getPlayedCharacterInfo().id, true);
                if (look.getBone() == 2)
                {
                    look.setBone(1);
                };
            };
            this.ed_popupChar.look = look;
        }

        private function onDofusShopArticlesList(articles:Object, totalPages:uint):void
        {
            var articlesToDisplay:Array;
            var a:DofusShopArticle;
            var article:*;
            clearInterval(this._carouselInterval);
            this._isOnFrontPage = false;
            this._maxPage = totalPages;
            if (articles.length == 0)
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
                for each (a in articles)
                {
                    articlesToDisplay.push(a);
                };
                this.gd_articles.dataProvider = articlesToDisplay;
                this.gd_articles.visible = true;
                this.lbl_noResult.visible = false;
            };
            this.ctr_frontDisplay.visible = false;
            this.ctr_articlesDisplay.visible = true;
            this.manageWaiting(false);
            if (this._goToArticleParams)
            {
                for each (article in articles)
                {
                    if (article.id == this._goToArticleParams.articleId)
                    {
                        this._selectedArticle = article;
                        this.displayArticle();
                        this._goToArticleParams = null;
                        break;
                    };
                };
            };
        }

        private function onDofusShopSuccessfulPurchase(articleId:int):void
        {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.information"), this.uiApi.getText("ui.shop.successfulPurchase", this._currentItemBuyName), [this.uiApi.getText("ui.common.ok")]);
            this._currentItemBuyName = null;
        }

        private function onDofusShopError(errorId:String):void
        {
            var text:String;
            switch (("error_" + errorId))
            {
                case DofusShopEnum.ERROR_PURCHASE_FAILED:
                    text = this.uiApi.getText("ui.shop.purchaseFailed");
                    this._currentItemBuyName = null;
                    break;
                case DofusShopEnum.ERROR_PURCHASE_NO_MONEY:
                    text = this.uiApi.getText("ui.shop.purchaseNoMoney");
                    this._currentItemBuyName = null;
                    break;
                case DofusShopEnum.ERROR_PURCHASE_NO_STOCK:
                    text = this.uiApi.getText("ui.shop.purchaseNoStock");
                    this._currentItemBuyName = null;
                    break;
                case DofusShopEnum.ERROR_PURCHASE_REQUEST_TIMED_OUT:
                    text = this.uiApi.getText("ui.shop.purchaseTimedOut");
                    this._currentItemBuyName = null;
                    break;
                case DofusShopEnum.ERROR_REQUEST_TIMED_OUT:
                    text = this.uiApi.getText("ui.shop.errorTimedOut");
                    break;
                case DofusShopEnum.ERROR_AUTHENTICATION_FAILED:
                    text = this.uiApi.getText("ui.shop.errorAuthentication");
                    break;
                default:
                    text = this.uiApi.getText("ui.shop.error");
            };
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), text, [this.uiApi.getText("ui.common.ok")]);
        }

        private function onDofusShopMoney(ogrins:int, krozs:int):void
        {
            this._moneyOgr = ogrins;
            this._moneyKro = krozs;
            this.refreshMoney();
        }

        private function onDofusShopHome(categories:Object, frontDisplayArticles:Object, frontDisplayMains:Object, highlightCarousels:Object, highlightImages:Object):void
        {
            var c:DofusShopCategory;
            var articlesToDisplay:Array;
            var a:DofusShopArticle;
            var hc:DofusShopHighlight;
            var hi:DofusShopHighlight;
            var i:int;
            var c2:DofusShopCategory;
            var c3:DofusShopCategory;
            var foundCategory:Object;
            var dc:*;
            var dc2:*;
            var dc3:*;
            this._isOnFrontPage = true;
            this._categories = new Array();
            var childrens:Array = new Array();
            var subchildrens:Array = new Array();
            for each (c in categories)
            {
                childrens[c.id] = new Array();
                for each (c2 in c.children)
                {
                    subchildrens[c2.id] = new Array();
                    for each (c3 in c2.children)
                    {
                        subchildrens[c2.id].push({
                            "id":c3.id,
                            "name":c3.name,
                            "desc":c3.description,
                            "img":c3.image,
                            "parentIds":[c2.id, c.id],
                            "subcats":new Array()
                        });
                    };
                    childrens[c.id].push({
                        "id":c2.id,
                        "name":c2.name,
                        "desc":c2.description,
                        "img":c2.image,
                        "parentIds":[c.id],
                        "level":1,
                        "subcats":subchildrens[c2.id]
                    });
                };
                this._categories.push({
                    "id":c.id,
                    "name":c.name,
                    "desc":c.description,
                    "img":c.image,
                    "parentIds":new Array(),
                    "level":0,
                    "subcats":childrens[c.id]
                });
            };
            this.gd_categories.dataProvider = this._categories;
            this.gd_categories.selectedIndex = 0;
            articlesToDisplay = new Array();
            for each (a in frontDisplayArticles)
            {
                articlesToDisplay.push(a);
            };
            this.gd_frontDisplayArticles.dataProvider = articlesToDisplay;
            this._highlightCarousels = new Array();
            for each (hc in highlightCarousels)
            {
                this._highlightCarousels.push(hc);
            };
            this._currentCarouselArticleIndex = (int((Math.random() * this._highlightCarousels.length)) - 1);
            this.showHighlightCarouselArticle();
            this._carouselInterval = setInterval(this.showHighlightCarouselArticle, 10000);
            this._highlightImages = new Array();
            for each (hi in highlightImages)
            {
                this._highlightImages.push(hi);
            };
            while (i < this._highlightImages.length)
            {
                this.showHighlightImage(this._highlightImages[i], i);
                i++;
            };
            this.ctr_frontDisplay.visible = true;
            this.ctr_articlesDisplay.visible = false;
            this.ctr_shopLoader.visible = false;
            this.ctr_shopLoader.mouseEnabled = false;
            if (this._goToArticleParams)
            {
                for each (dc in this._categories)
                {
                    if (dc.id == this._goToArticleParams.categoryId)
                    {
                        foundCategory = dc;
                    };
                    if (foundCategory)
                    {
                        break;
                    };
                    for each (dc2 in dc.subcats)
                    {
                        if (dc2.id == this._goToArticleParams.categoryId)
                        {
                            foundCategory = dc2;
                        };
                        if (foundCategory)
                        {
                            break;
                        };
                        for each (dc3 in dc2.subcats)
                        {
                            if (dc3.id == this._goToArticleParams.categoryId)
                            {
                                foundCategory = dc3;
                            };
                            if (foundCategory)
                            {
                                break;
                            };
                        };
                    };
                };
                this.displayCategories(foundCategory);
            };
        }


    }
}//package ui

