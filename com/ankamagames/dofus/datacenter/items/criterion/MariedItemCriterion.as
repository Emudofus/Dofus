package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   
   public class MariedItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function MariedItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         var _loc1_:* = "";
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               if(_criterionValue == 1)
               {
                  _loc1_ = I18n.getUiText("ui.tooltip.beMaried");
               }
               else
               {
                  _loc1_ = I18n.getUiText("ui.tooltip.beSingle");
               }
               break;
            case ItemCriterionOperator.DIFFERENT:
               if(_criterionValue == 2)
               {
                  _loc1_ = I18n.getUiText("ui.tooltip.beMaried");
               }
               else
               {
                  _loc1_ = I18n.getUiText("ui.tooltip.beSingle");
               }
               break;
         }
         return _loc1_;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:MariedItemCriterion = new MariedItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         return 0;
      }
   }
}
