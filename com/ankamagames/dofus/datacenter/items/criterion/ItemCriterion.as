package com.ankamagames.dofus.datacenter.items.criterion
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.items.criterion.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.network.types.game.character.characteristic.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.utils.*;

    public class ItemCriterion extends Object implements IItemCriterion, IDataCenter
    {
        protected var _serverCriterionForm:String;
        protected var _operator:ItemCriterionOperator;
        protected var _criterionRef:String;
        protected var _criterionValue:int;
        protected var _criterionValueText:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ItemCriterion));

        public function ItemCriterion(param1:String)
        {
            this._serverCriterionForm = param1;
            this.getInfos();
            return;
        }// end function

        public function get inlineCriteria() : Vector.<IItemCriterion>
        {
            var _loc_1:* = new Vector.<IItemCriterion>;
            _loc_1.push(this);
            return _loc_1;
        }// end function

        public function get criterionValue() : Object
        {
            return this._criterionValue;
        }// end function

        public function get isRespected() : Boolean
        {
            return this._operator.compare(this.getCriterion(), this._criterionValue);
        }// end function

        public function get text() : String
        {
            var _loc_1:* = null;
            switch(this._criterionRef)
            {
                case "CM":
                {
                    _loc_1 = I18n.getUiText("ui.stats.MP");
                    break;
                }
                case "CP":
                {
                    _loc_1 = I18n.getUiText("ui.stats.AP");
                    break;
                }
                case "CH":
                {
                    _loc_1 = I18n.getUiText("ui.pvp.honourPoints");
                    break;
                }
                case "CD":
                {
                    _loc_1 = I18n.getUiText("ui.pvp.disgracePoints");
                    break;
                }
                case "CT":
                {
                    _loc_1 = I18n.getUiText("ui.stats.takleBlock");
                    break;
                }
                case "Ct":
                {
                    _loc_1 = I18n.getUiText("ui.stats.takleEvade");
                    break;
                }
                default:
                {
                    _loc_1 = StringUtils.replace(this._criterionRef, ["CS", "Cs", "CV", "Cv", "CA", "Ca", "CI", "Ci", "CW", "Cw", "CC", "Cc", "CA", "PG", "PJ", "Pj", "PM", "PA", "PN", "PE", "<NO>", "PS", "PR", "PL", "PK", "Pg", "Pr", "Ps", "Pa", "PP", "PZ", "CM", "Qa"], I18n.getUiText("ui.item.characteristics").split(","));
                    break;
                    break;
                }
            }
            return _loc_1 + " " + this._operator.text + " " + this._criterionValue;
        }// end function

        public function get basicText() : String
        {
            return this._serverCriterionForm;
        }// end function

        public function clone() : IItemCriterion
        {
            var _loc_1:* = new ItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        protected function getInfos() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in ItemCriterionOperator.OPERATORS_LIST)
            {
                
                if (this._serverCriterionForm.indexOf(_loc_1) == 2)
                {
                    this._operator = new ItemCriterionOperator(_loc_1);
                    this._criterionRef = this._serverCriterionForm.split(_loc_1)[0];
                    this._criterionValue = this._serverCriterionForm.split(_loc_1)[1];
                    this._criterionValueText = this._serverCriterionForm.split(_loc_1)[1];
                }
            }
            return;
        }// end function

        protected function getCriterion() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = PlayedCharacterManager.getInstance();
            switch(this._criterionRef)
            {
                case "Ca":
                {
                    _loc_1 = _loc_2.characteristics.agility.base;
                    break;
                }
                case "CA":
                {
                    _loc_1 = this.getTotalCharac(_loc_2.characteristics.agility);
                    break;
                }
                case "Cc":
                {
                    _loc_1 = _loc_2.characteristics.chance.base;
                    break;
                }
                case "CC":
                {
                    _loc_1 = this.getTotalCharac(_loc_2.characteristics.chance);
                    break;
                }
                case "Ce":
                {
                    _loc_1 = _loc_2.characteristics.energyPoints;
                    break;
                }
                case "CE":
                {
                    _loc_1 = _loc_2.characteristics.maxEnergyPoints;
                    break;
                }
                case "CD":
                {
                    _loc_1 = _loc_2.characteristics.alignmentInfos.dishonor;
                    break;
                }
                case "CH":
                {
                    _loc_1 = _loc_2.characteristics.alignmentInfos.honor;
                    break;
                }
                case "Ci":
                {
                    _loc_1 = _loc_2.characteristics.intelligence.base;
                    break;
                }
                case "CI":
                {
                    _loc_1 = this.getTotalCharac(_loc_2.characteristics.intelligence);
                    break;
                }
                case "CL":
                {
                    _loc_1 = _loc_2.characteristics.lifePoints;
                    break;
                }
                case "CM":
                {
                    _loc_1 = this.getTotalCharac(_loc_2.characteristics.movementPoints);
                    break;
                }
                case "CP":
                {
                    _loc_1 = this.getTotalCharac(_loc_2.characteristics.actionPoints);
                    break;
                }
                case "Cs":
                {
                    _loc_1 = _loc_2.characteristics.strength.base;
                    break;
                }
                case "CS":
                {
                    _loc_1 = this.getTotalCharac(_loc_2.characteristics.strength);
                    break;
                }
                case "Cv":
                {
                    _loc_1 = _loc_2.characteristics.vitality.base;
                    break;
                }
                case "CV":
                {
                    _loc_1 = this.getTotalCharac(_loc_2.characteristics.vitality);
                    break;
                }
                case "Cw":
                {
                    _loc_1 = _loc_2.characteristics.wisdom.base;
                    break;
                }
                case "CW":
                {
                    _loc_1 = this.getTotalCharac(_loc_2.characteristics.wisdom);
                    break;
                }
                case "Ct":
                {
                    _loc_1 = this.getTotalCharac(_loc_2.characteristics.tackleEvade);
                    break;
                }
                case "CT":
                {
                    _loc_1 = this.getTotalCharac(_loc_2.characteristics.tackleBlock);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        private function getTotalCharac(param1:CharacterBaseCharacteristic) : int
        {
            return param1.base + param1.alignGiftBonus + param1.contextModif + param1.objectsAndMountBonus;
        }// end function

    }
}
