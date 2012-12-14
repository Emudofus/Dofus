package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class AreaItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function AreaItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get isRespected() : Boolean
        {
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
            var _loc_2:* = Area.getAreaById(_criterionValue);
            if (!_loc_2)
            {
                return "error on AreaItemCriterion";
            }
            var _loc_3:* = _loc_2.name;
            switch(_operator.text)
            {
                case ItemCriterionOperator.EQUAL:
                {
                    _loc_1 = I18n.getUiText("ui.tooltip.beInArea", [_loc_3]);
                    break;
                }
                case ItemCriterionOperator.DIFFERENT:
                {
                    _loc_1 = I18n.getUiText("ui.tooltip.dontBeInArea", [_loc_3]);
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
            var _loc_1:* = new AreaItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return PlayedCharacterManager.getInstance().currentSubArea.area.id;
        }// end function

    }
}
