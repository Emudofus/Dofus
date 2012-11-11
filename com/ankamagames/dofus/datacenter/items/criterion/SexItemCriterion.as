package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SexItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function SexItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            if (_criterionValue == 1)
            {
                return I18n.getUiText("ui.tooltip.beFemale");
            }
            return I18n.getUiText("ui.tooltip.beMale");
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new SexItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return int(PlayedCharacterManager.getInstance().infos.sex);
        }// end function

    }
}
