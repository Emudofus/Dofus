package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.dofus.logic.game.common.actions.mount.*;
    import com.ankamagames.dofus.misc.utils.*;

    public class ApiMountActionList extends Object
    {
        public static const MountToggleRidingRequest:DofusApiAction = new DofusApiAction("MountToggleRidingRequest", MountToggleRidingRequestAction);
        public static const MountFeedRequest:DofusApiAction = new DofusApiAction("MountFeedRequest", MountFeedRequestAction);
        public static const MountReleaseRequest:DofusApiAction = new DofusApiAction("MountReleaseRequest", MountReleaseRequestAction);
        public static const MountSterilizeRequest:DofusApiAction = new DofusApiAction("MountSterilizeRequest", MountSterilizeRequestAction);
        public static const MountRenameRequest:DofusApiAction = new DofusApiAction("MountRenameRequest", MountRenameRequestAction);
        public static const MountSetXpRatioRequest:DofusApiAction = new DofusApiAction("MountSetXpRatioRequest", MountSetXpRatioRequestAction);
        public static const MountInfoRequest:DofusApiAction = new DofusApiAction("MountInfoRequest", MountInfoRequestAction);
        public static const ExchangeRequestOnMountStock:DofusApiAction = new DofusApiAction("ExchangeRequestOnMountStock", ExchangeRequestOnMountStockAction);
        public static const ExchangeHandleMountStable:DofusApiAction = new DofusApiAction("ExchangeHandleMountStable", ExchangeHandleMountStableAction);
        public static const LeaveExchangeMount:DofusApiAction = new DofusApiAction("LeaveExchangeMount", LeaveExchangeMountAction);
        public static const PaddockRemoveItemRequest:DofusApiAction = new DofusApiAction("PaddockRemoveItemRequest", PaddockRemoveItemRequestAction);
        public static const PaddockMoveItemRequest:DofusApiAction = new DofusApiAction("PaddockMoveItemRequest", PaddockMoveItemRequestAction);
        public static const PaddockBuyRequest:DofusApiAction = new DofusApiAction("PaddockBuyRequest", PaddockBuyRequestAction);
        public static const PaddockSellRequest:DofusApiAction = new DofusApiAction("PaddockSellRequest", PaddockSellRequestAction);
        public static const MountInformationInPaddockRequest:DofusApiAction = new DofusApiAction("MountInformationInPaddockRequest", MountInformationInPaddockRequestAction);

        public function ApiMountActionList()
        {
            return;
        }// end function

    }
}
