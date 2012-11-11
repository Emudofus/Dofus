package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.*;

    public class SkillItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function SkillItemCriterion(param1:String)
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
            var _loc_1:* = new SkillItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return 0;
        }// end function

    }
}
