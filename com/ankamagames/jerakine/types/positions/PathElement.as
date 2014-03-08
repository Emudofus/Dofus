package com.ankamagames.jerakine.types.positions
{
   public class PathElement extends Object
   {
      
      public function PathElement(param1:MapPoint=null, param2:uint=0) {
         super();
         if(!param1)
         {
            this._oStep = new MapPoint();
         }
         else
         {
            this._oStep = param1;
         }
         this._nOrientation = param2;
      }
      
      private var _oStep:MapPoint;
      
      private var _nOrientation:uint;
      
      public function get orientation() : uint {
         return this._nOrientation;
      }
      
      public function set orientation(param1:uint) : void {
         this._nOrientation = param1;
      }
      
      public function get step() : MapPoint {
         return this._oStep;
      }
      
      public function set step(param1:MapPoint) : void {
         this._oStep = param1;
      }
      
      public function get cellId() : uint {
         return this._oStep.cellId;
      }
      
      public function toString() : String {
         return "[PathElement(cellId:" + this.cellId + ", x:" + this._oStep.x + ", y:" + this._oStep.y + ", orientation:" + this._nOrientation + ")]";
      }
   }
}
