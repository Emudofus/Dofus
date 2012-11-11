package nochump.util.zip
{
    import flash.events.*;
    import flash.utils.*;

    public class Inflater extends EventDispatcher
    {
        private var inbuf:ByteArray;
        private var incnt:uint;
        private var bitbuf:int;
        private var bitcnt:int;
        private var lencode:Object;
        private var distcode:Object;
        private var _running:Boolean;
        private static const MAXBITS:int = 15;
        private static const MAXLCODES:int = 286;
        private static const MAXDCODES:int = 30;
        private static const MAXCODES:int = 316;
        private static const FIXLCODES:int = 288;
        private static const LENS:Array = [3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258];
        private static const LEXT:Array = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0];
        private static const DISTS:Array = [1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577];
        private static const DEXT:Array = [0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13];

        public function Inflater()
        {
            return;
        }// end function

        public function setInput(param1:ByteArray) : void
        {
            this.inbuf = param1;
            this.inbuf.endian = Endian.LITTLE_ENDIAN;
            return;
        }// end function

        public function inflate(param1:ByteArray, param2:Function) : uint
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (!this._running)
            {
                var _loc_9:* = 0;
                this.bitcnt = 0;
                this.bitbuf = _loc_9;
                this.incnt = _loc_9;
            }
            this._running = true;
            var _loc_3:* = param2 != null;
            var _loc_4:* = getTimer();
            var _loc_5:* = 0;
            var _loc_6:* = param1.length;
            do
            {
                
                if (_loc_3 && getTimer() - _loc_4 > 24)
                {
                    dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, param1.length));
                    setTimeout(this.inflate, 1, param1, param2);
                    return 0;
                }
                _loc_7 = this.bits(1);
                _loc_8 = this.bits(2);
                if (_loc_8 == 0)
                {
                    this.stored(param1);
                }
                else
                {
                    if (_loc_8 == 3)
                    {
                        throw new Error("invalid block type (type == 3)", -1);
                    }
                    this.lencode = {count:[], symbol:[]};
                    this.distcode = {count:[], symbol:[]};
                    if (_loc_8 == 1)
                    {
                        this.constructFixedTables();
                    }
                    else if (_loc_8 == 2)
                    {
                        _loc_5 = this.constructDynamicTables();
                    }
                    if (_loc_5 != 0)
                    {
                        return _loc_5;
                    }
                    _loc_5 = this.codes(param1);
                }
                if (_loc_5 != 0)
                {
                    break;
                }
            }while (!_loc_7)
            this._running = false;
            if (_loc_3)
            {
                this.param2(param1);
            }
            return _loc_5;
        }// end function

        private function bits(param1:int) : int
        {
            var _loc_2:* = this.bitbuf;
            while (this.bitcnt < param1)
            {
                
                if (this.incnt == this.inbuf.length)
                {
                    throw new Error("available inflate data did not terminate", 2);
                }
                var _loc_3:* = this;
                _loc_3.incnt = this.incnt + 1;
                _loc_2 = _loc_2 | this.inbuf[this.incnt++] << this.bitcnt;
                this.bitcnt = this.bitcnt + 8;
            }
            this.bitbuf = _loc_2 >> param1;
            this.bitcnt = this.bitcnt - param1;
            return _loc_2 & (1 << param1) - 1;
        }// end function

        private function construct(param1:Object, param2:Array, param3:int) : int
        {
            var _loc_4:* = [];
            var _loc_5:* = 0;
            while (_loc_5 <= MAXBITS)
            {
                
                param1.count[_loc_5] = 0;
                _loc_5++;
            }
            var _loc_6:* = 0;
            while (_loc_6 < param3)
            {
                
                var _loc_8:* = param1.count;
                var _loc_9:* = param2[_loc_6];
                var _loc_10:* = param1.count[param2[_loc_6]] + 1;
                _loc_8[_loc_9] = _loc_10;
                _loc_6++;
            }
            if (param1.count[0] == param3)
            {
                return 0;
            }
            var _loc_7:* = 1;
            _loc_5 = 1;
            while (_loc_5 <= MAXBITS)
            {
                
                _loc_7 = _loc_7 << 1;
                _loc_7 = _loc_7 - param1.count[_loc_5];
                if (_loc_7 < 0)
                {
                    return _loc_7;
                }
                _loc_5++;
            }
            _loc_4[1] = 0;
            _loc_5 = 1;
            while (_loc_5 < MAXBITS)
            {
                
                _loc_4[(_loc_5 + 1)] = _loc_4[_loc_5] + param1.count[_loc_5];
                _loc_5++;
            }
            _loc_6 = 0;
            while (_loc_6 < param3)
            {
                
                if (param2[_loc_6] != 0)
                {
                    var _loc_9:* = _loc_4;
                    var _loc_10:* = param2[_loc_6];
                    _loc_9[_loc_10] = _loc_4[param2[_loc_6]] + 1;
                    param1.symbol[++_loc_4[param2[_loc_6]]] = _loc_6;
                }
                _loc_6++;
            }
            return _loc_7;
        }// end function

        private function decode(param1:Object) : int
        {
            var _loc_6:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 1;
            while (_loc_5 <= MAXBITS)
            {
                
                _loc_2 = _loc_2 | this.bits(1);
                _loc_6 = param1.count[_loc_5];
                if (_loc_2 < _loc_3 + _loc_6)
                {
                    return param1.symbol[_loc_4 + (_loc_2 - _loc_3)];
                }
                _loc_4 = _loc_4 + _loc_6;
                _loc_3 = _loc_3 + _loc_6;
                _loc_3 = _loc_3 << 1;
                _loc_2 = _loc_2 << 1;
                _loc_5++;
            }
            return -9;
        }// end function

        private function codes(param1:ByteArray) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            do
            {
                
                _loc_2 = this.decode(this.lencode);
                if (_loc_2 < 0)
                {
                    return _loc_2;
                }
                if (_loc_2 < 256)
                {
                    param1[param1.length] = _loc_2;
                    continue;
                }
                if (_loc_2 > 256)
                {
                    _loc_2 = _loc_2 - 257;
                    if (_loc_2 >= 29)
                    {
                        throw new Error("invalid literal/length or distance code in fixed or dynamic block", -9);
                    }
                    _loc_3 = LENS[_loc_2] + this.bits(LEXT[_loc_2]);
                    _loc_2 = this.decode(this.distcode);
                    if (_loc_2 < 0)
                    {
                        return _loc_2;
                    }
                    _loc_4 = DISTS[_loc_2] + this.bits(DEXT[_loc_2]);
                    if (_loc_4 > param1.length)
                    {
                        throw new Error("distance is too far back in fixed or dynamic block", -10);
                    }
                    while (_loc_3--)
                    {
                        
                        param1[param1.length] = param1[param1.length - _loc_4];
                    }
                }
            }while (_loc_2 != 256)
            return 0;
        }// end function

        private function stored(param1:ByteArray) : void
        {
            this.bitbuf = 0;
            this.bitcnt = 0;
            if (this.incnt + 4 > this.inbuf.length)
            {
                throw new Error("available inflate data did not terminate", 2);
            }
            var _loc_3:* = this;
            _loc_3.incnt = this.incnt + 1;
            var _loc_2:* = this.inbuf[this.incnt++];
            var _loc_3:* = this;
            _loc_3.incnt = this.incnt + 1;
            _loc_2 = _loc_2 | this.inbuf[this.incnt++] << 8;
            var _loc_3:* = this;
            _loc_3.incnt = this.incnt + 1;
            var _loc_3:* = this;
            _loc_3.incnt = this.incnt + 1;
            if (this.inbuf[this.incnt++] != (~_loc_2 & 255) || this.inbuf[this.incnt++] != (~_loc_2 >> 8 & 255))
            {
                throw new Error("stored block length did not match one\'s complement", -2);
            }
            if (this.incnt + _loc_2 > this.inbuf.length)
            {
                throw new Error("available inflate data did not terminate", 2);
            }
            while (_loc_2--)
            {
                
                var _loc_3:* = this;
                _loc_3.incnt = this.incnt + 1;
                param1[param1.length] = this.inbuf[this.incnt++];
            }
            return;
        }// end function

        private function constructFixedTables() : void
        {
            var _loc_1:* = [];
            var _loc_2:* = 0;
            while (_loc_2 < 144)
            {
                
                _loc_1[_loc_2] = 8;
                _loc_2++;
            }
            while (_loc_2 < 256)
            {
                
                _loc_1[_loc_2] = 9;
                _loc_2++;
            }
            while (_loc_2 < 280)
            {
                
                _loc_1[_loc_2] = 7;
                _loc_2++;
            }
            while (_loc_2 < FIXLCODES)
            {
                
                _loc_1[_loc_2] = 8;
                _loc_2++;
            }
            this.construct(this.lencode, _loc_1, FIXLCODES);
            _loc_2 = 0;
            while (_loc_2 < MAXDCODES)
            {
                
                _loc_1[_loc_2] = 5;
                _loc_2++;
            }
            this.construct(this.distcode, _loc_1, MAXDCODES);
            return;
        }// end function

        private function constructDynamicTables() : int
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_1:* = [];
            var _loc_2:* = [16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15];
            var _loc_3:* = this.bits(5) + 257;
            var _loc_4:* = this.bits(5) + 1;
            var _loc_5:* = this.bits(4) + 4;
            if (_loc_3 > MAXLCODES || _loc_4 > MAXDCODES)
            {
                throw new Error("dynamic block code description: too many length or distance codes", -3);
            }
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_1[_loc_2[_loc_6]] = this.bits(3);
                _loc_6++;
            }
            while (_loc_6 < 19)
            {
                
                _loc_1[_loc_2[_loc_6]] = 0;
                _loc_6++;
            }
            var _loc_7:* = this.construct(this.lencode, _loc_1, 19);
            if (this.construct(this.lencode, _loc_1, 19) != 0)
            {
                throw new Error("dynamic block code description: code lengths codes incomplete", -4);
            }
            _loc_6 = 0;
            while (_loc_6 < _loc_3 + _loc_4)
            {
                
                _loc_8 = this.decode(this.lencode);
                if (_loc_8 < 16)
                {
                    _loc_1[++_loc_6] = _loc_8;
                    continue;
                }
                _loc_9 = 0;
                if (_loc_8 == 16)
                {
                    if (_loc_6 == 0)
                    {
                        throw new Error("dynamic block code description: repeat lengths with no first length", -5);
                    }
                    _loc_9 = _loc_1[(_loc_6 - 1)];
                    _loc_8 = 3 + this.bits(2);
                }
                else if (_loc_8 == 17)
                {
                    _loc_8 = 3 + this.bits(3);
                }
                else
                {
                    _loc_8 = 11 + this.bits(7);
                }
                if (_loc_6 + _loc_8 > _loc_3 + _loc_4)
                {
                    throw new Error("dynamic block code description: repeat more than specified lengths", -6);
                }
                while (_loc_8--)
                {
                    
                    _loc_1[++_loc_6] = _loc_9;
                }
            }
            _loc_7 = this.construct(this.lencode, _loc_1, _loc_3);
            if (_loc_7 < 0 || _loc_7 > 0 && _loc_3 - this.lencode.count[0] != 1)
            {
                throw new Error("dynamic block code description: invalid literal/length code lengths", -7);
            }
            _loc_7 = this.construct(this.distcode, _loc_1.slice(_loc_3), _loc_4);
            if (_loc_7 < 0 || _loc_7 > 0 && _loc_4 - this.distcode.count[0] != 1)
            {
                throw new Error("dynamic block code description: invalid distance code lengths", -8);
            }
            return _loc_7;
        }// end function

    }
}
