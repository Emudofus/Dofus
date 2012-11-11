package org.flintparticles.common.actions
{
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;

    public class Fade extends ActionBase
    {
        private var _diffAlpha:Number;
        private var _endAlpha:Number;

        public function Fade(param1:Number = 1, param2:Number = 0)
        {
            this._diffAlpha = param1 - param2;
            this._endAlpha = param2;
            return;
        }// end function

        public function get startAlpha() : Number
        {
            return this._endAlpha + this._diffAlpha;
        }// end function

        public function set startAlpha(param1:Number) : void
        {
            this._diffAlpha = param1 - this._endAlpha;
            return;
        }// end function

        public function get endAlpha() : Number
        {
            return this._endAlpha;
        }// end function

        public function set endAlpha(param1:Number) : void
        {
            this._diffAlpha = this._endAlpha + this._diffAlpha - param1;
            this._endAlpha = param1;
            return;
        }// end function

        override public function getDefaultPriority() : Number
        {
            return -5;
        }// end function

        override public function update(param1:Emitter, param2:Particle, param3:Number) : void
        {
            var _loc_4:* = this._endAlpha + this._diffAlpha * param2.energy;
            param2.color = param2.color & 16777215 | Math.round(_loc_4 * 255) << 24;
            return;
        }// end function

    }
}
