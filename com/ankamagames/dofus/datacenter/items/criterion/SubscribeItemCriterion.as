package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SubscribeItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function SubscribeItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            if (_criterionValue == 1 && _operator.text == ItemCriterionOperator.EQUAL || _criterionValue == 0 && _operator.text == ItemCriterionOperator.DIFFERENT)
            {
                return I18n.getUiText("ui.tooltip.beSubscirber");
            }
            return I18n.getUiText("ui.tooltip.dontBeSubscriber");
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new SubscribeItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            var _loc_1:* = PlayerManager.getInstance().subscriptionEndDate;
            if (_loc_1 > 0 || PlayerManager.getInstance().hasRights)
            {
                return 1;
            }
            return 0;
        }// end function

    }
}
