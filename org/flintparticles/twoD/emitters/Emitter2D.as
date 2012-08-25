package org.flintparticles.twoD.emitters
{
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;
    import org.flintparticles.common.utils.*;
    import org.flintparticles.twoD.particles.*;

    public class Emitter2D extends Emitter
    {
        protected var _x:Number = 0;
        protected var _y:Number = 0;
        protected var _rotation:Number = 0;
        public var spaceSortedX:Array;
        public var spaceSort:Boolean = false;
        static var _creator:ParticleCreator2D = new ParticleCreator2D();

        public function Emitter2D()
        {
            _particleFactory = _creator;
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

        public function get rotation() : Number
        {
            return Maths.asDegrees(this._rotation);
        }// end function

        public function set rotation(param1:Number) : void
        {
            this._rotation = Maths.asRadians(param1);
            return;
        }// end function

        public function get rotRadians() : Number
        {
            return this._rotation;
        }// end function

        public function set rotRadians(param1:Number) : void
        {
            this._rotation = param1;
            return;
        }// end function

        override protected function initParticle(param1:Particle) : void
        {
            var _loc_2:Particle2D = null;
            _loc_2 = Particle2D(param1);
            _loc_2.x = this._x;
            _loc_2.y = this._y;
            _loc_2.rotation = this._rotation;
            return;
        }// end function

        override protected function sortParticles() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            if (this.spaceSort)
            {
                this.spaceSortedX = _particles.sortOn("x", Array.NUMERIC | Array.RETURNINDEXEDARRAY);
                _loc_1 = _particles.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    _particles[this.spaceSortedX[_loc_2]].sortID = _loc_2;
                    _loc_2++;
                }
            }
            return;
        }// end function

        public static function get defaultParticleFactory() : ParticleFactory
        {
            return _creator;
        }// end function

    }
}
