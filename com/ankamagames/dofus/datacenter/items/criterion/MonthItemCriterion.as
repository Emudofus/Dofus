package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.misc.Month;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   
   public class MonthItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function MonthItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         var _loc1_:String = Month.getMonthById(_criterionValue).name;
         var _loc2_:String = I18n.getUiText("ui.time.months");
         return _loc2_ + " " + _operator.text + " " + _loc1_;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:MonthItemCriterion = new MonthItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         var _loc1_:Date = new Date();
         var _loc2_:int = TimeManager.getInstance().getDateFromTime(_loc1_.getTime())[3];
         return _loc2_-1;
      }
   }
}
