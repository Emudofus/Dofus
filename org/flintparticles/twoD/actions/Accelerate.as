package org.flintparticles.twoD.actions
{
    import org.flintparticles.common.actions.*;
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;
    import org.flintparticles.twoD.particles.*;

    public class Accelerate extends ActionBase
    {
        private var _x:Number;
        private var _y:Number;

        public function Accelerate(param1:Number, param2:Number)
        {
            this._x = param1;
            this._y = param2;
            return;
        }// end function

        public function get x() : Number
        {
            return this._x;
        }// end function

        public function set x(param1:Number) : void
        {
            this._x = param1;
            return;
        }// end function

        public function get y() : Number
        {
            return this._y;
        }// end function

        public function set y(param1:Number) : void
        {
            this._y = param1;
            return;
        }// end function

        override public function update(param1:Emitter, param2:Particle, param3:Number) : void
        {
            var _loc_4:* = Particle2D(param2);
            Particle2D(param2).velX = Particle2D(param2).velX + this._x * param3;
            _loc_4.velY = _loc_4.velY + this._y * param3;
            return;
        }// end function

    }
}
