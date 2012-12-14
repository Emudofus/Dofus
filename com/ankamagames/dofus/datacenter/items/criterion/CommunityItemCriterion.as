package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class CommunityItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function CommunityItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get isRespected() : Boolean
        {
            var _loc_1:* = PlayerManager.getInstance().server.communityId;
            switch(_operator.text)
            {
                case ItemCriterionOperator.EQUAL:
                {
                    return _loc_1 == criterionValue;
                }
                case ItemCriterionOperator.DIFFERENT:
                {
                    return _loc_1 != criterionValue;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = null;
            var _loc_2:* = PlayerManager.getInstance().server.community.name;
            switch(_operator.text)
            {
                case ItemCriterionOperator.EQUAL:
                {
                    _loc_1 = I18n.getUiText("ui.criterion.community", [_loc_2]);
                    break;
                }
                case ItemCriterionOperator.DIFFERENT:
                {
                    _loc_1 = I18n.getUiText("ui.criterion.notCommunity", [_loc_2]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new CommunityItemCriterion(this.basicText);
            return _loc_1;
        }// end function

    }
}
