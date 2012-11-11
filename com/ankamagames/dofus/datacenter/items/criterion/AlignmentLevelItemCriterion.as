package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class AlignmentLevelItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function AlignmentLevelItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = I18n.getUiText("ui.tooltip.AlignmentLevel");
            return _loc_1 + " " + _operator.text + " " + _criterionValue;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new AlignmentLevelItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            var _loc_1:* = PlayedCharacterManager.getInstance().characteristics.alignmentInfos.characterPower - PlayedCharacterManager.getInstance().infos.id;
            return _loc_1;
        }// end function

    }
}
