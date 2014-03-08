package com.ankamagames.berilia.types.graphic
{
   import flash.geom.Point;
   import com.ankamagames.berilia.types.uiDefinition.SizeElement;
   
   public class GraphicSize extends Point
   {
      
      public function GraphicSize() {
         super();
         x = NaN;
         y = NaN;
      }
      
      public static const SIZE_PIXEL:uint = 0;
      
      public static const SIZE_PRC:uint = 1;
      
      private var _nXUnit:uint;
      
      private var _nYUnit:uint;
      
      public function setX(param1:Number, param2:uint) : void {
         x = param1;
         this._nXUnit = param2;
      }
      
      public function setY(param1:Number, param2:uint) : void {
         y = param1;
         this._nYUnit = param2;
      }
      
      public function get xUnit() : uint {
         return this._nXUnit;
      }
      
      public function get yUnit() : uint {
         return this._nYUnit;
      }
      
      public function toSizeElement() : SizeElement {
         var _loc1_:SizeElement = new SizeElement();
         if(!isNaN(x))
         {
            _loc1_.x = x;
            _loc1_.xUnit = this._nXUnit;
         }
         if(!isNaN(y))
         {
            _loc1_.y = y;
            _loc1_.yUnit = this._nYUnit;
         }
         return _loc1_;
      }
   }
}
