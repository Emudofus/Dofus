package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class StaticCriterionItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function StaticCriterionItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get text() : String {
         return "";
      }
      
      override public function get isRespected() : Boolean {
         return true;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:StaticCriterionItemCriterion = new StaticCriterionItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         return 0;
      }
   }
}
