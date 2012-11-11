package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class PVPRankItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function PVPRankItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            return I18n.getUiText("ui.pvp.rank") + " " + _operator.text + " " + _criterionValue;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new PVPRankItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return 0;
        }// end function

    }
}
