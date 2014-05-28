package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectDissociateAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectFeedAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectChangeSkinRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.MimicryObjectFeedAndAssociateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.MimicryObjectEraseRequestAction;
   
   public class ApiLivingObjectActionList extends Object
   {
      
      public function ApiLivingObjectActionList() {
         super();
      }
      
      public static const LivingObjectDissociate:DofusApiAction;
      
      public static const LivingObjectFeed:DofusApiAction;
      
      public static const LivingObjectChangeSkinRequest:DofusApiAction;
      
      public static const MimicryObjectFeedAndAssociateRequest:DofusApiAction;
      
      public static const MimicryObjectEraseRequest:DofusApiAction;
   }
}
