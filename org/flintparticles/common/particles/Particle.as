package org.flintparticles.common.particles
{
    import flash.geom.*;
    import flash.utils.*;

    public class Particle extends Object
    {
        public var color:uint = 4.29497e+009;
        private var _colorTransform:ColorTransform;
        private var _previousColor:uint;
        public var scale:Number = 1;
        public var mass:Number = 1;
        public var collisionRadius:Number = 1;
        public var image:Object = null;
        public var lifetime:Number = 0;
        public var age:Number = 0;
        public var energy:Number = 1;
        public var isDead:Boolean = false;
        private var _dictionary:Dictionary = null;

        public function Particle()
        {
            this.initialize();
            return;
        }// end function

        public function get dictionary() : Dictionary
        {
            if (this._dictionary == null)
            {
                this._dictionary = new Dictionary();
            }
            return this._dictionary;
        }// end function

        public function initialize() : void
        {
            this.color = 4294967295;
            this.scale = 1;
            this.mass = 1;
            this.collisionRadius = 1;
            this.lifetime = 0;
            this.age = 0;
            this.energy = 1;
            this.isDead = false;
            this.image = null;
            this._dictionary = null;
            this._colorTransform = null;
            return;
        }// end function

        public function get colorTransform() : ColorTransform
        {
            if (!this._colorTransform || this._previousColor != this.color)
            {
                this._colorTransform = new ColorTransform((this.color >>> 16 & 255) / 255, (this.color >>> 8 & 255) / 255, (this.color & 255) / 255, (this.color >>> 24 & 255) / 255, 0, 0, 0, 0);
                this._previousColor = this.color;
            }
            return this._colorTransform;
        }// end function

        public function get alpha() : Number
        {
            return ((this.color & 4278190080) >>> 24) / 255;
        }// end function

    }
}
