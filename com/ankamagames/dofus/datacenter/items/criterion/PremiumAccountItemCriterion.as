package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   
   public class PremiumAccountItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function PremiumAccountItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get text() : String {
         var readableCriterion:String = I18n.getUiText("ui.tooltip.possessPremiumAccount");
         if(_criterionValue == 0)
         {
            readableCriterion = I18n.getUiText("ui.tooltip.dontPossessPremiumAccount");
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:PremiumAccountItemCriterion = new PremiumAccountItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         return 0;
      }
   }
}
