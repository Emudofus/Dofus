package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class RideItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function RideItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = null;
            if (_operator.text == ItemCriterionOperator.EQUAL && _criterionValue == 1 || _operator.text == ItemCriterionOperator.DIFFERENT && _criterionValue == 0)
            {
                _loc_1 = I18n.getUiText("ui.tooltip.mountEquiped");
            }
            if (_operator.text == ItemCriterionOperator.EQUAL && _criterionValue == 0 || _operator.text == ItemCriterionOperator.DIFFERENT && _criterionValue == 1)
            {
                _loc_1 = I18n.getUiText("ui.tooltip.mountNonEquiped");
            }
            return _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new RideItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            var _loc_1:* = (Kernel.getWorker().getFrame(AbstractEntitiesFrame) as AbstractEntitiesFrame).playerIsOnRide;
            if (_loc_1)
            {
                return 1;
            }
            return 0;
        }// end function

    }
}
