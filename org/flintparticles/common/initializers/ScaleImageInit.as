package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class ScaleImageInit extends InitializerBase
   {
      
      public function ScaleImageInit(param1:Number, param2:Number=NaN) {
         super();
         this._min = param1;
         if(isNaN(param2))
         {
            this._max = this._min;
         }
         else
         {
            this._max = param2;
         }
      }
      
      private var _min:Number;
      
      private var _max:Number;
      
      public function get minScale() : Number {
         return this._min;
      }
      
      public function set minScale(param1:Number) : void {
         this._min = param1;
      }
      
      public function get maxScale() : Number {
         return this._max;
      }
      
      public function set maxScale(param1:Number) : void {
         this._max = param1;
      }
      
      public function get scale() : Number {
         return this._min == this._max?this._min:(this._max + this._min) / 2;
      }
      
      public function set scale(param1:Number) : void {
         this._max = this._min = param1;
      }
      
      override public function initialize(param1:Emitter, param2:Particle) : void {
         if(this._max == this._min)
         {
            param2.scale = this._min;
         }
         else
         {
            param2.scale = this._min + Math.random() * (this._max - this._min);
         }
      }
   }
}
