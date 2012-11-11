package com.hurlant.math
{
    import com.hurlant.math.*;

    class BarrettReduction extends Object implements IReduction
    {
        private var m:BigInteger;
        private var r2:BigInteger;
        private var q3:BigInteger;
        private var mu:BigInteger;

        function BarrettReduction(param1:BigInteger)
        {
            this.r2 = new BigInteger();
            this.q3 = new BigInteger();
            BigInteger.ONE.dlShiftTo(2 * param1.t, this.r2);
            this.mu = this.r2.divide(param1);
            this.m = param1;
            return;
        }// end function

        public function revert(param1:BigInteger) : BigInteger
        {
            return param1;
        }// end function

        public function mulTo(param1:BigInteger, param2:BigInteger, param3:BigInteger) : void
        {
            param1.multiplyTo(param2, param3);
            this.reduce(param3);
            return;
        }// end function

        public function sqrTo(param1:BigInteger, param2:BigInteger) : void
        {
            param1.squareTo(param2);
            this.reduce(param2);
            return;
        }// end function

        public function convert(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = null;
            if (param1.s < 0 || param1.t > 2 * this.m.t)
            {
                return param1.mod(this.m);
            }
            if (param1.compareTo(this.m) < 0)
            {
                return param1;
            }
            _loc_2 = new BigInteger();
            param1.copyTo(_loc_2);
            this.reduce(_loc_2);
            return _loc_2;
        }// end function

        public function reduce(param1:BigInteger) : void
        {
            var _loc_2:* = param1 as BigInteger;
            _loc_2.drShiftTo((this.m.t - 1), this.r2);
            if (_loc_2.t > (this.m.t + 1))
            {
                _loc_2.t = this.m.t + 1;
                _loc_2.clamp();
            }
            this.mu.multiplyUpperTo(this.r2, (this.m.t + 1), this.q3);
            this.m.multiplyLowerTo(this.q3, (this.m.t + 1), this.r2);
            while (_loc_2.compareTo(this.r2) < 0)
            {
                
                _loc_2.dAddOffset(1, (this.m.t + 1));
            }
            _loc_2.subTo(this.r2, _loc_2);
            while (_loc_2.compareTo(this.m) >= 0)
            {
                
                _loc_2.subTo(this.m, _loc_2);
            }
            return;
        }// end function

    }
}
