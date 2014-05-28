package org.flintparticles.twoD.particles
{
   import org.flintparticles.common.particles.Particle;
   import flash.geom.Matrix;
   
   public class Particle2D extends Particle
   {
      
      public function Particle2D() {
         super();
      }
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var velX:Number = 0;
      
      public var velY:Number = 0;
      
      public var rotation:Number = 0;
      
      public var angVelocity:Number = 0;
      
      private var _previousMass:Number;
      
      private var _previousRadius:Number;
      
      private var _inertia:Number;
      
      public function get inertia() : Number {
         if(!(mass == this._previousMass) || !(collisionRadius == this._previousRadius))
         {
            this._inertia = mass * collisionRadius * collisionRadius * 0.5;
            this._previousMass = mass;
            this._previousRadius = collisionRadius;
         }
         return this._inertia;
      }
      
      public var sortID:uint;
      
      override public function initialize() : void {
         super.initialize();
         this.x = 0;
         this.y = 0;
         this.velX = 0;
         this.velY = 0;
         this.rotation = 0;
         this.angVelocity = 0;
         this.sortID = 0;
      }
      
      public function get matrixTransform() : Matrix {
         var _loc1_:Number = scale * Math.cos(this.rotation);
         var _loc2_:Number = scale * Math.sin(this.rotation);
         return new Matrix(_loc1_,_loc2_,-_loc2_,_loc1_,this.x,this.y);
      }
   }
}
