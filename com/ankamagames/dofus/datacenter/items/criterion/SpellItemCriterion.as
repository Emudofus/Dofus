package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SpellItemCriterion extends ItemCriterion implements IDataCenter
    {
        private var _spellId:uint;

        public function SpellItemCriterion(param1:String)
        {
            super(param1);
            var _loc_2:* = String(_criterionValueText).split(",");
            if (_loc_2 && _loc_2.length > 0)
            {
                if (_loc_2.length > 1)
                {
                }
                else
                {
                    this._spellId = uint(_loc_2[0]);
                }
            }
            else
            {
                this._spellId = uint(_criterionValue);
            }
            return;
        }// end function

        override public function get isRespected() : Boolean
        {
            var _loc_1:* = null;
            for each (_loc_1 in PlayedCharacterManager.getInstance().playerSpellList)
            {
                
                if (_loc_1.id == this._spellId)
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
            var _loc_1:* = "";
            var _loc_2:* = "";
            var _loc_3:* = Spell.getSpellById(this._spellId);
            if (!_loc_3)
            {
                return _loc_2;
            }
            var _loc_4:* = _loc_3.name;
            switch(_operator.text)
            {
                case ItemCriterionOperator.EQUAL:
                {
                    _loc_2 = I18n.getUiText("ui.criterion.gotSpell", [_loc_4]);
                    break;
                }
                case ItemCriterionOperator.DIFFERENT:
                {
                    _loc_2 = I18n.getUiText("ui.criterion.doesntGotSpell", [_loc_4]);
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
            var _loc_1:* = new SpellItemCriterion(this.basicText);
            return _loc_1;
        }// end function

    }
}
