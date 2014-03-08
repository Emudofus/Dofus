package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   
   public class PremiumAccountItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function PremiumAccountItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         var _loc1_:String = I18n.getUiText("ui.tooltip.possessPremiumAccount");
         if(_criterionValue == 0)
         {
            _loc1_ = I18n.getUiText("ui.tooltip.dontPossessPremiumAccount");
         }
         return _loc1_;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:PremiumAccountItemCriterion = new PremiumAccountItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         return 0;
      }
   }
}
