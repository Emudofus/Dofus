package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SpecializationItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function SpecializationItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            return _criterionRef + " " + _operator.text + " " + _criterionValue;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new SpecializationItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentGrade;
        }// end function

    }
}
