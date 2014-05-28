package org.flintparticles.twoD.initializers
{
   import org.flintparticles.common.initializers.InitializerBase;
   import org.flintparticles.twoD.zones.Zone2D;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.twoD.particles.Particle2D;
   import flash.geom.Point;
   
   public class Position extends InitializerBase
   {
      
      public function Position(param1:Zone2D) {
         super();
         this._zone = param1;
      }
      
      private var _zone:Zone2D;
      
      public function get zone() : Zone2D {
         return this._zone;
      }
      
      public function set zone(param1:Zone2D) : void {
         this._zone = param1;
      }
      
      override public function initialize(param1:Emitter, param2:Particle) : void {
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc3_:Particle2D = Particle2D(param2);
         var _loc4_:Point = this._zone.getLocation();
         if(_loc3_.rotation == 0)
         {
            _loc3_.x = _loc3_.x + _loc4_.x;
            _loc3_.y = _loc3_.y + _loc4_.y;
         }
         else
         {
            _loc5_ = Math.sin(_loc3_.rotation);
            _loc6_ = Math.cos(_loc3_.rotation);
            _loc3_.x = _loc3_.x + (_loc6_ * _loc4_.x - _loc5_ * _loc4_.y);
            _loc3_.y = _loc3_.y + (_loc6_ * _loc4_.y + _loc5_ * _loc4_.x);
         }
      }
   }
}
