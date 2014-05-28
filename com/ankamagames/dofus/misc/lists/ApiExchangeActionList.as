package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeAcceptAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRefuseAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveKamaAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListWithQuantityToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeReadyAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangePlayerRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeOnHumanVendorRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeStartAsVendorRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeRequestOnShopStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.LeaveShopStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeShopStockMouvmentAddAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeShopStockMouvmentRemoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectModifyPricedAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeSellAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeShowVendorTaxAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseSearchAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseListAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseTypeAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHousePriceAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.LeaveBidHouseAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidHouseStringSearchAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToBuyerModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToSellerModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeItemGoldAddAsPaymentAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeItemObjectAddAsPaymentAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.JobAllowMultiCraftRequestSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangePlayerMultiCraftRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeReplayAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeReplayStopAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeObjectUseInWorkshopAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRequestOnTaxCollectorAction;
   
   public class ApiExchangeActionList extends Object
   {
      
      public function ApiExchangeActionList() {
         super();
      }
      
      public static const ExchangeAccept:DofusApiAction;
      
      public static const ExchangeRefuse:DofusApiAction;
      
      public static const ExchangeObjectMove:DofusApiAction;
      
      public static const ExchangeObjectMoveKama:DofusApiAction;
      
      public static const ExchangeObjectTransfertAllToInv:DofusApiAction;
      
      public static const ExchangeObjectTransfertListToInv:DofusApiAction;
      
      public static const ExchangeObjectTransfertExistingToInv:DofusApiAction;
      
      public static const ExchangeObjectTransfertListWithQuantityToInv:DofusApiAction;
      
      public static const ExchangeObjectTransfertAllFromInv:DofusApiAction;
      
      public static const ExchangeObjectTransfertListFromInv:DofusApiAction;
      
      public static const ExchangeObjectTransfertExistingFromInv:DofusApiAction;
      
      public static const ExchangeReady:DofusApiAction;
      
      public static const ExchangePlayerRequest:DofusApiAction;
      
      public static const ExchangeOnHumanVendorRequest:DofusApiAction;
      
      public static const ExchangeStartAsVendorRequest:DofusApiAction;
      
      public static const ExchangeRequestOnShopStock:DofusApiAction;
      
      public static const LeaveShopStock:DofusApiAction;
      
      public static const ExchangeShopStockMouvmentAdd:DofusApiAction;
      
      public static const ExchangeShopStockMouvmentRemove:DofusApiAction;
      
      public static const ExchangeObjectModifyPriced:DofusApiAction;
      
      public static const ExchangeBuy:DofusApiAction;
      
      public static const ExchangeSell:DofusApiAction;
      
      public static const ExchangeShowVendorTax:DofusApiAction;
      
      public static const ExchangeBidHouseSearch:DofusApiAction;
      
      public static const ExchangeBidHouseList:DofusApiAction;
      
      public static const ExchangeBidHouseType:DofusApiAction;
      
      public static const ExchangeBidHouseBuy:DofusApiAction;
      
      public static const ExchangeBidHousePrice:DofusApiAction;
      
      public static const LeaveBidHouse:DofusApiAction;
      
      public static const BidHouseStringSearch:DofusApiAction;
      
      public static const BidSwitchToBuyerMode:DofusApiAction;
      
      public static const BidSwitchToSellerMode:DofusApiAction;
      
      public static const ExchangeItemGoldAddAsPayment:DofusApiAction;
      
      public static const ExchangeItemObjectAddAsPayment:DofusApiAction;
      
      public static const JobAllowMultiCraftRequestSet:DofusApiAction;
      
      public static const ExchangePlayerMultiCraftRequest:DofusApiAction;
      
      public static const ExchangeReplay:DofusApiAction;
      
      public static const ExchangeReplayStop:DofusApiAction;
      
      public static const ExchangeMultiCraftSetCrafterCanUseHisRessources:DofusApiAction;
      
      public static const ExchangeObjectUseInWorkshop:DofusApiAction;
      
      public static const ExchangeRequestOnTaxCollector:DofusApiAction;
   }
}
