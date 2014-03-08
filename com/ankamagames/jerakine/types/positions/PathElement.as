package com.ankamagames.jerakine.types.positions
{
   public class PathElement extends Object
   {
      
      public function PathElement(step:MapPoint=null, orientation:uint=0) {
         super();
         if(!step)
         {
            this._oStep = new MapPoint();
         }
         else
         {
            this._oStep = step;
         }
         this._nOrientation = orientation;
      }
      
      private var _oStep:MapPoint;
      
      private var _nOrientation:uint;
      
      public function get orientation() : uint {
         return this._nOrientation;
      }
      
      public function set orientation(nValue:uint) : void {
         this._nOrientation = nValue;
      }
      
      public function get step() : MapPoint {
         return this._oStep;
      }
      
      public function set step(nValue:MapPoint) : void {
         this._oStep = nValue;
      }
      
      public function get cellId() : uint {
         return this._oStep.cellId;
      }
      
      public function toString() : String {
         return "[PathElement(cellId:" + this.cellId + ", x:" + this._oStep.x + ", y:" + this._oStep.y + ", orientation:" + this._nOrientation + ")]";
      }
   }
}
