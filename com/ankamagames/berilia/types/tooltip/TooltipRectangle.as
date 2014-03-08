package com.ankamagames.berilia.types.tooltip
{
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   import flash.geom.Point;
   
   public class TooltipRectangle extends Object implements IRectangle, IModuleUtil
   {
      
      public function TooltipRectangle(param1:Number, param2:Number, param3:Number, param4:Number) {
         super();
         this.x = param1;
         this.y = param2;
         this.width = param3;
         this.height = param4;
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
      
      public function set x(param1:Number) : void {
         this._x = param1;
      }
      
      public function set y(param1:Number) : void {
         this._y = param1;
      }
      
      public function set width(param1:Number) : void {
         this._width = param1;
      }
      
      public function set height(param1:Number) : void {
         this._height = param1;
      }
      
      public function localToGlobal(param1:Point) : Point {
         return param1;
      }
      
      public function globalToLocal(param1:Point) : Point {
         return param1;
      }
   }
}
