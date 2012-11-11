package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class LevelItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function LevelItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = _criterionValue.toString();
            var _loc_2:* = I18n.getUiText("ui.common.level");
            return _loc_2 + " " + _operator.text + " " + _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new LevelItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return PlayedCharacterManager.getInstance().infos.level;
        }// end function

    }
}
