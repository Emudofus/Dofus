package org.flintparticles.common.initializers
{
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;

    public class ScaleImageInit extends InitializerBase
    {
        private var _min:Number;
        private var _max:Number;

        public function ScaleImageInit(param1:Number, param2:Number = NaN)
        {
            this._min = param1;
            if (isNaN(param2))
            {
                this._max = this._min;
            }
            else
            {
                this._max = param2;
            }
            return;
        }// end function

        public function get minScale() : Number
        {
            return this._min;
        }// end function

        public function set minScale(param1:Number) : void
        {
            this._min = param1;
            return;
        }// end function

        public function get maxScale() : Number
        {
            return this._max;
        }// end function

        public function set maxScale(param1:Number) : void
        {
            this._max = param1;
            return;
        }// end function

        public function get scale() : Number
        {
            return this._min == this._max ? (this._min) : ((this._max + this._min) / 2);
        }// end function

        public function set scale(param1:Number) : void
        {
            var _loc_2:* = param1;
            this._min = param1;
            this._max = _loc_2;
            return;
        }// end function

        override public function initialize(param1:Emitter, param2:Particle) : void
        {
            if (this._max == this._min)
            {
                param2.scale = this._min;
            }
            else
            {
                param2.scale = this._min + Math.random() * (this._max - this._min);
            }
            return;
        }// end function

    }
}
