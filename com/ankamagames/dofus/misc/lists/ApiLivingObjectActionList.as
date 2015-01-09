package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.dofus.misc.utils.DofusApiAction;
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectDissociateAction;
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectFeedAction;
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectChangeSkinRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.MimicryObjectFeedAndAssociateRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.MimicryObjectEraseRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.WrapperObjectDissociateRequestAction;

    public class ApiLivingObjectActionList 
    {

        public static const LivingObjectDissociate:DofusApiAction = new DofusApiAction("LivingObjectDissociate", LivingObjectDissociateAction);
        public static const LivingObjectFeed:DofusApiAction = new DofusApiAction("LivingObjectFeed", LivingObjectFeedAction);
        public static const LivingObjectChangeSkinRequest:DofusApiAction = new DofusApiAction("LivingObjectChangeSkinRequest", LivingObjectChangeSkinRequestAction);
        public static const MimicryObjectFeedAndAssociateRequest:DofusApiAction = new DofusApiAction("MimicryObjectFeedAndAssociateRequest", MimicryObjectFeedAndAssociateRequestAction);
        public static const MimicryObjectEraseRequest:DofusApiAction = new DofusApiAction("MimicryObjectEraseRequest", MimicryObjectEraseRequestAction);
        public static const WrapperObjectDissociateRequest:DofusApiAction = new DofusApiAction("WrapperObjectDissociateRequest", WrapperObjectDissociateRequestAction);


    }
}//package com.ankamagames.dofus.misc.lists

