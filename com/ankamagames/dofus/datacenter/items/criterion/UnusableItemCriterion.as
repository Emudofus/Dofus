package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class UnusableItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function UnusableItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = I18n.getUiText("ui.criterion.unusableItem");
            return _loc_1;
        }// end function

        override public function get isRespected() : Boolean
        {
            return true;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new UnusableItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return 0;
        }// end function

    }
}
