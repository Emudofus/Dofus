package com.ankamagames.jerakine.utils.prng
{
    import com.ankamagames.jerakine.utils.prng.*;

    public class ParkMillerCarta extends Object implements PRNG
    {
        private var _seed:uint;

        public function ParkMillerCarta()
        {
            return;
        }// end function

        public function seed(param1:uint) : void
        {
            this._seed = param1;
            return;
        }// end function

        public function nextInt() : uint
        {
            return this.gen();
        }// end function

        public function nextDouble() : Number
        {
            return this.gen() / 2147483647;
        }// end function

        public function nextIntR(param1:Number, param2:Number) : uint
        {
            param1 = param1 - 0.4999;
            param2 = param2 + 0.4999;
            return Math.round(param1 + (param2 - param1) * this.nextDouble());
        }// end function

        public function nextDoubleR(param1:Number, param2:Number) : Number
        {
            return param1 + (param2 - param1) * this.nextDouble();
        }// end function

        private function gen() : uint
        {
            var _loc_1:* = 16807 * (this._seed >> 16);
            var _loc_2:* = 16807 * (this._seed & 65535) + ((_loc_1 & 32767) << 16) + (_loc_1 >> 15);
            var _loc_3:* = _loc_2 > 2147483647 ? (_loc_2 - 2147483647) : (_loc_2);
            this._seed = _loc_2 > 2147483647 ? (_loc_2 - 2147483647) : (_loc_2);
            return _loc_3;
        }// end function

    }
}
