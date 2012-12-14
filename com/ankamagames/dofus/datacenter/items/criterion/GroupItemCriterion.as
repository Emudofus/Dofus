package com.ankamagames.dofus.datacenter.items.criterion
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.items.criterion.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.utils.*;

    public class GroupItemCriterion extends Object implements IItemCriterion, IDataCenter
    {
        private var _criteria:Vector.<IItemCriterion>;
        private var _operators:Vector.<String>;
        private var _criterionTextForm:String;
        private var _cleanCriterionTextForm:String;
        private var _malformated:Boolean = false;
        private var _singleOperatorType:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(GroupItemCriterion));

        public function GroupItemCriterion(param1:String)
        {
            this._criterionTextForm = param1;
            this._cleanCriterionTextForm = this._criterionTextForm;
            if (!param1)
            {
                return;
            }
            this._cleanCriterionTextForm = StringUtils.replace(this._cleanCriterionTextForm, " ", "");
            var _loc_2:* = StringUtils.getDelimitedText(this._cleanCriterionTextForm, "(", ")", true);
            if (_loc_2.length > 0 && _loc_2[0] == this._cleanCriterionTextForm)
            {
                this._cleanCriterionTextForm = this._cleanCriterionTextForm.slice(1);
                this._cleanCriterionTextForm = this._cleanCriterionTextForm.slice(0, (this._cleanCriterionTextForm.length - 1));
            }
            this.split();
            this.createNewGroups();
            return;
        }// end function

        public function get criteria() : Vector.<IItemCriterion>
        {
            return this._criteria;
        }// end function

        public function get inlineCriteria() : Vector.<IItemCriterion>
        {
            var _loc_2:* = null;
            var _loc_1:* = new Vector.<IItemCriterion>;
            for each (_loc_2 in this._criteria)
            {
                
                _loc_1 = _loc_1.concat(_loc_2.inlineCriteria);
            }
            return _loc_1;
        }// end function

        public function get isRespected() : Boolean
        {
            var _loc_1:* = null;
            if (!this._criteria || this._criteria.length == 0)
            {
                return true;
            }
            if (this._criteria && this._criteria.length == 1 && this._criteria[0] is ItemCriterion)
            {
                return (this._criteria[0] as ItemCriterion).isRespected;
            }
            if (this._operators[0] == "|")
            {
                for each (_loc_1 in this._criteria)
                {
                    
                    if (_loc_1.isRespected)
                    {
                        return true;
                    }
                }
                return false;
            }
            else
            {
                for each (_loc_1 in this._criteria)
                {
                    
                    if (!_loc_1.isRespected)
                    {
                        return false;
                    }
                }
            }
            return true;
        }// end function

        public function get text() : String
        {
            var _loc_6:* = undefined;
            var _loc_1:* = "";
            if (this._criteria == null)
            {
                return _loc_1;
            }
            var _loc_2:* = this._criteria.length + this._operators.length;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_2)
            {
                
                _loc_6 = _loc_5 % 2;
                if (_loc_6 == 0)
                {
                    _loc_1 = _loc_1 + (this._criteria[_loc_3++] as IItemCriterion).text + " ";
                }
                else
                {
                    _loc_1 = _loc_1 + this._operators[_loc_4++] + " ";
                }
                _loc_5 = _loc_5 + 1;
            }
            return _loc_1;
        }// end function

        public function get basicText() : String
        {
            return this._criterionTextForm;
        }// end function

        public function clone() : IItemCriterion
        {
            var _loc_1:* = new GroupItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        private function createNewGroups() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = false;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (this._malformated || !this._criteria || this._criteria.length <= 2 || this._singleOperatorType)
            {
                return;
            }
            var _loc_1:* = new Vector.<IItemCriterion>;
            var _loc_2:* = new Vector.<String>;
            for each (_loc_3 in this._criteria)
            {
                
                _loc_1.push(_loc_3.clone());
            }
            for each (_loc_4 in this._operators)
            {
                
                _loc_2.push(_loc_4);
            }
            _loc_5 = 0;
            _loc_6 = false;
            while (!_loc_6)
            {
                
                if (_loc_1.length <= 2)
                {
                    _loc_6 = true;
                    continue;
                }
                if (_loc_2[_loc_5] == "&")
                {
                    _loc_7 = new Vector.<IItemCriterion>;
                    _loc_7.push(_loc_1[_loc_5]);
                    _loc_7.push(_loc_1[(_loc_5 + 1)]);
                    _loc_8 = this.Vector.<String>([_loc_2[_loc_5]]);
                    _loc_9 = GroupItemCriterion.create(_loc_7, _loc_8);
                    _loc_1.splice(_loc_5, 2, _loc_9);
                    _loc_2.splice(_loc_5, 1);
                    _loc_5 = _loc_5 - 1;
                }
                _loc_5++;
                if (_loc_5 >= _loc_2.length)
                {
                    _loc_6 = true;
                }
            }
            this._criteria = _loc_1;
            this._operators = _loc_2;
            this._singleOperatorType = this.checkSingleOperatorType(this._operators);
            return;
        }// end function

        private function split() : void
        {
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            if (!this._cleanCriterionTextForm)
            {
                return;
            }
            var _loc_1:* = 0;
            var _loc_2:* = 1;
            var _loc_3:* = _loc_1;
            var _loc_4:* = false;
            var _loc_5:* = this._cleanCriterionTextForm;
            this._criteria = new Vector.<IItemCriterion>;
            this._operators = new Vector.<String>;
            var _loc_6:* = StringUtils.getAllIndexOf("&", _loc_5);
            var _loc_7:* = StringUtils.getAllIndexOf("|", _loc_5);
            if (_loc_6.length == 0 || _loc_7.length == 0)
            {
                this._singleOperatorType = true;
                while (!_loc_4)
                {
                    
                    _loc_8 = this.getFirstCriterion(_loc_5);
                    if (!_loc_8)
                    {
                        _loc_4 = true;
                        continue;
                    }
                    this._criteria.push(_loc_8);
                    _loc_9 = _loc_5.indexOf(_loc_8.basicText);
                    _loc_10 = _loc_5.slice(_loc_9 + _loc_8.basicText.length, (_loc_9 + 1) + _loc_8.basicText.length);
                    if (_loc_10)
                    {
                        this._operators.push(_loc_10);
                    }
                    _loc_5 = _loc_5.slice((_loc_9 + 1) + _loc_8.basicText.length);
                }
            }
            else
            {
                while (!_loc_4)
                {
                    
                    if (!_loc_5)
                    {
                        _loc_4 = true;
                        continue;
                    }
                    if (_loc_3 == _loc_1)
                    {
                        _loc_11 = this.getFirstCriterion(_loc_5);
                        if (!_loc_11)
                        {
                            _loc_4 = true;
                        }
                        else
                        {
                            this._criteria.push(_loc_11);
                            _loc_3 = _loc_2;
                            _loc_12 = _loc_5.indexOf(_loc_11.basicText);
                            _loc_13 = _loc_5.slice(0, _loc_12);
                            _loc_14 = _loc_5.slice(_loc_12 + _loc_11.basicText.length);
                            _loc_5 = _loc_13 + _loc_14;
                        }
                        continue;
                    }
                    _loc_15 = _loc_5.slice(0, 1);
                    if (!_loc_15)
                    {
                        _loc_4 = true;
                        continue;
                    }
                    this._operators.push(_loc_15);
                    _loc_3 = _loc_1;
                    _loc_5 = _loc_5.slice(1);
                }
                this._singleOperatorType = this.checkSingleOperatorType(this._operators);
            }
            if (this._operators.length >= this._criteria.length && (this._operators.length > 0 && this._criteria.length > 0))
            {
                this._malformated = true;
            }
            return;
        }// end function

        private function checkSingleOperatorType(param1:Vector.<String>) : Boolean
        {
            var _loc_2:* = null;
            if (param1.length > 0)
            {
                for each (_loc_2 in param1)
                {
                    
                    if (_loc_2 != param1[0])
                    {
                        return false;
                    }
                }
            }
            return true;
        }// end function

        private function getFirstCriterion(param1:String) : IItemCriterion
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (!param1)
            {
                return null;
            }
            param1 = StringUtils.replace(param1, " ", "");
            if (param1.slice(0, 1) == "(")
            {
                _loc_3 = StringUtils.getDelimitedText(param1, "(", ")", true);
                _loc_2 = new GroupItemCriterion(_loc_3[0]);
            }
            else
            {
                _loc_4 = param1.indexOf("&");
                _loc_5 = param1.indexOf("|");
                if (_loc_4 == -1 && _loc_5 == -1)
                {
                    _loc_2 = ItemCriterionFactory.create(param1);
                }
                else if ((_loc_4 < _loc_5 || _loc_5 == -1) && _loc_4 != -1)
                {
                    _loc_2 = ItemCriterionFactory.create(param1.split("&")[0]);
                }
                else
                {
                    _loc_2 = ItemCriterionFactory.create(param1.split("|")[0]);
                }
            }
            return _loc_2;
        }// end function

        public function get operators() : Vector.<String>
        {
            return this._operators;
        }// end function

        public static function create(param1:Vector.<IItemCriterion>, param2:Vector.<String>) : GroupItemCriterion
        {
            var _loc_9:* = undefined;
            var _loc_3:* = param1.length + param2.length;
            var _loc_4:* = "";
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_3)
            {
                
                _loc_9 = _loc_7 % 2;
                if (_loc_9 == 0)
                {
                    _loc_4 = _loc_4 + (param1[_loc_5++] as IItemCriterion).basicText;
                }
                else
                {
                    _loc_4 = _loc_4 + param2[_loc_6++];
                }
                _loc_7 = _loc_7 + 1;
            }
            var _loc_8:* = new GroupItemCriterion(_loc_4);
            return new GroupItemCriterion(_loc_4);
        }// end function

    }
}
