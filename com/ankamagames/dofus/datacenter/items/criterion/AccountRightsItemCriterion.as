package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class AccountRightsItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function AccountRightsItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:String = null;
            var _loc_2:String = null;
            if (PlayerManager.getInstance().hasRights)
            {
                _loc_1 = _criterionValue.toString();
                _loc_2 = I18n.getUiText("ui.social.guildHouseRights");
                return _loc_2 + " " + _operator.text + " " + _loc_1;
            }
            return "";
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new AccountRightsItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return 0;
        }// end function

    }
}
