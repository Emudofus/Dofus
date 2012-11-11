package org.flintparticles.common.initializers
{
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;
    import org.flintparticles.common.utils.*;

    public class ImageClass extends InitializerBase
    {
        private var _imageClass:Class;
        private var _parameters:Array;

        public function ImageClass(param1:Class, ... args)
        {
            this._imageClass = param1;
            this._parameters = args;
            return;
        }// end function

        public function get imageClass() : Class
        {
            return this._imageClass;
        }// end function

        public function set imageClass(param1:Class) : void
        {
            this._imageClass = param1;
            return;
        }// end function

        public function get parameters() : Array
        {
            return this._parameters;
        }// end function

        public function set parameters(param1:Array) : void
        {
            this._parameters = param1;
            return;
        }// end function

        override public function initialize(param1:Emitter, param2:Particle) : void
        {
            param2.image = construct(this._imageClass, this._parameters);
            return;
        }// end function

    }
}
