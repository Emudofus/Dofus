package 
{
    import flash.display.Sprite;
    import flash.utils.Dictionary;
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2api.PlayedCharacterApi;
    import d2api.ExchangeApi;
    import ui.StockBidHouse;
    import ui.ItemBidHouseSell;
    import ui.ItemBidHouseBuy;
    import ui.items.BuyModeXmlItem;
    import ui.items.BuyModeDetailXmlItem;
    import ui.EstateAgency;
    import ui.EstateForm;
    import ui.StockMyselfVendor;
    import ui.StockHumanVendor;
    import ui.ItemMyselfVendor;
    import ui.ItemHumanVendor;
    import ui.StockNpcStore;
    import ui.ItemNpcStore;
    import d2hooks.ExchangeStartedBidSeller;
    import d2hooks.ExchangeStartedBidBuyer;
    import d2hooks.EstateToSellList;
    import d2hooks.ExchangeShopStockStarted;
    import d2hooks.ExchangeStartOkHumanVendor;
    import d2hooks.ExchangeReplyTaxVendor;
    import d2hooks.ExchangeStartOkNpcShop;
    import d2hooks.CloseStore;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2actions.OpenInventory;
    import d2actions.ExchangeStartAsVendorRequest;

    public class TradeCenter extends Sprite 
    {

        public static var BID_HOUSE_BUY_MODE:Boolean;
        public static var SWITCH_MODE:Boolean = false;
        public static var SEARCH_MODE:Boolean = false;
        public static var SALES_PRICES:Dictionary = new Dictionary();
        public static var SALES_QUANTITIES:Dictionary = new Dictionary();
        public static var QUANTITIES:Array = new Array();
        public static const SELLING_RATIO:uint = 10;

        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var playerApi:PlayedCharacterApi;
        public var exchangeApi:ExchangeApi;
        private var include_StockBidHouse:StockBidHouse = null;
        private var include_ItemBidHouseSell:ItemBidHouseSell = null;
        private var include_ItemBidHouseBuy:ItemBidHouseBuy = null;
        private var include_BuyModeXmlItem:BuyModeXmlItem = null;
        private var include_BuyModeDetailXmlItem:BuyModeDetailXmlItem = null;
        private var include_EstateAgency:EstateAgency = null;
        private var include_EstateForm:EstateForm = null;
        private var include_StockMyselfVendor:StockMyselfVendor = null;
        private var include_StockHumanVendor:StockHumanVendor = null;
        private var include_ItemMyselfVendor:ItemMyselfVendor = null;
        private var include_ItemHumanVendor:ItemHumanVendor = null;
        private var _include_StockNpcStore:StockNpcStore = null;
        private var _include_ItemNpcStoreSell:ItemNpcStore = null;
        private var _storedObjectsInfos:Object;
        private var _uiToOpen:Array;
        private var _sellerName:String;


        public function main():void
        {
            this.sysApi.addHook(ExchangeStartedBidSeller, this.onExchangeStartedBidSeller);
            this.sysApi.addHook(ExchangeStartedBidBuyer, this.onExchangeStartedBidBuyer);
            this.sysApi.addHook(EstateToSellList, this.onEstateList);
            this.sysApi.addHook(ExchangeShopStockStarted, this.onExchangeShopStockStarted);
            this.sysApi.addHook(ExchangeStartOkHumanVendor, this.onExchangeStartOkHumanVendor);
            this.sysApi.addHook(ExchangeReplyTaxVendor, this.onExchangeReplyTaxVendor);
            this.sysApi.addHook(ExchangeStartOkNpcShop, this.onExchangeStartOkNpcShop);
            this.sysApi.addHook(CloseStore, this.onCloseStore);
            this._uiToOpen = new Array();
        }

        private function onExchangeStartedBidSeller(sellerBuyerDescriptor:Object, objectsInfos:Object):void
        {
            var qty:int;
            var bidHouseSellUI:Object;
            SWITCH_MODE = false;
            BID_HOUSE_BUY_MODE = false;
            QUANTITIES = new Array();
            for each (qty in sellerBuyerDescriptor.quantities)
            {
                QUANTITIES.push(qty);
            };
            bidHouseSellUI = this.uiApi.getUi(UIEnum.BIDHOUSE_SELL);
            if (bidHouseSellUI == null)
            {
                this.uiApi.loadUi(UIEnum.BIDHOUSE_SELL, UIEnum.BIDHOUSE_SELL, {"sellerBuyerDescriptor":sellerBuyerDescriptor});
            };
            var bidHouseBuyUI:Object = this.uiApi.getUi(UIEnum.BIDHOUSE_BUY);
            if (bidHouseBuyUI == null)
            {
                this.uiApi.loadUi(UIEnum.BIDHOUSE_BUY, UIEnum.BIDHOUSE_BUY, {"sellerBuyerDescriptor":sellerBuyerDescriptor});
            };
            var stockBidHouseUI:Object = this.uiApi.getUi(UIEnum.BIDHOUSE_STOCK);
            if (stockBidHouseUI == null)
            {
                this.uiApi.loadUi(UIEnum.BIDHOUSE_STOCK, UIEnum.BIDHOUSE_STOCK, {
                    "sellerBuyerDescriptor":sellerBuyerDescriptor,
                    "objectsInfos":objectsInfos
                });
            }
            else
            {
                stockBidHouseUI.uiClass.changeBidHouseMode();
            };
            this.sysApi.sendAction(new OpenInventory("bidHouse"));
        }

        private function onExchangeStartedBidBuyer(sellerBuyerDescriptor:Object):void
        {
            SWITCH_MODE = false;
            BID_HOUSE_BUY_MODE = true;
            var bidHouseSellUI:Object = this.uiApi.getUi(UIEnum.BIDHOUSE_SELL);
            if (bidHouseSellUI == null)
            {
                this.uiApi.loadUi(UIEnum.BIDHOUSE_SELL, UIEnum.BIDHOUSE_SELL, {"sellerBuyerDescriptor":sellerBuyerDescriptor});
            };
            var bidHouseBuyUI:Object = this.uiApi.getUi(UIEnum.BIDHOUSE_BUY);
            if (bidHouseBuyUI == null)
            {
                this.uiApi.loadUi(UIEnum.BIDHOUSE_BUY, UIEnum.BIDHOUSE_BUY, {
                    "visible":true,
                    "sellerBuyerDescriptor":sellerBuyerDescriptor
                });
            };
            var stockBidHouseUI:Object = this.uiApi.getUi(UIEnum.BIDHOUSE_STOCK);
            if (stockBidHouseUI == null)
            {
                this.uiApi.loadUi(UIEnum.BIDHOUSE_STOCK, UIEnum.BIDHOUSE_STOCK, {"sellerBuyerDescriptor":sellerBuyerDescriptor});
            }
            else
            {
                stockBidHouseUI.uiClass.changeBidHouseMode();
            };
            this.sysApi.sendAction(new OpenInventory("bidHouse"));
        }

        private function onEstateList(list:Object, pageIndex:uint, totalPage:uint, type:uint=0):void
        {
            if (this.uiApi.getUi("estateAgency") == null)
            {
                this.uiApi.loadUi("estateAgency", "estateAgency", {
                    "type":type,
                    "list":list,
                    "index":pageIndex,
                    "total":totalPage
                });
            };
        }

        public function onExchangeStartOkNpcShop(pNCPSellerId:int, pObjects:Object, pLook:Object, tokenId:int):void
        {
            this.uiApi.loadUi(UIEnum.NPC_STOCK, UIEnum.NPC_STOCK, {
                "NPCSellerId":pNCPSellerId,
                "Objects":pObjects,
                "Look":pLook,
                "TokenId":tokenId
            });
            if (tokenId)
            {
                if ((((tokenId == 14635)) || ((tokenId == 15263))))
                {
                    this.sysApi.sendAction(new OpenInventory("tokenStoneShop"));
                }
                else
                {
                    this.sysApi.sendAction(new OpenInventory("tokenShop"));
                };
            }
            else
            {
                this.sysApi.sendAction(new OpenInventory("shop"));
            };
        }

        private function onCloseStore():void
        {
            this.uiApi.unloadUi(UIEnum.NPC_STOCK);
        }

        private function onExchangeReplyTaxVendor(pTotalTaxValue:uint):void
        {
            this.modCommon.openPopup(this.uiApi.getText("ui.humanVendor.poupTitleTaxMessage"), this.uiApi.getText("ui.humanVendor.taxPriceMessage", pTotalTaxValue), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onAcceptTax, this.onRefuseTax], this.onAcceptTax, this.onRefuseTax);
        }

        private function onExchangeStartOkHumanVendor(pSellerName:String, pItems:Object):void
        {
            this._storedObjectsInfos = pItems;
            this._uiToOpen = new Array(UIEnum.HUMAN_VENDOR_STOCK, UIEnum.HUMAN_VENDOR);
            this.sysApi.sendAction(new OpenInventory("humanVendor"));
            this.openUi(pSellerName);
        }

        private function onExchangeShopStockStarted(pItems:Object):void
        {
            this._storedObjectsInfos = pItems;
            this._uiToOpen = new Array(UIEnum.MYSELF_VENDOR_STOCK, UIEnum.MYSELF_VENDOR);
            this.sysApi.sendAction(new OpenInventory("myselfVendor"));
            this.openUi();
        }

        private function onAcceptTax():void
        {
            if (this.uiApi.getUi(UIEnum.MYSELF_VENDOR_STOCK))
            {
                this.uiApi.unloadUi(UIEnum.MYSELF_VENDOR_STOCK);
            };
            this.sysApi.sendAction(new ExchangeStartAsVendorRequest());
        }

        private function onRefuseTax():void
        {
        }

        private function openUi(pSellerName:String=null):void
        {
            var uinterface:String;
            this._sellerName = pSellerName;
            for each (uinterface in this._uiToOpen)
            {
                switch (uinterface)
                {
                    case UIEnum.HUMAN_VENDOR_STOCK:
                        this.uiApi.loadUi(uinterface, uinterface, {
                            "playerName":pSellerName,
                            "objects":this._storedObjectsInfos
                        });
                        break;
                    case UIEnum.MYSELF_VENDOR_STOCK:
                        this.uiApi.loadUi(uinterface, uinterface, this._storedObjectsInfos);
                        break;
                    case UIEnum.MYSELF_VENDOR:
                    case UIEnum.HUMAN_VENDOR:
                        this.uiApi.loadUi(uinterface, uinterface);
                        break;
                };
            };
            this.sysApi.disableWorldInteraction();
        }


    }
}//package 

