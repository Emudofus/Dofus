package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class MariedItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function MariedItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = "";
            switch(_operator.text)
            {
                case ItemCriterionOperator.EQUAL:
                {
                    if (_criterionValue == 1)
                    {
                        _loc_1 = I18n.getUiText("ui.tooltip.beMaried");
                    }
                    else
                    {
                        _loc_1 = I18n.getUiText("ui.tooltip.beSingle");
                    }
                    break;
                }
                case ItemCriterionOperator.DIFFERENT:
                {
                    if (_criterionValue == 2)
                    {
                        _loc_1 = I18n.getUiText("ui.tooltip.beMaried");
                    }
                    else
                    {
                        _loc_1 = I18n.getUiText("ui.tooltip.beSingle");
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new MariedItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return 0;
        }// end function

    }
}
