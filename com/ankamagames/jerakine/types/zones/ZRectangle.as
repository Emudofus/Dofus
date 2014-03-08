package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class ZRectangle extends Object implements IZone
   {
      
      public function ZRectangle(param1:uint, param2:uint, param3:uint, param4:IDataMapProvider) {
         super();
         this.radius = param2;
         this._radius2 = param3?param3:param2;
         this.minRadius = param1;
         this._dataMapProvider = param4;
      }
      
      private var _radius:uint = 0;
      
      private var _radius2:uint;
      
      private var _minRadius:uint = 2;
      
      private var _dataMapProvider:IDataMapProvider;
      
      private var _diagonalFree:Boolean = false;
      
      public function get radius() : uint {
         return this._radius;
      }
      
      public function set radius(param1:uint) : void {
         this._radius = param1;
      }
      
      public function set minRadius(param1:uint) : void {
         this._minRadius = param1;
      }
      
      public function get minRadius() : uint {
         return this._minRadius;
      }
      
      public function set direction(param1:uint) : void {
      }
      
      public function get direction() : uint {
         return null;
      }
      
      public function set diagonalFree(param1:Boolean) : void {
         this._diagonalFree = param1;
      }
      
      public function get diagonalFree() : Boolean {
         return this._diagonalFree;
      }
      
      public function get surface() : uint {
         return Math.pow(this._radius + this._radius2 + 1,2);
      }
      
      public function getCells(param1:uint=0) : Vector.<uint> {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc2_:Vector.<uint> = new Vector.<uint>();
         var _loc3_:MapPoint = MapPoint.fromCellId(param1);
         var _loc4_:int = _loc3_.x;
         var _loc5_:int = _loc3_.y;
         if(this._radius == 0 || this._radius2 == 0)
         {
            if(this._minRadius == 0 && !this._diagonalFree)
            {
               _loc2_.push(param1);
            }
            return _loc2_;
         }
         _loc6_ = _loc4_ - this._radius;
         while(_loc6_ <= _loc4_ + this._radius)
         {
            _loc7_ = _loc5_ - this._radius2;
            while(_loc7_ <= _loc5_ + this._radius2)
            {
               if(!this._minRadius || Math.abs(_loc4_ - _loc6_) + Math.abs(_loc5_ - _loc7_) >= this._minRadius)
               {
                  if(!this._diagonalFree || !(Math.abs(_loc4_ - _loc6_) == Math.abs(_loc5_ - _loc7_)))
                  {
                     if(MapPoint.isInMap(_loc6_,_loc7_))
                     {
                        this.addCell(_loc6_,_loc7_,_loc2_);
                     }
                  }
               }
               _loc7_++;
            }
            _loc6_++;
         }
         return _loc2_;
      }
      
      private function addCell(param1:int, param2:int, param3:Vector.<uint>) : void {
         if(this._dataMapProvider == null || (this._dataMapProvider.pointMov(param1,param2)))
         {
            param3.push(MapPoint.fromCoords(param1,param2).cellId);
         }
      }
   }
}
