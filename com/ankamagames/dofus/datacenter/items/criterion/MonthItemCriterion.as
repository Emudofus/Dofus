package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class MonthItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function MonthItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = Month.getMonthById(_criterionValue).name;
            var _loc_2:* = I18n.getUiText("ui.time.months");
            return _loc_2 + " " + _operator.text + " " + _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new MonthItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return 0;
        }// end function

    }
}
