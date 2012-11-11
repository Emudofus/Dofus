package org.flintparticles.twoD.actions
{
    import org.flintparticles.common.actions.*;
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;
    import org.flintparticles.twoD.particles.*;

    public class RandomDrift extends ActionBase
    {
        private var _sizeX:Number;
        private var _sizeY:Number;

        public function RandomDrift(param1:Number, param2:Number)
        {
            this._sizeX = param1 * 2;
            this._sizeY = param2 * 2;
            return;
        }// end function

        public function get driftX() : Number
        {
            return this._sizeX / 2;
        }// end function

        public function set driftX(param1:Number) : void
        {
            this._sizeX = param1 * 2;
            return;
        }// end function

        public function get driftY() : Number
        {
            return this._sizeY / 2;
        }// end function

        public function set driftY(param1:Number) : void
        {
            this._sizeY = param1 * 2;
            return;
        }// end function

        override public function update(param1:Emitter, param2:Particle, param3:Number) : void
        {
            var _loc_4:* = Particle2D(param2);
            Particle2D(param2).velX = Particle2D(param2).velX + (Math.random() - 0.5) * this._sizeX * param3;
            _loc_4.velY = _loc_4.velY + (Math.random() - 0.5) * this._sizeY * param3;
            return;
        }// end function

    }
}
