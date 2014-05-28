package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   
   public class UnusableItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function UnusableItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get text() : String {
         var readableCriterionRef:String = I18n.getUiText("ui.criterion.unusableItem");
         return readableCriterionRef;
      }
      
      override public function get isRespected() : Boolean {
         return true;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:UnusableItemCriterion = new UnusableItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         return 0;
      }
   }
}
