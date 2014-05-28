package org.flintparticles.common.initializers
{
   import org.flintparticles.common.utils.interpolateColors;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class ColorInit extends InitializerBase
   {
      
      public function ColorInit(param1:uint, param2:uint) {
         super();
         this._min = param1;
         this._max = param2;
      }
      
      private var _min:uint;
      
      private var _max:uint;
      
      public function get minColor() : uint {
         return this._min;
      }
      
      public function set minColor(param1:uint) : void {
         this._min = param1;
      }
      
      public function get maxColor() : uint {
         return this._max;
      }
      
      public function set maxColor(param1:uint) : void {
         this._max = param1;
      }
      
      public function get color() : uint {
         return this._min == this._max?this._min:interpolateColors(this._max,this._min,0.5);
      }
      
      public function set color(param1:uint) : void {
         this._max = this._min = param1;
      }
      
      override public function initialize(param1:Emitter, param2:Particle) : void {
         if(this._max == this._min)
         {
            param2.color = this._min;
         }
         else
         {
            param2.color = interpolateColors(this._min,this._max,Math.random());
         }
      }
   }
}
