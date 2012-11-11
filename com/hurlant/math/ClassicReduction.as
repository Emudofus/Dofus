package com.hurlant.math
{
    import com.hurlant.math.*;

    class ClassicReduction extends Object implements IReduction
    {
        private var m:BigInteger;

        function ClassicReduction(param1:BigInteger)
        {
            this.m = param1;
            return;
        }// end function

        public function convert(param1:BigInteger) : BigInteger
        {
            if (param1.s < 0 || param1.compareTo(this.m) >= 0)
            {
                return param1.mod(this.m);
            }
            return param1;
        }// end function

        public function revert(param1:BigInteger) : BigInteger
        {
            return param1;
        }// end function

        public function reduce(param1:BigInteger) : void
        {
            param1.divRemTo(this.m, null, param1);
            return;
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

    }
}
