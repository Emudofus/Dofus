package com.ankamagames.jerakine.eval
{
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Evaluator extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Evaluator));
        private static const NUMBER:uint = 0;
        private static const STRING:uint = 1;

        public function Evaluator()
        {
            return;
        }// end function

        public function eval(param1:String)
        {
            return this.complexEval(param1);
        }// end function

        private function simpleEval(param1:String)
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_12:* = null;
            var _loc_13:* = undefined;
            var _loc_15:* = false;
            var _loc_16:* = false;
            var _loc_17:* = 0;
            var _loc_3:* = "";
            var _loc_5:* = false;
            var _loc_6:* = false;
            var _loc_7:* = "";
            var _loc_8:* = STRING;
            var _loc_9:* = new Array();
            var _loc_10:* = 0;
            while (_loc_10 < param1.length)
            {
                
                _loc_4 = param1.charAt(_loc_10);
                if (_loc_4 == "\'" && !_loc_6)
                {
                    _loc_8 = STRING;
                    _loc_5 = !_loc_5;
                }
                else if (_loc_4 == "\\")
                {
                    _loc_6 = true;
                }
                else if (!_loc_5)
                {
                    switch(_loc_4)
                    {
                        case "(":
                        case ")":
                        case " ":
                        case "\t":
                        case "\n":
                        {
                            break;
                        }
                        case "0":
                        case "1":
                        case "2":
                        case "3":
                        case "4":
                        case "5":
                        case "6":
                        case "7":
                        case "8":
                        case "9":
                        {
                            _loc_8 = NUMBER;
                            _loc_3 = "";
                            _loc_2 = null;
                            _loc_7 = _loc_7 + _loc_4;
                            break;
                        }
                        case ".":
                        {
                            _loc_7 = _loc_7 + ".";
                            break;
                        }
                        default:
                        {
                            if (_loc_4 == "-" || _loc_4 == "+")
                            {
                                if (!_loc_7.length)
                                {
                                    _loc_7 = _loc_7 + _loc_4;
                                    break;
                                }
                            }
                            _loc_15 = true;
                            _loc_16 = false;
                            _loc_3 = _loc_3 + _loc_4;
                            switch(_loc_3)
                            {
                                case "-":
                                {
                                    _loc_2 = this.minus;
                                    break;
                                }
                                case "+":
                                {
                                    _loc_2 = this.plus;
                                    break;
                                }
                                case "*":
                                {
                                    _loc_2 = this.multiply;
                                    break;
                                }
                                case "/":
                                {
                                    _loc_2 = this.divide;
                                    break;
                                }
                                case ">":
                                {
                                    if (param1.charAt((_loc_10 + 1)) != "=")
                                    {
                                        _loc_2 = this.sup;
                                    }
                                    else
                                    {
                                        _loc_16 = true;
                                        _loc_15 = false;
                                    }
                                    break;
                                }
                                case ">=":
                                {
                                    _loc_2 = this.supOrEquals;
                                    break;
                                }
                                case "<":
                                {
                                    if (param1.charAt((_loc_10 + 1)) != "=")
                                    {
                                        _loc_2 = this.inf;
                                    }
                                    else
                                    {
                                        _loc_16 = true;
                                        _loc_15 = false;
                                    }
                                    break;
                                }
                                case "<=":
                                {
                                    _loc_2 = this.infOrEquals;
                                    break;
                                }
                                case "&&":
                                {
                                    _loc_2 = this.and;
                                    break;
                                }
                                case "||":
                                {
                                    _loc_2 = this.or;
                                    break;
                                }
                                case "==":
                                {
                                    _loc_2 = this.equals;
                                    break;
                                }
                                case "!=":
                                {
                                    _loc_2 = this.diff;
                                    break;
                                }
                                case "?":
                                {
                                    _loc_2 = this.ternary;
                                    break;
                                }
                                case ":":
                                {
                                    _loc_2 = this.opElse;
                                    break;
                                }
                                case "|":
                                case "=":
                                case "&":
                                case "!":
                                {
                                    _loc_16 = true;
                                }
                                default:
                                {
                                    _loc_15 = false;
                                    break;
                                }
                            }
                            if (_loc_15)
                            {
                                if (_loc_7.length)
                                {
                                    if (_loc_8 == STRING)
                                    {
                                        _loc_9.push(_loc_7);
                                    }
                                    else
                                    {
                                        _loc_9.push(parseFloat(_loc_7));
                                    }
                                    _loc_9.push(_loc_2);
                                }
                                else
                                {
                                    _log.warn(this.showPosInExpr(_loc_10, param1));
                                    _log.warn("Expecting Number at char " + _loc_10 + ", but found operator " + _loc_4);
                                }
                                _loc_7 = "";
                            }
                            else if (!_loc_16)
                            {
                                _log.warn(this.showPosInExpr(_loc_10, param1));
                                _log.warn("Bad character at " + _loc_10);
                            }
                            break;
                            break;
                        }
                    }
                }
                else
                {
                    _loc_3 = "";
                    _loc_2 = null;
                    _loc_7 = _loc_7 + _loc_4;
                    _loc_6 = false;
                }
                _loc_10 = _loc_10 + 1;
            }
            if (_loc_7.length)
            {
                if (_loc_8 == STRING)
                {
                    _loc_9.push(_loc_7);
                }
                else
                {
                    _loc_9.push(parseFloat(_loc_7));
                }
            }
            var _loc_11:* = [this.divide, this.multiply, this.minus, this.plus, this.sup, this.inf, this.supOrEquals, this.infOrEquals, this.equals, this.diff, this.and, this.or, this.ternary];
            var _loc_14:* = 0;
            while (_loc_14 < _loc_11.length)
            {
                
                _loc_12 = new Array();
                _loc_17 = 0;
                while (_loc_17 < _loc_9.length)
                {
                    
                    if (_loc_9[_loc_17] is Function && _loc_9[_loc_17] == _loc_11[_loc_14])
                    {
                        _loc_13 = _loc_12[(_loc_12.length - 1)];
                        if (_loc_13 is Number || (_loc_9[_loc_17] == this.plus || _loc_9[_loc_17] == this.ternary || _loc_9[_loc_17] == this.equals || _loc_9[_loc_17] == this.diff) && _loc_13 is String)
                        {
                            if (_loc_9[(_loc_17 + 1)] is Number || (_loc_9[_loc_17] == this.plus || _loc_9[_loc_17] == this.ternary || _loc_9[_loc_17] == this.equals || _loc_9[_loc_17] == this.diff) && _loc_9[(_loc_17 + 1)] is String)
                            {
                                if (_loc_9[_loc_17] === this.ternary)
                                {
                                    if (_loc_9[_loc_17 + 2] == this.opElse)
                                    {
                                        _loc_12[(_loc_12.length - 1)] = this.ternary(_loc_13, _loc_9[(_loc_17 + 1)], _loc_9[_loc_17 + 3]);
                                        _loc_17 = _loc_17 + 2;
                                    }
                                    else
                                    {
                                        _log.warn("operator \':\' not found");
                                    }
                                }
                                else
                                {
                                    var _loc_18:* = _loc_9;
                                    _loc_12[(_loc_12.length - 1)] = _loc_18._loc_9[_loc_17](_loc_13, _loc_9[(_loc_17 + 1)]);
                                }
                            }
                            else
                            {
                                _log.warn("Expect Number, but find [" + _loc_9[(_loc_17 + 1)] + "]");
                            }
                            _loc_17 = _loc_17 + 1;
                        }
                        else
                        {
                            _loc_13 = _loc_9[(_loc_17 - 1)];
                            if (_loc_13 is Number || (_loc_9[_loc_17] == this.plus || _loc_9[_loc_17] == this.ternary || _loc_9[_loc_17] == this.equals || _loc_9[_loc_17] == this.diff) && _loc_13 is String)
                            {
                                if (_loc_9[(_loc_17 + 1)] is Number || (_loc_9[_loc_17] == this.plus || _loc_9[_loc_17] == this.ternary || _loc_9[_loc_17] == this.equals || _loc_9[_loc_17] == this.diff) && _loc_9[(_loc_17 + 1)] is String)
                                {
                                    if (_loc_9[_loc_17] === this.ternary)
                                    {
                                        if (_loc_9[_loc_17 + 2] == this.opElse)
                                        {
                                            _loc_12[(_loc_12.length - 1)] = this.ternary(_loc_13, _loc_9[(_loc_17 + 1)], _loc_9[_loc_17 + 3]);
                                        }
                                        else
                                        {
                                            _log.warn("operator \':\' not found");
                                        }
                                    }
                                    else
                                    {
                                        var _loc_18:* = _loc_9;
                                        _loc_12.push(_loc_18._loc_9[_loc_17](_loc_13, _loc_9[(_loc_17 + 1)]));
                                    }
                                }
                                else
                                {
                                    _log.warn("Expect Number,  but find [" + _loc_9[(_loc_17 + 1)] + "]");
                                }
                                _loc_17 = _loc_17 + 1;
                            }
                        }
                    }
                    else
                    {
                        _loc_12.push(_loc_9[_loc_17]);
                    }
                    _loc_17 = _loc_17 + 1;
                }
                _loc_9 = _loc_12;
                _loc_14 = _loc_14 + 1;
            }
            return _loc_9[0];
        }// end function

        private function complexEval(param1:String)
        {
            var _loc_2:* = 0;
            var _loc_5:* = undefined;
            var _loc_6:* = 0;
            param1 = this.trim(param1);
            var _loc_3:* = true;
            var _loc_4:* = 0;
            while (_loc_3)
            {
                
                _loc_3 = false;
                _loc_6 = 0;
                while (_loc_6 < param1.length)
                {
                    
                    if (param1.charAt(_loc_6) == "(")
                    {
                        if (!_loc_4)
                        {
                            _loc_2 = _loc_6;
                        }
                        _loc_4++;
                    }
                    if (param1.charAt(_loc_6) == ")")
                    {
                        if (!--_loc_4)
                        {
                            _loc_5 = this.complexEval(param1.substr((_loc_2 + 1), _loc_6 - _loc_2 - 1));
                            param1 = param1.substr(0, _loc_2) + (_loc_5 is Number ? (_loc_5) : ("\'" + _loc_5 + "\'")) + param1.substr((_loc_6 + 1));
                            _loc_3 = true;
                            break;
                        }
                    }
                    _loc_6 = _loc_6 + 1;
                }
            }
            if (--_loc_4)
            {
                _log.warn("Missing right parenthesis in " + param1);
            }
            return this.simpleEval(param1);
        }// end function

        private function plus(param1, param2)
        {
            return param1 + param2;
        }// end function

        private function minus(param1:Number, param2:Number) : Number
        {
            return param1 - param2;
        }// end function

        private function multiply(param1:Number, param2:Number) : Number
        {
            return param1 * param2;
        }// end function

        private function divide(param1:Number, param2:Number) : Number
        {
            return param1 / param2;
        }// end function

        private function sup(param1:Number, param2:Number) : Number
        {
            return param1 > param2 ? (1) : (0);
        }// end function

        private function supOrEquals(param1:Number, param2:Number) : Number
        {
            return param1 >= param2 ? (1) : (0);
        }// end function

        private function inf(param1:Number, param2:Number) : Number
        {
            return param1 < param2 ? (1) : (0);
        }// end function

        private function infOrEquals(param1:Number, param2:Number) : Number
        {
            return param1 <= param2 ? (1) : (0);
        }// end function

        private function and(param1:Number, param2:Number) : Number
        {
            return param1 && param2 ? (1) : (0);
        }// end function

        private function or(param1:Number, param2:Number) : Number
        {
            return param1 || param2 ? (1) : (0);
        }// end function

        private function equals(param1, param2) : Number
        {
            return param1 == param2 ? (1) : (0);
        }// end function

        private function diff(param1, param2) : Number
        {
            return param1 != param2 ? (1) : (0);
        }// end function

        private function ternary(param1:Number, param2, param3)
        {
            return param1 ? (param2) : (param3);
        }// end function

        private function opElse() : void
        {
            return;
        }// end function

        private function showPosInExpr(param1:uint, param2:String) : String
        {
            var _loc_3:* = param2 + "\n";
            var _loc_4:* = 0;
            while (_loc_4 < param1)
            {
                
                _loc_3 = _loc_3 + " ";
                _loc_4 = _loc_4 + 1;
            }
            return _loc_3 + "^";
        }// end function

        private function trim(param1:String) : String
        {
            var _loc_5:* = null;
            var _loc_2:* = "";
            var _loc_3:* = false;
            var _loc_4:* = false;
            var _loc_6:* = 0;
            while (_loc_6 < param1.length)
            {
                
                _loc_5 = param1.charAt(_loc_6);
                if (_loc_5 == "\'" && !_loc_3)
                {
                    _loc_4 = !_loc_4;
                }
                if (_loc_5 == "\\")
                {
                    _loc_3 = true;
                }
                else
                {
                    _loc_3 = false;
                }
                if (_loc_5 != " " || _loc_4)
                {
                    _loc_2 = _loc_2 + _loc_5;
                }
                _loc_6 = _loc_6 + 1;
            }
            return _loc_2;
        }// end function

    }
}
