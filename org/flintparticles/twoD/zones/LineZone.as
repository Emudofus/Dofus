package org.flintparticles.twoD.zones
{
   import flash.geom.Point;
   
   public class LineZone extends Object implements Zone2D
   {
      
      public function LineZone(param1:Point, param2:Point) {
         super();
         this._point1 = param1;
         this._point2 = param2;
         this._length = param2.subtract(param1);
      }
      
      private var _point1:Point;
      
      private var _point2:Point;
      
      private var _length:Point;
      
      public function get point1() : Point {
         return this._point1;
      }
      
      public function set point1(param1:Point) : void {
         this._point1 = param1;
         this._length = this.point2.subtract(this.point1);
      }
      
      public function get point2() : Point {
         return this._point2;
      }
      
      public function set point2(param1:Point) : void {
         this._point2 = param1;
         this._length = this.point2.subtract(this.point1);
      }
      
      public function contains(param1:Number, param2:Number) : Boolean {
         if((param1 - this._point1.x) * this._length.y - (param2 - this._point1.y) * this._length.x != 0)
         {
            return false;
         }
         return (param1 - this._point1.x) * (param1 - this._point2.x) + (param2 - this._point1.y) * (param2 - this._point2.y) <= 0;
      }
      
      public function getLocation() : Point {
         var _loc1_:Point = this._point1.clone();
         var _loc2_:Number = Math.random();
         _loc1_.x = _loc1_.x + this._length.x * _loc2_;
         _loc1_.y = _loc1_.y + this._length.y * _loc2_;
         return _loc1_;
      }
      
      public function getArea() : Number {
         return this._length.length;
      }
   }
}
