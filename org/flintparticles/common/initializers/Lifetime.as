package org.flintparticles.common.initializers
{
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;

    public class Lifetime extends InitializerBase
    {
        private var _max:Number;
        private var _min:Number;

        public function Lifetime(param1:Number, param2:Number = NaN)
        {
            this._max = param2;
            this._min = param1;
            return;
        }// end function

        public function get minLifetime() : Number
        {
            return this._min;
        }// end function

        public function set minLifetime(param1:Number) : void
        {
            this._min = param1;
            return;
        }// end function

        public function get maxLifetime() : Number
        {
            return this._max;
        }// end function

        public function set maxLifetime(param1:Number) : void
        {
            this._max = param1;
            return;
        }// end function

        public function get lifetime() : Number
        {
            return this._min == this._max ? (this._min) : ((this._max + this._min) * 0.5);
        }// end function

        public function set lifetime(param1:Number) : void
        {
            var _loc_2:* = param1;
            this._min = param1;
            this._max = _loc_2;
            return;
        }// end function

        override public function initialize(param1:Emitter, param2:Particle) : void
        {
            if (isNaN(this._max))
            {
                param2.lifetime = this._min;
            }
            else
            {
                param2.lifetime = this._min + Math.random() * (this._max - this._min);
            }
            return;
        }// end function

    }
}
