package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   
   public class PVPRankItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function PVPRankItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         return I18n.getUiText("ui.pvp.rank") + " " + _operator.text + " " + _criterionValue;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:PVPRankItemCriterion = new PVPRankItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         return 0;
      }
   }
}
