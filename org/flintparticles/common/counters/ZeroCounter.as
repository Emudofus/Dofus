package org.flintparticles.common.counters
{
   import org.flintparticles.common.emitters.Emitter;
   
   public class ZeroCounter extends Object implements Counter
   {
      
      public function ZeroCounter() {
         super();
      }
      
      public function startEmitter(param1:Emitter) : uint {
         return 0;
      }
      
      public function updateEmitter(param1:Emitter, param2:Number) : uint {
         return 0;
      }
      
      public function stop() : void {
      }
      
      public function resume() : void {
      }
   }
}
