package org.flintparticles.common.displayObjects
{
   import flash.display.Shape;
   
   public class Dot extends Shape
   {
      
      public function Dot(param1:Number, param2:uint=16777215, param3:String="normal") {
         super();
         graphics.beginFill(param2);
         graphics.drawCircle(0,0,param1);
         graphics.endFill();
         blendMode = param3;
      }
   }
}
