package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.berilia.types.data.*;

    public class ExchangeHookList extends Object
    {
        public static const ExchangeError:Hook = new Hook("ExchangeError", false);
        public static const ExchangeLeave:Hook = new Hook("ExchangeLeave", false);
        public static const ExchangeObjectModified:Hook = new Hook("ExchangeObjectModified", false);
        public static const ExchangeObjectAdded:Hook = new Hook("ExchangeObjectAdded", false);
        public static const ExchangeObjectRemoved:Hook = new Hook("ExchangeObjectRemoved", false);
        public static const ExchangeKamaModified:Hook = new Hook("ExchangeKamaModified", false);
        public static const ExchangeStartOkNpcTrade:Hook = new Hook("ExchangeStartOkNpcTrade", false);
        public static const ExchangeRequestCharacterFromMe:Hook = new Hook("ExchangeRequestCharacterFromMe", false);
        public static const ExchangeRequestCharacterToMe:Hook = new Hook("ExchangeRequestCharacterToMe", false);
        public static const ExchangeStarted:Hook = new Hook("ExchangeStarted", false);
        public static const ExchangeBankStarted:Hook = new Hook("ExchangeBankStarted", false);
        public static const ExchangeBankStartedWithStorage:Hook = new Hook("ExchangeBankStartedWithStorage", false);
        public static const ExchangeStartedType:Hook = new Hook("ExchangeStartedType", false);
        public static const AskExchangeMoveObject:Hook = new Hook("AskExchangeMoveObject", false);
        public static const ExchangeIsReady:Hook = new Hook("ExchangeIsReady", false);
        public static const ExchangeWeight:Hook = new Hook("ExchangeWeight", false);
        public static const ExchangeStartOkHumanVendor:Hook = new Hook("ExchangeStartOkHumanVendor", false);
        public static const ExchangeShopStockStarted:Hook = new Hook("ExchangeShopStockStarted", false);
        public static const ExchangeShopStockMovementUpdated:Hook = new Hook("ExchangeShopStockMovementUpdated", false);
        public static const ExchangeShopStockMouvmentRemoveOk:Hook = new Hook("ExchangeShopStockMouvmentRemoveOk", false);
        public static const ExchangeShopStockUpdate:Hook = new Hook("ExchangeShopStockUpdate", false);
        public static const ExchangeShopStockAddQuantity:Hook = new Hook("ExchangeShopStockAddQuantity", false);
        public static const ExchangeShopStockRemoveQuantity:Hook = new Hook("ExchangeShopStockRemoveQuantity", false);
        public static const ClickItemInventory:Hook = new Hook("ClickItemInventory", false);
        public static const ClickItemShopHV:Hook = new Hook("ClickItemShopHV", false);
        public static const ExchangeReplyTaxVendor:Hook = new Hook("ExchangeReplyTaxVendor", false);
        public static const ExchangeShopStockMovementRemoved:Hook = new Hook("ExchangeShopStockMovementRemoved", false);
        public static const CloseStore:Hook = new Hook("CloseStore", false);
        public static const ClickItemStore:Hook = new Hook("ClickItemStore", false);
        public static const SellOk:Hook = new Hook("SellOk", false);
        public static const BuyOk:Hook = new Hook("BuyOk", false);
        public static const ExchangeStartedBidSeller:Hook = new Hook("ExchangeStartedBidSeller", false);
        public static const ExchangeStartedBidBuyer:Hook = new Hook("ExchangeStartedBidBuyer", false);
        public static const ExchangeBidPrice:Hook = new Hook("ExchangeBidPrice", false);
        public static const ExchangeBidSearchOk:Hook = new Hook("ExchangeBidSearchOk", false);
        public static const OpenBidHouse:Hook = new Hook("OpenBidHouse", false);
        public static const ExchangeBidHouseItemAddOk:Hook = new Hook("ExchangeBidHouseItemAddOk", false);
        public static const ExchangeBidHouseItemRemoveOk:Hook = new Hook("ExchangeBidHouseItemRemoveOk", false);
        public static const ExchangeBidHouseGenericItemAdded:Hook = new Hook("ExchangeBidHouseGenericItemAdded", false);
        public static const ExchangeBidHouseGenericItemRemoved:Hook = new Hook("ExchangeBidHouseGenericItemRemoved", false);
        public static const ExchangeTypesItemsExchangerDescriptionForUser:Hook = new Hook("ExchangeTypesItemsExchangerDescriptionForUser", false);
        public static const ExchangeTypesExchangerDescriptionForUser:Hook = new Hook("ExchangeTypesExchangerDescriptionForUser", false);
        public static const ExchangeBidHouseInListAdded:Hook = new Hook("ExchangeBidHouseInListAdded", false);
        public static const SellerObjectListUpdate:Hook = new Hook("SellerObjectListUpdate", false);
        public static const BidObjectTypeListUpdate:Hook = new Hook("BidObjectTypeListUpdate", false);
        public static const BidObjectListUpdate:Hook = new Hook("BidObjectListUpdate", false);
        public static const PricesUpdate:Hook = new Hook("PricesUpdate", false);
        public static const SwitchingBidMode:Hook = new Hook("SwitchingBidMode", false);
        public static const ExchangeStartOkNpcShop:Hook = new Hook("ExchangeStartOkNpcShop", false);

        public function ExchangeHookList()
        {
            return;
        }// end function

    }
}
