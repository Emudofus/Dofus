package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.dofus.logic.game.common.actions.livingObject.*;
    import com.ankamagames.dofus.misc.utils.*;

    public class ApiLivingObjectActionList extends Object
    {
        public static const LivingObjectDissociate:DofusApiAction = new DofusApiAction("LivingObjectDissociate", LivingObjectDissociateAction);
        public static const LivingObjectFeed:DofusApiAction = new DofusApiAction("LivingObjectFeed", LivingObjectFeedAction);
        public static const LivingObjectChangeSkinRequest:DofusApiAction = new DofusApiAction("LivingObjectChangeSkinRequest", LivingObjectChangeSkinRequestAction);

        public function ApiLivingObjectActionList()
        {
            return;
        }// end function

    }
}
