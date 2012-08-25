package org.flintparticles.twoD.initializers
{
    import flash.geom.*;
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.initializers.*;
    import org.flintparticles.common.particles.*;
    import org.flintparticles.twoD.particles.*;
    import org.flintparticles.twoD.zones.*;

    public class Position extends InitializerBase
    {
        private var _zone:Zone2D;

        public function Position(param1:Zone2D)
        {
            this._zone = param1;
            return;
        }// end function

        public function get zone() : Zone2D
        {
            return this._zone;
        }// end function

        public function set zone(param1:Zone2D) : void
        {
            this._zone = param1;
            return;
        }// end function

        override public function initialize(param1:Emitter, param2:Particle) : void
        {
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_3:* = Particle2D(param2);
            var _loc_4:* = this._zone.getLocation();
            if (_loc_3.rotation == 0)
            {
                _loc_3.x = _loc_3.x + _loc_4.x;
                _loc_3.y = _loc_3.y + _loc_4.y;
            }
            else
            {
                _loc_5 = Math.sin(_loc_3.rotation);
                _loc_6 = Math.cos(_loc_3.rotation);
                _loc_3.x = _loc_3.x + (_loc_6 * _loc_4.x - _loc_5 * _loc_4.y);
                _loc_3.y = _loc_3.y + (_loc_6 * _loc_4.y + _loc_5 * _loc_4.x);
            }
            return;
        }// end function

    }
}
