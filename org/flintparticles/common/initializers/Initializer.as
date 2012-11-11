package org.flintparticles.common.initializers
{
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;

    public interface Initializer
    {

        public function Initializer();

        function getDefaultPriority() : Number;

        function addedToEmitter(param1:Emitter) : void;

        function removedFromEmitter(param1:Emitter) : void;

        function initialize(param1:Emitter, param2:Particle) : void;

    }
}
