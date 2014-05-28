package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class WeightItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function WeightItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get text() : String {
         var readableCriterionValue:String = _criterionValue.toString();
         var readableCriterionRef:String = I18n.getUiText("ui.common.weight");
         return readableCriterionRef + " " + _operator.text + " " + readableCriterionValue;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:WeightItemCriterion = new WeightItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         return PlayedCharacterManager.getInstance().inventoryWeight;
      }
   }
}
