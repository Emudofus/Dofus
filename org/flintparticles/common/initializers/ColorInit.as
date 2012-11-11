package org.flintparticles.common.initializers
{
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;
    import org.flintparticles.common.utils.*;

    public class ColorInit extends InitializerBase
    {
        private var _min:uint;
        private var _max:uint;

        public function ColorInit(param1:uint, param2:uint)
        {
            this._min = param1;
            this._max = param2;
            return;
        }// end function

        public function get minColor() : uint
        {
            return this._min;
        }// end function

        public function set minColor(param1:uint) : void
        {
            this._min = param1;
            return;
        }// end function

        public function get maxColor() : uint
        {
            return this._max;
        }// end function

        public function set maxColor(param1:uint) : void
        {
            this._max = param1;
            return;
        }// end function

        public function get color() : uint
        {
            return this._min == this._max ? (this._min) : (interpolateColors(this._max, this._min, 0.5));
        }// end function

        public function set color(param1:uint) : void
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
                param2.color = this._min;
            }
            else
            {
                param2.color = interpolateColors(this._min, this._max, Math.random());
            }
            return;
        }// end function

    }
}
