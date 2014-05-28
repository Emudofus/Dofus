package com.ankamagames.jerakine.types
{
   public class Point3D extends Object
   {
      
      public function Point3D(_x:Number, _y:Number, _z:Number) {
         super();
         this.x = _x;
         this.y = _y;
         this.z = _z;
      }
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var z:Number = 0;
   }
}
