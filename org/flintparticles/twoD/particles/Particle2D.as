package org.flintparticles.twoD.particles
{
    import flash.geom.*;
    import org.flintparticles.common.particles.*;

    public class Particle2D extends Particle
    {
        public var x:Number = 0;
        public var y:Number = 0;
        public var velX:Number = 0;
        public var velY:Number = 0;
        public var rotation:Number = 0;
        public var angVelocity:Number = 0;
        private var _previousMass:Number;
        private var _previousRadius:Number;
        private var _inertia:Number;
        public var sortID:uint;

        public function Particle2D()
        {
            return;
        }// end function

        public function get inertia() : Number
        {
            if (mass != this._previousMass || collisionRadius != this._previousRadius)
            {
                this._inertia = mass * collisionRadius * collisionRadius * 0.5;
                this._previousMass = mass;
                this._previousRadius = collisionRadius;
            }
            return this._inertia;
        }// end function

        override public function initialize() : void
        {
            super.initialize();
            this.x = 0;
            this.y = 0;
            this.velX = 0;
            this.velY = 0;
            this.rotation = 0;
            this.angVelocity = 0;
            this.sortID = 0;
            return;
        }// end function

        public function get matrixTransform() : Matrix
        {
            var _loc_1:* = scale * Math.cos(this.rotation);
            var _loc_2:* = scale * Math.sin(this.rotation);
            return new Matrix(_loc_1, _loc_2, -_loc_2, _loc_1, this.x, this.y);
        }// end function

    }
}
