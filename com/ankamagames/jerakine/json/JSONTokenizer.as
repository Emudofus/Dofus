package com.ankamagames.jerakine.json
{

    public class JSONTokenizer extends Object
    {
        private var strict:Boolean;
        private var obj:Object;
        private var jsonString:String;
        private var loc:int;
        private var ch:String;
        private var controlCharsRegExp:RegExp;

        public function JSONTokenizer(param1:String, param2:Boolean)
        {
            this.controlCharsRegExp = /[\;
            this.jsonString = param1;
            this.strict = param2;
            this.loc = 0;
            this.nextChar();
            return;
        }// end function

        public function getNextToken() : JSONToken
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = new JSONToken();
            this.skipIgnored();
            switch(this.ch)
            {
                case "{":
                {
                    _loc_1.type = JSONTokenType.LEFT_BRACE;
                    _loc_1.value = "{";
                    this.nextChar();
                    break;
                }
                case "}":
                {
                    _loc_1.type = JSONTokenType.RIGHT_BRACE;
                    _loc_1.value = "}";
                    this.nextChar();
                    break;
                }
                case "[":
                {
                    _loc_1.type = JSONTokenType.LEFT_BRACKET;
                    _loc_1.value = "[";
                    this.nextChar();
                    break;
                }
                case "]":
                {
                    _loc_1.type = JSONTokenType.RIGHT_BRACKET;
                    _loc_1.value = "]";
                    this.nextChar();
                    break;
                }
                case ",":
                {
                    _loc_1.type = JSONTokenType.COMMA;
                    _loc_1.value = ",";
                    this.nextChar();
                    break;
                }
                case ":":
                {
                    _loc_1.type = JSONTokenType.COLON;
                    _loc_1.value = ":";
                    this.nextChar();
                    break;
                }
                case "t":
                {
                    _loc_2 = "t" + this.nextChar() + this.nextChar() + this.nextChar();
                    if (_loc_2 == "true")
                    {
                        _loc_1.type = JSONTokenType.TRUE;
                        _loc_1.value = true;
                        this.nextChar();
                    }
                    else
                    {
                        this.parseError("Expecting \'true\' but found " + _loc_2);
                    }
                    break;
                }
                case "f":
                {
                    _loc_3 = "f" + this.nextChar() + this.nextChar() + this.nextChar() + this.nextChar();
                    if (_loc_3 == "false")
                    {
                        _loc_1.type = JSONTokenType.FALSE;
                        _loc_1.value = false;
                        this.nextChar();
                    }
                    else
                    {
                        this.parseError("Expecting \'false\' but found " + _loc_3);
                    }
                    break;
                }
                case "n":
                {
                    _loc_4 = "n" + this.nextChar() + this.nextChar() + this.nextChar();
                    if (_loc_4 == "null")
                    {
                        _loc_1.type = JSONTokenType.NULL;
                        _loc_1.value = null;
                        this.nextChar();
                    }
                    else
                    {
                        this.parseError("Expecting \'null\' but found " + _loc_4);
                    }
                    break;
                }
                case "N":
                {
                    _loc_5 = "N" + this.nextChar() + this.nextChar();
                    if (_loc_5 == "NaN")
                    {
                        _loc_1.type = JSONTokenType.NAN;
                        _loc_1.value = NaN;
                        this.nextChar();
                    }
                    else
                    {
                        this.parseError("Expecting \'NaN\' but found " + _loc_5);
                    }
                    break;
                }
                case "\"":
                {
                    _loc_1 = this.readString();
                    break;
                }
                default:
                {
                    if (this.isDigit(this.ch) || this.ch == "-")
                    {
                        _loc_1 = this.readNumber();
                    }
                    else
                    {
                        if (this.ch == "")
                        {
                            return null;
                        }
                        this.parseError("Unexpected " + this.ch + " encountered");
                    }
                    break;
                }
            }
            return _loc_1;
        }// end function

        private function readString() : JSONToken
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_1:* = this.loc;
            do
            {
                
                _loc_1 = this.jsonString.indexOf("\"", _loc_1);
                if (_loc_1 >= 0)
                {
                    _loc_3 = 0;
                    _loc_4 = _loc_1 - 1;
                    while (this.jsonString.charAt(_loc_4) == "\\")
                    {
                        
                        _loc_3++;
                        _loc_4 = _loc_4 - 1;
                    }
                    if (_loc_3 % 2 == 0)
                    {
                        break;
                    }
                    _loc_1++;
                    continue;
                }
                this.parseError("Unterminated string literal");
            }while (true)
            var _loc_2:* = new JSONToken();
            _loc_2.type = JSONTokenType.STRING;
            _loc_2.value = this.unescapeString(this.jsonString.substr(this.loc, _loc_1 - this.loc));
            this.loc = _loc_1 + 1;
            this.nextChar();
            return _loc_2;
        }// end function

        public function unescapeString(param1:String) : String
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            if (this.strict && this.controlCharsRegExp.test(param1))
            {
                this.parseError("String contains unescaped control character (0x00-0x1F)");
            }
            var _loc_2:* = "";
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = param1.length;
            do
            {
                
                _loc_3 = param1.indexOf("\\", _loc_4);
                if (_loc_3 >= 0)
                {
                    _loc_2 = _loc_2 + param1.substr(_loc_4, _loc_3 - _loc_4);
                    _loc_4 = _loc_3 + 2;
                    _loc_6 = _loc_3 + 1;
                    _loc_7 = param1.charAt(_loc_6);
                    switch(_loc_7)
                    {
                        case "\"":
                        {
                            _loc_2 = _loc_2 + "\"";
                            break;
                        }
                        case "\\":
                        {
                            _loc_2 = _loc_2 + "\\";
                            break;
                        }
                        case "n":
                        {
                            _loc_2 = _loc_2 + "\n";
                            break;
                        }
                        case "r":
                        {
                            _loc_2 = _loc_2 + "\r";
                            break;
                        }
                        case "t":
                        {
                            _loc_2 = _loc_2 + "\t";
                            break;
                        }
                        case "u":
                        {
                            _loc_8 = "";
                            if (_loc_4 + 4 > _loc_5)
                            {
                                this.parseError("Unexpected end of input.  Expecting 4 hex digits after \\u.");
                            }
                            _loc_9 = _loc_4;
                            while (_loc_9 < _loc_4 + 4)
                            {
                                
                                _loc_10 = param1.charAt(_loc_9);
                                if (!this.isHexDigit(_loc_10))
                                {
                                    this.parseError("Excepted a hex digit, but found: " + _loc_10);
                                }
                                _loc_8 = _loc_8 + _loc_10;
                                _loc_9++;
                            }
                            _loc_2 = _loc_2 + String.fromCharCode(parseInt(_loc_8, 16));
                            _loc_4 = _loc_4 + 4;
                            break;
                        }
                        case "f":
                        {
                            _loc_2 = _loc_2 + "\f";
                            break;
                        }
                        case "/":
                        {
                            _loc_2 = _loc_2 + "/";
                            break;
                        }
                        case "b":
                        {
                            _loc_2 = _loc_2 + "\b";
                            break;
                        }
                        default:
                        {
                            _loc_2 = _loc_2 + ("\\" + _loc_7);
                            break;
                        }
                    }
                    continue;
                }
                _loc_2 = _loc_2 + param1.substr(_loc_4);
                break;
            }while (_loc_4 < _loc_5)
            return _loc_2;
        }// end function

        private function readNumber() : JSONToken
        {
            var _loc_3:* = null;
            var _loc_1:* = "";
            if (this.ch == "-")
            {
                _loc_1 = _loc_1 + "-";
                this.nextChar();
            }
            if (!this.isDigit(this.ch))
            {
                this.parseError("Expecting a digit");
            }
            if (this.ch == "0")
            {
                _loc_1 = _loc_1 + this.ch;
                this.nextChar();
                if (this.isDigit(this.ch))
                {
                    this.parseError("A digit cannot immediately follow 0");
                }
                else if (!this.strict && this.ch == "x")
                {
                    _loc_1 = _loc_1 + this.ch;
                    this.nextChar();
                    if (this.isHexDigit(this.ch))
                    {
                        _loc_1 = _loc_1 + this.ch;
                        this.nextChar();
                    }
                    else
                    {
                        this.parseError("Number in hex format require at least one hex digit after \"0x\"");
                    }
                    while (this.isHexDigit(this.ch))
                    {
                        
                        _loc_1 = _loc_1 + this.ch;
                        this.nextChar();
                    }
                }
            }
            else
            {
                while (this.isDigit(this.ch))
                {
                    
                    _loc_1 = _loc_1 + this.ch;
                    this.nextChar();
                }
            }
            if (this.ch == ".")
            {
                _loc_1 = _loc_1 + ".";
                this.nextChar();
                if (!this.isDigit(this.ch))
                {
                    this.parseError("Expecting a digit");
                }
                while (this.isDigit(this.ch))
                {
                    
                    _loc_1 = _loc_1 + this.ch;
                    this.nextChar();
                }
            }
            if (this.ch == "e" || this.ch == "E")
            {
                _loc_1 = _loc_1 + "e";
                this.nextChar();
                if (this.ch == "+" || this.ch == "-")
                {
                    _loc_1 = _loc_1 + this.ch;
                    this.nextChar();
                }
                if (!this.isDigit(this.ch))
                {
                    this.parseError("Scientific notation number needs exponent value");
                }
                while (this.isDigit(this.ch))
                {
                    
                    _loc_1 = _loc_1 + this.ch;
                    this.nextChar();
                }
            }
            var _loc_2:* = Number(_loc_1);
            if (isFinite(_loc_2) && !isNaN(_loc_2))
            {
                _loc_3 = new JSONToken();
                _loc_3.type = JSONTokenType.NUMBER;
                _loc_3.value = _loc_2;
                return _loc_3;
            }
            this.parseError("Number " + _loc_2 + " is not valid!");
            return null;
        }// end function

        private function nextChar() : String
        {
            var _loc_1:* = this;
            _loc_1.loc = this.loc + 1;
            var _loc_1:* = this.jsonString.charAt(this.loc++);
            this.ch = this.jsonString.charAt(this.loc++);
            return _loc_1;
        }// end function

        private function skipIgnored() : void
        {
            var _loc_1:* = 0;
            do
            {
                
                _loc_1 = this.loc;
                this.skipWhite();
                this.skipComments();
            }while (_loc_1 != this.loc)
            return;
        }// end function

        private function skipComments() : void
        {
            if (this.ch == "/")
            {
                this.nextChar();
                switch(this.ch)
                {
                    case "/":
                    {
                        do
                        {
                            
                            this.nextChar();
                        }while (this.ch != "\n" && this.ch != "")
                        this.nextChar();
                        break;
                    }
                    case "*":
                    {
                        this.nextChar();
                        while (true)
                        {
                            
                            if (this.ch == "*")
                            {
                                this.nextChar();
                                if (this.ch == "/")
                                {
                                    this.nextChar();
                                    break;
                                }
                            }
                            else
                            {
                                this.nextChar();
                            }
                            if (this.ch == "")
                            {
                                this.parseError("Multi-line comment not closed");
                            }
                        }
                        break;
                    }
                    default:
                    {
                        this.parseError("Unexpected " + this.ch + " encountered (expecting \'/\' or \'*\' )");
                        break;
                    }
                }
            }
            return;
        }// end function

        private function skipWhite() : void
        {
            while (this.isWhiteSpace(this.ch))
            {
                
                this.nextChar();
            }
            return;
        }// end function

        private function isWhiteSpace(param1:String) : Boolean
        {
            if (param1 == " " || param1 == "\t" || param1 == "\n" || param1 == "\r")
            {
                return true;
            }
            if (!this.strict && param1.charCodeAt(0) == 160)
            {
                return true;
            }
            return false;
        }// end function

        private function isDigit(param1:String) : Boolean
        {
            return param1 >= "0" && param1 <= "9";
        }// end function

        private function isHexDigit(param1:String) : Boolean
        {
            return this.isDigit(param1) || param1 >= "A" && param1 <= "F" || param1 >= "a" && param1 <= "f";
        }// end function

        public function parseError(param1:String) : void
        {
            throw new JSONParseError(param1, this.loc, this.jsonString);
        }// end function

    }
}
