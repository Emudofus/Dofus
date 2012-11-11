package org.flintparticles.common.initializers
{
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.initializers.*;
    import org.flintparticles.common.particles.*;

    public class InitializerBase extends Object implements Initializer
    {

        public function InitializerBase()
        {
            return;
        }// end function

        public function getDefaultPriority() : Number
        {
            return 0;
        }// end function

        public function addedToEmitter(param1:Emitter) : void
        {
            return;
        }// end function

        public function removedFromEmitter(param1:Emitter) : void
        {
            return;
        }// end function

        public function initialize(param1:Emitter, param2:Particle) : void
        {
            return;
        }// end function

    }
}
