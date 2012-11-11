package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.*;

    public class StaticCriterionItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function StaticCriterionItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            return "";
        }// end function

        override public function get isRespected() : Boolean
        {
            return true;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new StaticCriterionItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return 0;
        }// end function

    }
}
