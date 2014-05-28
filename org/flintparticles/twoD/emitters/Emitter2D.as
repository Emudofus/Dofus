package org.flintparticles.twoD.emitters
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.twoD.particles.ParticleCreator2D;
   import org.flintparticles.common.particles.ParticleFactory;
   import org.flintparticles.common.utils.Maths;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.twoD.particles.Particle2D;
   
   public class Emitter2D extends Emitter
   {
      
      public function Emitter2D() {
         super();
         _particleFactory = _creator;
      }
      
      protected static var _creator:ParticleCreator2D = new ParticleCreator2D();
      
      public static function get defaultParticleFactory() : ParticleFactory {
         return _creator;
      }
      
      protected var _x:Number = 0;
      
      protected var _y:Number = 0;
      
      protected var _rotation:Number = 0;
      
      public var spaceSortedX:Array;
      
      public var spaceSort:Boolean = false;
      
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
      
      public function get rotation() : Number {
         return Maths.asDegrees(this._rotation);
      }
      
      public function set rotation(param1:Number) : void {
         this._rotation = Maths.asRadians(param1);
      }
      
      public function get rotRadians() : Number {
         return this._rotation;
      }
      
      public function set rotRadians(param1:Number) : void {
         this._rotation = param1;
      }
      
      override protected function initParticle(param1:Particle) : void {
         var _loc2_:Particle2D = null;
         _loc2_ = Particle2D(param1);
         _loc2_.x = this._x;
         _loc2_.y = this._y;
         _loc2_.rotation = this._rotation;
      }
      
      override protected function sortParticles() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         if(this.spaceSort)
         {
            this.spaceSortedX = _particles.sortOn("x",Array.NUMERIC | Array.RETURNINDEXEDARRAY);
            _loc1_ = _particles.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _particles[this.spaceSortedX[_loc2_]].sortID = _loc2_;
               _loc2_++;
            }
         }
      }
   }
}
