package com.ankamagames.jerakine.network.utils.types
{
    public final class Int64 extends Binary64 
    {

        public function Int64(low:uint=0, high:int=0)
        {
            super(low, high);
        }

        public static function fromNumber(n:Number):Int64
        {
            return (new (Int64)(n, Math.floor((n / 4294967296))));
        }

        public static function parseInt64(str:String, radix:uint=0):Int64
        {
            var digit:uint;
            var negative:Boolean = (str.search(/^\-/) == 0);
            var i:uint = ((negative) ? 1 : 0);
            if (radix == 0)
            {
                if (str.search(/^\-?0x/) == 0)
                {
                    radix = 16;
                    i = (i + 2);
                }
                else
                {
                    radix = 10;
                };
            };
            if ((((radix < 2)) || ((radix > 36))))
            {
                throw (new ArgumentError());
            };
            str = str.toLowerCase();
            var result:Int64 = new (Int64)();
            while (i < str.length)
            {
                digit = str.charCodeAt(i);
                if ((((digit >= CHAR_CODE_0)) && ((digit <= CHAR_CODE_9))))
                {
                    digit = (digit - CHAR_CODE_0);
                }
                else
                {
                    if ((((digit >= CHAR_CODE_A)) && ((digit <= CHAR_CODE_Z))))
                    {
                        digit = (digit - CHAR_CODE_A);
                        digit = (digit + 10);
                    }
                    else
                    {
                        throw (new ArgumentError());
                    };
                };
                if (digit >= radix)
                {
                    throw (new ArgumentError());
                };
                result.mul(radix);
                result.add(digit);
                i++;
            };
            if (negative)
            {
                result.bitwiseNot();
                result.add(1);
            };
            return (result);
        }


        final public function set high(value:int):void
        {
            internalHigh = value;
        }

        final public function get high():int
        {
            return (internalHigh);
        }

        final public function toNumber():Number
        {
            return (((this.high * 4294967296) + low));
        }

        final public function toString(radix:uint=10):String
        {
            var _local_4:uint;
            if ((((radix < 2)) || ((radix > 36))))
            {
                throw (new ArgumentError());
            };
            switch (this.high)
            {
                case 0:
                    return (low.toString(radix));
                case -1:
                    if ((low & 0x80000000) == 0)
                    {
                        return ((int((low | 0x80000000)) - 0x80000000).toString(radix));
                    };
                    return (int(low).toString(radix));
            };
            if ((((low == 0)) && ((this.high == 0))))
            {
                return ("0");
            };
            var digitChars:Array = [];
            var copyOfThis:UInt64 = new UInt64(low, this.high);
            if (this.high < 0)
            {
                copyOfThis.bitwiseNot();
                copyOfThis.add(1);
            };
            do 
            {
                _local_4 = copyOfThis.div(radix);
                if (_local_4 < 10)
                {
                    digitChars.push((_local_4 + CHAR_CODE_0));
                }
                else
                {
                    digitChars.push(((_local_4 - 10) + CHAR_CODE_A));
                };
            } while (copyOfThis.high != 0);
            if (this.high < 0)
            {
                return ((("-" + copyOfThis.low.toString(radix)) + String.fromCharCode.apply(String, digitChars.reverse())));
            };
            return ((copyOfThis.low.toString(radix) + String.fromCharCode.apply(String, digitChars.reverse())));
        }


    }
}//package com.ankamagames.jerakine.network.utils.types

