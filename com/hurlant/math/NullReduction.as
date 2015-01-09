package com.hurlant.math
{
    import com.hurlant.math.bi_internal; 

    use namespace bi_internal;

    public class NullReduction implements IReduction 
    {


        public function revert(x:BigInteger):BigInteger
        {
            return (x);
        }

        public function mulTo(x:BigInteger, y:BigInteger, r:BigInteger):void
        {
            x.multiplyTo(y, r);
        }

        public function sqrTo(x:BigInteger, r:BigInteger):void
        {
            x.squareTo(r);
        }

        public function convert(x:BigInteger):BigInteger
        {
            return (x);
        }

        public function reduce(x:BigInteger):void
        {
        }


    }
}//package com.hurlant.math

