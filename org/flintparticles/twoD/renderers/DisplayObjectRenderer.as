package org.flintparticles.twoD.renderers
{
   import org.flintparticles.common.renderers.SpriteRendererBase;
   import org.flintparticles.twoD.particles.Particle2D;
   import flash.display.DisplayObject;
   import org.flintparticles.common.particles.Particle;
   
   public class DisplayObjectRenderer extends SpriteRendererBase
   {
      
      public function DisplayObjectRenderer() {
         super();
      }
      
      override protected function renderParticles(param1:Array) : void {
         var _loc2_:Particle2D = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:int = param1.length;
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = param1[_loc5_];
            _loc3_ = _loc2_.image;
            _loc3_.transform.colorTransform = _loc2_.colorTransform;
            _loc3_.transform.matrix = _loc2_.matrixTransform;
            _loc5_++;
         }
      }
      
      override protected function addParticle(param1:Particle) : void {
         addChildAt(param1.image,0);
      }
      
      override protected function removeParticle(param1:Particle) : void {
         if(contains(param1.image))
         {
            removeChild(param1.image);
         }
      }
   }
}
