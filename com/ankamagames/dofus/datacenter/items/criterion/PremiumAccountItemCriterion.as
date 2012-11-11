package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class PremiumAccountItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function PremiumAccountItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = I18n.getUiText("ui.tooltip.possessPremiumAccount");
            if (_criterionValue == 0)
            {
                _loc_1 = I18n.getUiText("ui.tooltip.dontPossessPremiumAccount");
            }
            return _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new PremiumAccountItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return 0;
        }// end function

    }
}
