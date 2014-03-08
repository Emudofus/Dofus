package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.jerakine.data.I18n;
   
   public class CommunityItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function CommunityItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean {
         var serverCommunity:int = PlayerManager.getInstance().server.communityId;
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return serverCommunity == criterionValue;
            case ItemCriterionOperator.DIFFERENT:
               return !(serverCommunity == criterionValue);
         }
      }
      
      override public function get text() : String {
         var readableCriterion:String = null;
         var readableCriterionValue:String = PlayerManager.getInstance().server.community.name;
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               readableCriterion = I18n.getUiText("ui.criterion.community",[readableCriterionValue]);
               break;
            case ItemCriterionOperator.DIFFERENT:
               readableCriterion = I18n.getUiText("ui.criterion.notCommunity",[readableCriterionValue]);
               break;
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:CommunityItemCriterion = new CommunityItemCriterion(this.basicText);
         return clonedCriterion;
      }
   }
}
