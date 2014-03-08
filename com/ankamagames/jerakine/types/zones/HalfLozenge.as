package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   
   public class HalfLozenge extends Object implements IZone
   {
      
      public function HalfLozenge(param1:uint, param2:uint, param3:IDataMapProvider) {
         super();
         this.radius = param2;
         this._minRadius = param1;
         this._dataMapProvider = param3;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HalfLozenge));
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 2;
      
      private var _direction:uint = 6;
      
      private var _dataMapProvider:IDataMapProvider;
      
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
         this._direction = param1;
      }
      
      public function get direction() : uint {
         return this._direction;
      }
      
      public function get surface() : uint {
         return this._radius * 2 + 1;
      }
      
      public function getCells(param1:uint=0) : Vector.<uint> {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc2_:Vector.<uint> = new Vector.<uint>();
         var _loc3_:MapPoint = MapPoint.fromCellId(param1);
         var _loc4_:int = _loc3_.x;
         var _loc5_:int = _loc3_.y;
         if(this._minRadius == 0)
         {
            _loc2_.push(param1);
         }
         var _loc8_:* = 1;
         var _loc9_:uint = 0;
         _loc6_ = 1;
         while(_loc6_ <= this._radius)
         {
            switch(this._direction)
            {
               case DirectionsEnum.UP_LEFT:
                  this.addCell(_loc4_ + _loc6_,_loc5_ + _loc6_,_loc2_);
                  this.addCell(_loc4_ + _loc6_,_loc5_ - _loc6_,_loc2_);
                  break;
               case DirectionsEnum.UP_RIGHT:
                  this.addCell(_loc4_ - _loc6_,_loc5_ - _loc6_,_loc2_);
                  this.addCell(_loc4_ + _loc6_,_loc5_ - _loc6_,_loc2_);
                  break;
               case DirectionsEnum.DOWN_RIGHT:
                  this.addCell(_loc4_ - _loc6_,_loc5_ + _loc6_,_loc2_);
                  this.addCell(_loc4_ - _loc6_,_loc5_ - _loc6_,_loc2_);
                  break;
               case DirectionsEnum.DOWN_LEFT:
                  this.addCell(_loc4_ - _loc6_,_loc5_ + _loc6_,_loc2_);
                  this.addCell(_loc4_ + _loc6_,_loc5_ + _loc6_,_loc2_);
                  break;
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
