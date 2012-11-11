package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SubareaItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function SubareaItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get isRespected() : Boolean
        {
            var _loc_1:* = PlayedCharacterManager.getInstance().currentSubArea.id;
            switch(_operator.text)
            {
                case ItemCriterionOperator.EQUAL:
                case ItemCriterionOperator.DIFFERENT:
                {
                    return super.isRespected;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return false;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = null;
            var _loc_2:* = SubArea.getSubAreaById(_criterionValue);
            if (!_loc_2)
            {
                return "error on subareaItemCriterion";
            }
            var _loc_3:* = _loc_2.name;
            switch(_operator.text)
            {
                case ItemCriterionOperator.EQUAL:
                {
                    _loc_1 = I18n.getUiText("ui.tooltip.beInSubarea") + I18n.getUiText("ui.common.colon") + _loc_3;
                    break;
                }
                case ItemCriterionOperator.DIFFERENT:
                {
                    _loc_1 = I18n.getUiText("ui.tooltip.dontBeInSubarea") + I18n.getUiText("ui.common.colon") + _loc_3;
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new SubareaItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return PlayedCharacterManager.getInstance().currentSubArea.id;
        }// end function

    }
}
