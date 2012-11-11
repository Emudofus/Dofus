package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.utils.pattern.*;

    public class DayItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function DayItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = _criterionValue.toString();
            var _loc_2:* = PatternDecoder.combine(I18n.getUiText("ui.time.days"), "n", true);
            return _loc_2 + " " + _operator.text + " " + _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new DayItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            var _loc_1:* = new Date();
            return TimeManager.getInstance().getDateFromTime(_loc_1.getTime())[2];
        }// end function

    }
}
