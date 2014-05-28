package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class InitializerBase extends Object implements Initializer
   {
      
      public function InitializerBase() {
         super();
      }
      
      public function getDefaultPriority() : Number {
         return 0;
      }
      
      public function addedToEmitter(param1:Emitter) : void {
      }
      
      public function removedFromEmitter(param1:Emitter) : void {
      }
      
      public function initialize(param1:Emitter, param2:Particle) : void {
      }
   }
}
