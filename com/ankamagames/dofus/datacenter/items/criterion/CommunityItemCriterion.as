package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.jerakine.data.I18n;
   
   public class CommunityItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function CommunityItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get isRespected() : Boolean {
         var _loc1_:int = PlayerManager.getInstance().server.communityId;
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return _loc1_ == criterionValue;
            case ItemCriterionOperator.DIFFERENT:
               return !(_loc1_ == criterionValue);
            default:
               return false;
         }
      }
      
      override public function get text() : String {
         var _loc1_:String = null;
         var _loc2_:String = PlayerManager.getInstance().server.community.name;
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               _loc1_ = I18n.getUiText("ui.criterion.community",[_loc2_]);
               break;
            case ItemCriterionOperator.DIFFERENT:
               _loc1_ = I18n.getUiText("ui.criterion.notCommunity",[_loc2_]);
               break;
         }
         return _loc1_;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:CommunityItemCriterion = new CommunityItemCriterion(this.basicText);
         return _loc1_;
      }
   }
}
