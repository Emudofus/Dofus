package org.flintparticles.twoD.particles
{
    import org.flintparticles.common.particles.*;

    public class ParticleCreator2D extends Object implements ParticleFactory
    {
        private var _particles:Array;

        public function ParticleCreator2D()
        {
            this._particles = new Array();
            return;
        }// end function

        public function createParticle() : Particle
        {
            if (this._particles.length)
            {
                return this._particles.pop();
            }
            return new Particle2D();
        }// end function

        public function disposeParticle(param1:Particle) : void
        {
            if (param1 is Particle2D)
            {
                param1.initialize();
                this._particles.push(param1);
            }
            return;
        }// end function

        public function clearAllParticles() : void
        {
            this._particles = new Array();
            return;
        }// end function

    }
}
