package org.flintparticles.common.particles
{

    public interface ParticleFactory
    {

        public function ParticleFactory();

        function createParticle() : Particle;

        function disposeParticle(param1:Particle) : void;

    }
}
