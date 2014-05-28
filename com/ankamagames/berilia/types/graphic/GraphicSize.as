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
      
      public function setX(nX:Number, nType:uint) : void {
         x = nX;
         this._nXUnit = nType;
      }
      
      public function setY(nY:Number, nType:uint) : void {
         y = nY;
         this._nYUnit = nType;
      }
      
      public function get xUnit() : uint {
         return this._nXUnit;
      }
      
      public function get yUnit() : uint {
         return this._nYUnit;
      }
      
      public function toSizeElement() : SizeElement {
         var se:SizeElement = new SizeElement();
         if(!isNaN(x))
         {
            se.x = x;
            se.xUnit = this._nXUnit;
         }
         if(!isNaN(y))
         {
            se.y = y;
            se.yUnit = this._nYUnit;
         }
         return se;
      }
   }
}
