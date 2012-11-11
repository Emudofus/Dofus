package com.ankamagames.jerakine.json
{

    public class JSONDecoder extends Object
    {
        private var strict:Boolean;
        private var value:Object;
        private var tokenizer:JSONTokenizer;
        private var token:JSONToken;

        public function JSONDecoder(param1:String, param2:Boolean)
        {
            this.strict = param2;
            this.tokenizer = new JSONTokenizer(param1, param2);
            this.nextToken();
            this.value = this.parseValue();
            if (param2 && this.nextToken() != null)
            {
                this.tokenizer.parseError("Unexpected characters left in input stream");
            }
            return;
        }// end function

        public function getValue()
        {
            return this.value;
        }// end function

        private function nextToken() : JSONToken
        {
            var _loc_1:* = this.tokenizer.getNextToken();
            this.token = this.tokenizer.getNextToken();
            return _loc_1;
        }// end function

        private function parseArray() : Array
        {
            var _loc_1:* = new Array();
            this.nextToken();
            if (this.token.type == JSONTokenType.RIGHT_BRACKET)
            {
                return _loc_1;
            }
            if (!this.strict && this.token.type == JSONTokenType.COMMA)
            {
                this.nextToken();
                if (this.token.type == JSONTokenType.RIGHT_BRACKET)
                {
                    return _loc_1;
                }
                this.tokenizer.parseError("Leading commas are not supported.  Expecting \']\' but found " + this.token.value);
            }
            while (true)
            {
                
                _loc_1.push(this.parseValue());
                this.nextToken();
                if (this.token.type == JSONTokenType.RIGHT_BRACKET)
                {
                    return _loc_1;
                }
                if (this.token.type == JSONTokenType.COMMA)
                {
                    this.nextToken();
                    if (!this.strict)
                    {
                        if (this.token.type == JSONTokenType.RIGHT_BRACKET)
                        {
                            return _loc_1;
                        }
                    }
                    continue;
                }
                this.tokenizer.parseError("Expecting ] or , but found " + this.token.value);
            }
            return null;
        }// end function

        private function parseObject() : Object
        {
            var _loc_2:* = null;
            var _loc_1:* = new Object();
            this.nextToken();
            if (this.token.type == JSONTokenType.RIGHT_BRACE)
            {
                return _loc_1;
            }
            if (!this.strict && this.token.type == JSONTokenType.COMMA)
            {
                this.nextToken();
                if (this.token.type == JSONTokenType.RIGHT_BRACE)
                {
                    return _loc_1;
                }
                this.tokenizer.parseError("Leading commas are not supported.  Expecting \'}\' but found " + this.token.value);
            }
            while (true)
            {
                
                if (this.token.type == JSONTokenType.STRING)
                {
                    _loc_2 = String(this.token.value);
                    this.nextToken();
                    if (this.token.type == JSONTokenType.COLON)
                    {
                        this.nextToken();
                        _loc_1[_loc_2] = this.parseValue();
                        this.nextToken();
                        if (this.token.type == JSONTokenType.RIGHT_BRACE)
                        {
                            return _loc_1;
                        }
                        if (this.token.type == JSONTokenType.COMMA)
                        {
                            this.nextToken();
                            if (!this.strict)
                            {
                                if (this.token.type == JSONTokenType.RIGHT_BRACE)
                                {
                                    return _loc_1;
                                }
                            }
                        }
                        else
                        {
                            this.tokenizer.parseError("Expecting } or , but found " + this.token.value);
                        }
                    }
                    else
                    {
                        this.tokenizer.parseError("Expecting : but found " + this.token.value);
                    }
                    continue;
                }
                this.tokenizer.parseError("Expecting string but found " + this.token.value);
            }
            return null;
        }// end function

        private function parseValue() : Object
        {
            if (this.token == null)
            {
                this.tokenizer.parseError("Unexpected end of input");
            }
            switch(this.token.type)
            {
                case JSONTokenType.LEFT_BRACE:
                {
                    return this.parseObject();
                }
                case JSONTokenType.LEFT_BRACKET:
                {
                    return this.parseArray();
                }
                case JSONTokenType.STRING:
                case JSONTokenType.NUMBER:
                case JSONTokenType.TRUE:
                case JSONTokenType.FALSE:
                case JSONTokenType.NULL:
                {
                    return this.token.value;
                }
                case JSONTokenType.NAN:
                {
                    if (!this.strict)
                    {
                        return this.token.value;
                    }
                    this.tokenizer.parseError("Unexpected " + this.token.value);
                }
                default:
                {
                    this.tokenizer.parseError("Unexpected " + this.token.value);
                    break;
                }
            }
            return null;
        }// end function

    }
}
