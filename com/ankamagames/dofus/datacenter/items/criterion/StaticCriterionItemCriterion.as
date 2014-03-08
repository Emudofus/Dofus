package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class StaticCriterionItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function StaticCriterionItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         return "";
      }
      
      override public function get isRespected() : Boolean {
         return true;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:StaticCriterionItemCriterion = new StaticCriterionItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         return 0;
      }
   }
}
