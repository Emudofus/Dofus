package com.ankamagames.atouin.types
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BitmapCellContainer extends Object implements ICellContainer
   {
      
      public function BitmapCellContainer(param1:uint) {
         this.datas = new Array();
         this.bitmaps = new Array();
         this.colorTransforms = new Array();
         super();
      }
      
      private var _destPoint:Point;
      
      private var _srcRect:Rectangle;
      
      public function get cacheAsBitmap() : Boolean {
         return false;
      }
      
      public function set cacheAsBitmap(param1:Boolean) : void {
      }
      
      public function get mouseChildren() : Boolean {
         return false;
      }
      
      public function set mouseChildren(param1:Boolean) : void {
      }
      
      public function get mouseEnabled() : Boolean {
         return false;
      }
      
      public function set mouseEnabled(param1:Boolean) : void {
      }
      
      private var _cellId:int = 0;
      
      public function get cellId() : uint {
         return this._cellId;
      }
      
      public function set cellId(param1:uint) : void {
         this._cellId = param1;
      }
      
      private var _layerId:int = 0;
      
      public function get layerId() : int {
         return this._layerId;
      }
      
      public function set layerId(param1:int) : void {
         this._layerId = param1;
      }
      
      private var _startX:int = 0;
      
      public function get startX() : int {
         return this._startX;
      }
      
      public function set startX(param1:int) : void {
         this._startX = param1;
      }
      
      private var _startY:int = 0;
      
      public function get startY() : int {
         return this._startY;
      }
      
      public function set startY(param1:int) : void {
         this._startY = param1;
      }
      
      private var _x:Number = 0;
      
      public function get x() : Number {
         return this._x;
      }
      
      public function set x(param1:Number) : void {
         this._x = param1;
      }
      
      private var _y:Number = 0;
      
      public function get y() : Number {
         return this._y;
      }
      
      public function set y(param1:Number) : void {
         this._y = param1;
      }
      
      private var _depth:int = 0;
      
      public function get depth() : int {
         return this._depth;
      }
      
      public function set depth(param1:int) : void {
         this._depth = param1;
      }
      
      public var datas:Array;
      
      public var bitmaps:Array;
      
      public var colorTransforms:Array;
      
      private var _numChildren:int = 0;
      
      public function get numChildren() : int {
         return this._numChildren;
      }
      
      public function addFakeChild(param1:Object, param2:Object, param3:Object) : void {
         this.colorTransforms[this._numChildren] = param3;
         this.datas[this._numChildren] = param2;
         var _loc4_:* = this._numChildren++;
         this.bitmaps[_loc4_] = param1;
      }
   }
}
