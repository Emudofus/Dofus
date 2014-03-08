package com.ankamagames.tiphon.display
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class RasterizedFrame extends Object
   {
      
      public function RasterizedFrame(param1:MovieClip, param2:int) {
         var _loc4_:BitmapData = null;
         var _loc5_:Matrix = null;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         super();
         param1.gotoAndStop(param2 + 1);
         var _loc3_:Rectangle = param1.getBounds(param1);
         if(_loc3_.width + _loc3_.height)
         {
            _loc5_ = new Matrix();
            _loc6_ = param1.scaleX;
            _loc7_ = param1.scaleY;
            _loc8_ = _loc6_ > 0?_loc3_.width * _loc6_:-_loc3_.width * _loc6_;
            _loc9_ = _loc7_ > 0?_loc3_.height * _loc7_:-_loc3_.height * _loc7_;
            _loc10_ = _loc6_ > 0?_loc3_.x * _loc6_:(_loc3_.x + _loc3_.width) * _loc6_;
            _loc11_ = _loc7_ > 0?_loc3_.y * _loc7_:(_loc3_.y + _loc3_.height) * _loc7_;
            _loc5_.scale(_loc6_,_loc7_);
            _loc5_.translate(-_loc10_,-_loc11_);
            this.x = _loc10_;
            this.y = _loc11_;
            _loc4_ = new BitmapData(_loc8_,_loc9_,true,16777215);
            _loc4_.draw(param1,_loc5_,null,null,null,true);
         }
         else
         {
            _loc4_ = new BitmapData(1,1,true,16777215);
         }
         this.bitmapData = _loc4_;
         if(param1.currentFrame == param1.framesLoaded && (param1.parent))
         {
            param1.parent.removeChild(param1);
         }
      }
      
      public var bitmapData:BitmapData;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public function toString() : String {
         return "[RasterizedFrame " + this.x + "," + this.y + ": " + this.bitmapData + " (" + this.bitmapData.width + "/" + this.bitmapData.height + ")]";
      }
   }
}
