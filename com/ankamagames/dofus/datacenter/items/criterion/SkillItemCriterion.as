package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SkillItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function SkillItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         return _criterionRef + " " + _operator.text + " " + _criterionValue;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:SkillItemCriterion = new SkillItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         return 0;
      }
   }
}
