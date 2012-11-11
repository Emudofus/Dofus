package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class FriendlistItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function FriendlistItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = I18n.getUiText("ui.tooltip.playerInFriendlist");
            var _loc_2:* = _operator.text;
            if (_loc_2 == ItemCriterionOperator.EQUAL)
            {
                _loc_2 = ":";
            }
            return _loc_1 + " " + _loc_2 + " " + _criterionValue;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new FriendlistItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).friendsList.length;
        }// end function

    }
}
