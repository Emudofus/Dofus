package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class SpecializationItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function SpecializationItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         return _criterionRef + " " + _operator.text + " " + _criterionValue;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:SpecializationItemCriterion = new SpecializationItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentGrade;
      }
   }
}
