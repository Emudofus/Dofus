package org.flintparticles.common.actions
{
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;

    public interface Action
    {

        public function Action();

        function getDefaultPriority() : Number;

        function addedToEmitter(param1:Emitter) : void;

        function removedFromEmitter(param1:Emitter) : void;

        function update(param1:Emitter, param2:Particle, param3:Number) : void;

    }
}
