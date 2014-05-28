package org.flintparticles.twoD.actions
{
   import org.flintparticles.common.actions.ActionBase;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.twoD.particles.Particle2D;
   
   public class Accelerate extends ActionBase
   {
      
      public function Accelerate(param1:Number, param2:Number) {
         super();
         this._x = param1;
         this._y = param2;
      }
      
      private var _x:Number;
      
      private var _y:Number;
      
      public function get x() : Number {
         return this._x;
      }
      
      public function set x(param1:Number) : void {
         this._x = param1;
      }
      
      public function get y() : Number {
         return this._y;
      }
      
      public function set y(param1:Number) : void {
         this._y = param1;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number) : void {
         var _loc4_:* = Particle2D(param2);
         _loc4_.velX = _loc4_.velX + this._x * param3;
         _loc4_.velY = _loc4_.velY + this._y * param3;
      }
   }
}
