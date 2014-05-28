package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.misc.Month;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   
   public class MonthItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function MonthItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get text() : String {
         var readableCriterionValue:String = Month.getMonthById(_criterionValue).name;
         var readableCriterionRef:String = I18n.getUiText("ui.time.months");
         return readableCriterionRef + " " + _operator.text + " " + readableCriterionValue;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:MonthItemCriterion = new MonthItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         var date:Date = new Date();
         var monthInt:int = TimeManager.getInstance().getDateFromTime(date.getTime())[3];
         return monthInt - 1;
      }
   }
}
