package com.ankamagames.jerakine.pools
{
   import flash.geom.Rectangle;
   
   public class PoolableRectangle extends Rectangle implements Poolable
   {
      
      public function PoolableRectangle(param1:Number=0, param2:Number=0, param3:Number=0, param4:Number=0) {
         super(param1,param2,param3,param4);
      }
      
      public function renew(param1:Number=0, param2:Number=0, param3:Number=0, param4:Number=0) : PoolableRectangle {
         this.x = param1;
         this.y = param2;
         this.width = param3;
         this.height = param4;
         return this;
      }
      
      public function free() : void {
      }
      
      public function extend(param1:Rectangle) : void {
         var _loc2_:Rectangle = this.union(param1);
         x = _loc2_.x;
         y = _loc2_.y;
         width = _loc2_.width;
         height = _loc2_.height;
      }
   }
}
