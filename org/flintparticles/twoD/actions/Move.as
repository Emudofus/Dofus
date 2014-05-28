package org.flintparticles.twoD.actions
{
   import org.flintparticles.common.actions.ActionBase;
   import org.flintparticles.twoD.particles.Particle2D;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class Move extends ActionBase
   {
      
      public function Move() {
         super();
      }
      
      private var p:Particle2D;
      
      override public function getDefaultPriority() : Number {
         return -10;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number) : void {
         this.p = Particle2D(param2);
         this.p.x = this.p.x + this.p.velX * param3;
         this.p.y = this.p.y + this.p.velY * param3;
      }
   }
}
