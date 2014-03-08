package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class SpecializationItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function SpecializationItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get text() : String {
         return _criterionRef + " " + _operator.text + " " + _criterionValue;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:SpecializationItemCriterion = new SpecializationItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentGrade;
      }
   }
}
