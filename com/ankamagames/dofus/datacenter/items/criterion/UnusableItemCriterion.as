package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   
   public class UnusableItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function UnusableItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         var _loc1_:String = I18n.getUiText("ui.criterion.unusableItem");
         return _loc1_;
      }
      
      override public function get isRespected() : Boolean {
         return true;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:UnusableItemCriterion = new UnusableItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         return 0;
      }
   }
}
