package com.hurlant.math
{
    import com.hurlant.math.*;

    class MontgomeryReduction extends Object implements IReduction
    {
        private var m:BigInteger;
        private var mp:int;
        private var mpl:int;
        private var mph:int;
        private var um:int;
        private var mt2:int;

        function MontgomeryReduction(param1:BigInteger)
        {
            this.m = param1;
            this.mp = param1.invDigit();
            this.mpl = this.mp & 32767;
            this.mph = this.mp >> 15;
            this.um = (1 << BigInteger.DB - 15) - 1;
            this.mt2 = 2 * param1.t;
            return;
        }// end function

        public function convert(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = new BigInteger();
            param1.abs().dlShiftTo(this.m.t, _loc_2);
            _loc_2.divRemTo(this.m, null, _loc_2);
            if (param1.s < 0 && _loc_2.compareTo(BigInteger.ZERO) > 0)
            {
                this.m.subTo(_loc_2, _loc_2);
            }
            return _loc_2;
        }// end function

        public function revert(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = new BigInteger();
            param1.copyTo(_loc_2);
            this.reduce(_loc_2);
            return _loc_2;
        }// end function

        public function reduce(param1:BigInteger) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            while (param1.t <= this.mt2)
            {
                
                var _loc_6:* = param1;
                _loc_6.t = param1.t + 1;
                param1.a[++param1.t] = 0;
            }
            var _loc_2:int = 0;
            while (_loc_2 < this.m.t)
            {
                
                _loc_3 = param1.a[_loc_2] & 32767;
                _loc_4 = _loc_3 * this.mpl + ((_loc_3 * this.mph + (param1.a[_loc_2] >> 15) * this.mpl & this.um) << 15) & BigInteger.DM;
                _loc_3 = _loc_2 + this.m.t;
                param1.a[_loc_3] = param1.a[_loc_3] + this.m.am(0, _loc_4, param1, _loc_2, 0, this.m.t);
                while (param1.a[++_loc_3] >= BigInteger.DV)
                {
                    
                    param1.a[_loc_3] = param1.a[_loc_3] - BigInteger.DV;
                    var _loc_5:* = param1.a;
                    var _loc_7:* = param1.a[++_loc_3] + 1;
                    _loc_5[++_loc_3] = _loc_7;
                }
                _loc_2++;
            }
            param1.clamp();
            param1.drShiftTo(this.m.t, param1);
            if (param1.compareTo(this.m) >= 0)
            {
                param1.subTo(this.m, param1);
            }
            return;
        }// end function

        public function sqrTo(param1:BigInteger, param2:BigInteger) : void
        {
            param1.squareTo(param2);
            this.reduce(param2);
            return;
        }// end function

        public function mulTo(param1:BigInteger, param2:BigInteger, param3:BigInteger) : void
        {
            param1.multiplyTo(param2, param3);
            this.reduce(param3);
            return;
        }// end function

    }
}
