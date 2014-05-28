package org.flintparticles.twoD.particles
{
   import org.flintparticles.common.particles.ParticleFactory;
   import org.flintparticles.common.particles.Particle;
   
   public class ParticleCreator2D extends Object implements ParticleFactory
   {
      
      public function ParticleCreator2D() {
         super();
         this._particles = new Array();
      }
      
      private var _particles:Array;
      
      public function createParticle() : Particle {
         if(this._particles.length)
         {
            return this._particles.pop();
         }
         return new Particle2D();
      }
      
      public function disposeParticle(param1:Particle) : void {
         if(param1 is Particle2D)
         {
            param1.initialize();
            this._particles.push(param1);
         }
      }
      
      public function clearAllParticles() : void {
         this._particles = new Array();
      }
   }
}
