package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.dofus.logic.game.common.actions.bid.*;
    import com.ankamagames.dofus.logic.game.common.actions.craft.*;
    import com.ankamagames.dofus.logic.game.common.actions.exchange.*;
    import com.ankamagames.dofus.logic.game.common.actions.humanVendor.*;
    import com.ankamagames.dofus.misc.utils.*;

    public class ApiExchangeActionList extends Object
    {
        public static const ExchangeAccept:DofusApiAction = new DofusApiAction("ExchangeAccept", ExchangeAcceptAction);
        public static const ExchangeRefuse:DofusApiAction = new DofusApiAction("ExchangeRefuse", ExchangeRefuseAction);
        public static const ExchangeObjectMove:DofusApiAction = new DofusApiAction("ExchangeObjectMove", ExchangeObjectMoveAction);
        public static const ExchangeObjectMoveKama:DofusApiAction = new DofusApiAction("ExchangeObjectMoveKama", ExchangeObjectMoveKamaAction);
        public static const ExchangeObjectTransfertAllToInv:DofusApiAction = new DofusApiAction("ExchangeObjectTransfertAllToInv", ExchangeObjectTransfertAllToInvAction);
        public static const ExchangeObjectTransfertListToInv:DofusApiAction = new DofusApiAction("ExchangeObjectTransfertListToInv", ExchangeObjectTransfertListToInvAction);
        public static const ExchangeObjectTransfertExistingToInv:DofusApiAction = new DofusApiAction("ExchangeObjectTransfertExistingToInv", ExchangeObjectTransfertExistingToInvAction);
        public static const ExchangeObjectTransfertAllFromInv:DofusApiAction = new DofusApiAction("ExchangeObjectTransfertAllFromInv", ExchangeObjectTransfertAllFromInvAction);
        public static const ExchangeObjectTransfertListFromInv:DofusApiAction = new DofusApiAction("ExchangeObjectTransfertListFromInv", ExchangeObjectTransfertListFromInvAction);
        public static const ExchangeObjectTransfertExistingFromInv:DofusApiAction = new DofusApiAction("ExchangeObjectTransfertExistingFromInv", ExchangeObjectTransfertExistingFromInvAction);
        public static const ExchangeReady:DofusApiAction = new DofusApiAction("ExchangeReady", ExchangeReadyAction);
        public static const ExchangePlayerRequest:DofusApiAction = new DofusApiAction("ExchangePlayerRequest", ExchangePlayerRequestAction);
        public static const ExchangeOnHumanVendorRequest:DofusApiAction = new DofusApiAction("ExchangeOnHumanVendorRequest", ExchangeOnHumanVendorRequestAction);
        public static const ExchangeStartAsVendorRequest:DofusApiAction = new DofusApiAction("ExchangeStartAsVendorRequest", ExchangeStartAsVendorRequestAction);
        public static const ExchangeRequestOnShopStock:DofusApiAction = new DofusApiAction("ExchangeRequestOnShopStock", ExchangeRequestOnShopStockAction);
        public static const LeaveShopStock:DofusApiAction = new DofusApiAction("LeaveShopStock", LeaveShopStockAction);
        public static const ExchangeShopStockMouvmentAdd:DofusApiAction = new DofusApiAction("ExchangeShopStockMouvmentAdd", ExchangeShopStockMouvmentAddAction);
        public static const ExchangeShopStockMouvmentRemove:DofusApiAction = new DofusApiAction("ExchangeShopStockMouvmentRemove", ExchangeShopStockMouvmentRemoveAction);
        public static const ExchangeShopStockModifyObject:DofusApiAction = new DofusApiAction("ExchangeShopStockModifyObject", ExchangeShopStockModifyObjectAction);
        public static const ExchangeBuy:DofusApiAction = new DofusApiAction("ExchangeBuy", ExchangeBuyAction);
        public static const ExchangeSell:DofusApiAction = new DofusApiAction("ExchangeSell", ExchangeSellAction);
        public static const ExchangeShowVendorTax:DofusApiAction = new DofusApiAction("ExchangeShowVendorTax", ExchangeShowVendorTaxAction);
        public static const ExchangeBidHouseSearch:DofusApiAction = new DofusApiAction("ExchangeBidHouseSearch", ExchangeBidHouseSearchAction);
        public static const ExchangeBidHouseList:DofusApiAction = new DofusApiAction("ExchangeBidHouseList", ExchangeBidHouseListAction);
        public static const ExchangeBidHouseType:DofusApiAction = new DofusApiAction("ExchangeBidHouseType", ExchangeBidHouseTypeAction);
        public static const ExchangeBidHouseBuy:DofusApiAction = new DofusApiAction("ExchangeBidHouseBuy", ExchangeBidHouseBuyAction);
        public static const ExchangeBidHousePrice:DofusApiAction = new DofusApiAction("ExchangeBidHousePrice", ExchangeBidHousePriceAction);
        public static const LeaveBidHouse:DofusApiAction = new DofusApiAction("LeaveBidHouse", LeaveBidHouseAction);
        public static const BidHouseStringSearch:DofusApiAction = new DofusApiAction("BidHouseStringSearch", BidHouseStringSearchAction);
        public static const BidSwitchToBuyerMode:DofusApiAction = new DofusApiAction("BidSwitchToBuyerMode", BidSwitchToBuyerModeAction);
        public static const BidSwitchToSellerMode:DofusApiAction = new DofusApiAction("BidSwitchToSellerMode", BidSwitchToSellerModeAction);
        public static const ExchangeItemGoldAddAsPayment:DofusApiAction = new DofusApiAction("ExchangeItemGoldAddAsPayment", ExchangeItemGoldAddAsPaymentAction);
        public static const ExchangeItemObjectAddAsPayment:DofusApiAction = new DofusApiAction("ExchangeItemObjectAddAsPayment", ExchangeItemObjectAddAsPaymentAction);
        public static const JobAllowMultiCraftRequestSet:DofusApiAction = new DofusApiAction("JobAllowMultiCraftRequestSet", JobAllowMultiCraftRequestSetAction);
        public static const ExchangePlayerMultiCraftRequest:DofusApiAction = new DofusApiAction("ExchangePlayerMultiCraftRequest", ExchangePlayerMultiCraftRequestAction);
        public static const ExchangeReplay:DofusApiAction = new DofusApiAction("ExchangeReplay", ExchangeReplayAction);
        public static const ExchangeReplayStop:DofusApiAction = new DofusApiAction("ExchangeReplayStop", ExchangeReplayStopAction);
        public static const ExchangeMultiCraftSetCrafterCanUseHisRessources:DofusApiAction = new DofusApiAction("ExchangeMultiCraftSetCrafterCanUseHisRessources", ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction);
        public static const ExchangeObjectUseInWorkshop:DofusApiAction = new DofusApiAction("ExchangeObjectUseInWorkshop", ExchangeObjectUseInWorkshopAction);
        public static const ExchangeRequestOnTaxCollector:DofusApiAction = new DofusApiAction("ExchangeRequestOnTaxCollector", ExchangeRequestOnTaxCollectorAction);

        public function ApiExchangeActionList()
        {
            return;
        }// end function

    }
}
