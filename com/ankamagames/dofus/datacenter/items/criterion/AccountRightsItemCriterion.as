package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.jerakine.data.I18n;
   
   public class AccountRightsItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function AccountRightsItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(PlayerManager.getInstance().hasRights)
         {
            _loc1_ = _criterionValue.toString();
            _loc2_ = I18n.getUiText("ui.social.guildHouseRights");
            return _loc2_ + " " + _operator.text + " " + _loc1_;
         }
         return "";
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:AccountRightsItemCriterion = new AccountRightsItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         return 0;
      }
   }
}
