package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class RankCriterion extends ItemCriterion implements IDataCenter
    {

        public function RankCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = String(_criterionValue);
            var _loc_2:* = I18n.getUiText("ui.common.pvpRank");
            var _loc_3:String = ">";
            if (_operator.text == ItemCriterionOperator.DIFFERENT)
            {
                _loc_3 = I18n.getUiText("ui.common.differentFrom") + " >";
            }
            return _loc_2 + " " + _loc_3 + " " + _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new RankCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            var _loc_1:* = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
            return _loc_1.arenaRanks[0];
        }// end function

    }
}
