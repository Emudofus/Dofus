package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectDissociateAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectFeedAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectChangeSkinRequestAction;


   public class ApiLivingObjectActionList extends Object
   {
         

      public function ApiLivingObjectActionList() {
         super();
      }

      public static const LivingObjectDissociate:DofusApiAction = new DofusApiAction("LivingObjectDissociate",LivingObjectDissociateAction);

      public static const LivingObjectFeed:DofusApiAction = new DofusApiAction("LivingObjectFeed",LivingObjectFeedAction);

      public static const LivingObjectChangeSkinRequest:DofusApiAction = new DofusApiAction("LivingObjectChangeSkinRequest",LivingObjectChangeSkinRequestAction);


   }

}