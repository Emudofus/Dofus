package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountToggleRidingRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountFeedRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountReleaseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountSterilizeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountRenameRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountSetXpRatioRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInfoRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeRequestOnMountStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeHandleMountStableAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.LeaveExchangeMountAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockRemoveItemRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockMoveItemRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockBuyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockSellRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInformationInPaddockRequestAction;
   
   public class ApiMountActionList extends Object
   {
      
      public function ApiMountActionList() {
         super();
      }
      
      public static const MountToggleRidingRequest:DofusApiAction;
      
      public static const MountFeedRequest:DofusApiAction;
      
      public static const MountReleaseRequest:DofusApiAction;
      
      public static const MountSterilizeRequest:DofusApiAction;
      
      public static const MountRenameRequest:DofusApiAction;
      
      public static const MountSetXpRatioRequest:DofusApiAction;
      
      public static const MountInfoRequest:DofusApiAction;
      
      public static const ExchangeRequestOnMountStock:DofusApiAction;
      
      public static const ExchangeHandleMountStable:DofusApiAction;
      
      public static const LeaveExchangeMount:DofusApiAction;
      
      public static const PaddockRemoveItemRequest:DofusApiAction;
      
      public static const PaddockMoveItemRequest:DofusApiAction;
      
      public static const PaddockBuyRequest:DofusApiAction;
      
      public static const PaddockSellRequest:DofusApiAction;
      
      public static const MountInformationInPaddockRequest:DofusApiAction;
   }
}
