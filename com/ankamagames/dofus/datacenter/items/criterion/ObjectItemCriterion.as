package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class ObjectItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function ObjectItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get isRespected() : Boolean
        {
            var _loc_1:ItemWrapper = null;
            for each (_loc_1 in InventoryManager.getInstance().realInventory)
            {
                
                if (_loc_1.objectGID == _criterionValue)
                {
                    if (_operator.text == ItemCriterionOperator.EQUAL)
                    {
                        return true;
                    }
                    return false;
                }
            }
            if (_operator.text == ItemCriterionOperator.DIFFERENT)
            {
                return true;
            }
            return false;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = Item.getItemById(_criterionValue).name;
            var _loc_2:String = "";
            switch(_operator.text)
            {
                case ItemCriterionOperator.DIFFERENT:
                {
                    _loc_2 = I18n.getUiText("ui.common.doNotPossess", [_loc_1]);
                    break;
                }
                case ItemCriterionOperator.EQUAL:
                {
                    _loc_2 = I18n.getUiText("ui.common.doPossess", [_loc_1]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new ObjectItemCriterion(this.basicText);
            return _loc_1;
        }// end function

    }
}
