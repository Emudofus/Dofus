package org.flintparticles.common.actions
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class Fade extends ActionBase
   {
      
      public function Fade(param1:Number=1, param2:Number=0) {
         super();
         this._diffAlpha = param1 - param2;
         this._endAlpha = param2;
      }
      
      private var _diffAlpha:Number;
      
      private var _endAlpha:Number;
      
      public function get startAlpha() : Number {
         return this._endAlpha + this._diffAlpha;
      }
      
      public function set startAlpha(param1:Number) : void {
         this._diffAlpha = param1 - this._endAlpha;
      }
      
      public function get endAlpha() : Number {
         return this._endAlpha;
      }
      
      public function set endAlpha(param1:Number) : void {
         this._diffAlpha = this._endAlpha + this._diffAlpha - param1;
         this._endAlpha = param1;
      }
      
      override public function getDefaultPriority() : Number {
         return -5;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number) : void {
         var _loc4_:Number = this._endAlpha + this._diffAlpha * param2.energy;
         param2.color = param2.color & 16777215 | Math.round(_loc4_ * 255) << 24;
      }
   }
}
