package com.ankamagames.berilia.types.tooltip
{
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   import flash.geom.Point;
   
   public class TooltipRectangle extends Object implements IRectangle, IModuleUtil
   {
      
      public function TooltipRectangle(x:Number, y:Number, width:Number, height:Number) {
         super();
         this.x = x;
         this.y = y;
         this.width = width;
         this.height = height;
      }
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _width:Number;
      
      private var _height:Number;
      
      public function get x() : Number {
         return this._x;
      }
      
      public function get y() : Number {
         return this._y;
      }
      
      public function get width() : Number {
         return this._width;
      }
      
      public function get height() : Number {
         return this._height;
      }
      
      public function set x(nValue:Number) : void {
         this._x = nValue;
      }
      
      public function set y(nValue:Number) : void {
         this._y = nValue;
      }
      
      public function set width(nValue:Number) : void {
         this._width = nValue;
      }
      
      public function set height(nValue:Number) : void {
         this._height = nValue;
      }
      
      public function localToGlobal(point:Point) : Point {
         return point;
      }
      
      public function globalToLocal(point:Point) : Point {
         return point;
      }
   }
}
