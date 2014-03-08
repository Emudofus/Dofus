package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class Lifetime extends InitializerBase
   {
      
      public function Lifetime(param1:Number, param2:Number=NaN) {
         super();
         this._max = param2;
         this._min = param1;
      }
      
      private var _max:Number;
      
      private var _min:Number;
      
      public function get minLifetime() : Number {
         return this._min;
      }
      
      public function set minLifetime(param1:Number) : void {
         this._min = param1;
      }
      
      public function get maxLifetime() : Number {
         return this._max;
      }
      
      public function set maxLifetime(param1:Number) : void {
         this._max = param1;
      }
      
      public function get lifetime() : Number {
         return this._min == this._max?this._min:(this._max + this._min) * 0.5;
      }
      
      public function set lifetime(param1:Number) : void {
         this._max = this._min = param1;
      }
      
      override public function initialize(param1:Emitter, param2:Particle) : void {
         if(isNaN(this._max))
         {
            param2.lifetime = this._min;
         }
         else
         {
            param2.lifetime = this._min + Math.random() * (this._max - this._min);
         }
      }
   }
}
