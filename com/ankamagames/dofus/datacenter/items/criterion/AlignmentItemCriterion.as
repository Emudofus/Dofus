package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.datacenter.alignments.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class AlignmentItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function AlignmentItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = AlignmentSide.getAlignmentSideById(int(_criterionValue)).name;
            var _loc_2:* = I18n.getUiText("ui.common.alignment");
            var _loc_3:* = ":";
            if (_operator.text == ItemCriterionOperator.DIFFERENT)
            {
                _loc_3 = I18n.getUiText("ui.common.differentFrom") + I18n.getUiText("ui.common.colon");
            }
            return _loc_2 + " " + _loc_3 + " " + _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new AlignmentItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentSide;
        }// end function

    }
}
