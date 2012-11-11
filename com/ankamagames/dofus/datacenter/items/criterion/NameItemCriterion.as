package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class NameItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function NameItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = I18n.getUiText("ui.common.name");
            return _loc_1 + " " + this.getReadableOperator();
        }// end function

        override public function get isRespected() : Boolean
        {
            var _loc_1:* = PlayedCharacterManager.getInstance().infos.name;
            var _loc_2:* = false;
            var _loc_3:* = _criterionValue.toString();
            switch(_operator.text)
            {
                case "=":
                {
                    _loc_2 = _loc_1 == _loc_3;
                    break;
                }
                case "!":
                {
                    _loc_2 = _loc_1 != _loc_3;
                    break;
                }
                case "~":
                {
                    _loc_2 = _loc_1.toLowerCase() == _loc_3.toLowerCase();
                    break;
                }
                case "S":
                {
                    _loc_2 = _loc_1.toLowerCase().indexOf(_loc_3.toLowerCase()) == 0;
                    break;
                }
                case "s":
                {
                    _loc_2 = _loc_1.indexOf(_loc_3) == 0;
                    break;
                }
                case "E":
                {
                    _loc_2 = _loc_1.toLowerCase().indexOf(_loc_3.toLowerCase()) == _loc_1.length - _loc_3.length;
                    break;
                }
                case "e":
                {
                    _loc_2 = _loc_1.indexOf(_loc_3) == _loc_1.length - _loc_3.length;
                    break;
                }
                case "v":
                {
                    break;
                }
                case "i":
                {
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
            var _loc_1:* = new NameItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return 0;
        }// end function

        private function getReadableOperator() : String
        {
            var _loc_1:* = "";
            _log.debug("operator : " + _operator);
            switch(_operator.text)
            {
                case "!":
                case "=":
                {
                    _loc_1 = _operator.text + " " + _criterionValueText;
                    break;
                }
                case "~":
                {
                    _loc_1 = "= " + _criterionValueText;
                    break;
                }
                case "S":
                case "s":
                {
                    _loc_1 = I18n.getUiText("ui.criterion.startWith", [_criterionValueText]);
                    break;
                }
                case "E":
                case "e":
                {
                    _loc_1 = I18n.getUiText("ui.criterion.endWith", [_criterionValueText]);
                    break;
                }
                case "v":
                {
                    _loc_1 = I18n.getUiText("ui.criterion.valid");
                    break;
                }
                case "i":
                {
                    _loc_1 = I18n.getUiText("ui.criterion.invalid");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

    }
}
