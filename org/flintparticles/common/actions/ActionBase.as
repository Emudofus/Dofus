package org.flintparticles.common.actions
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class ActionBase extends Object implements Action
   {
      
      public function ActionBase() {
         super();
      }
      
      public function getDefaultPriority() : Number {
         return 0;
      }
      
      public function addedToEmitter(param1:Emitter) : void {
      }
      
      public function removedFromEmitter(param1:Emitter) : void {
      }
      
      public function update(param1:Emitter, param2:Particle, param3:Number) : void {
      }
   }
}
