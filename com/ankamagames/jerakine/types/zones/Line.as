package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   
   public class Line extends Object implements IZone
   {
      
      public function Line(param1:uint, param2:IDataMapProvider) {
         super();
         this.radius = param1;
         this._dataMapProvider = param2;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Line));
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 0;
      
      private var _nDirection:uint = 1;
      
      private var _dataMapProvider:IDataMapProvider;
      
      public function get radius() : uint {
         return this._radius;
      }
      
      public function set radius(param1:uint) : void {
         this._radius = param1;
      }
      
      public function get surface() : uint {
         return this._radius + 1;
      }
      
      public function set minRadius(param1:uint) : void {
         this._minRadius = param1;
      }
      
      public function get minRadius() : uint {
         return this._minRadius;
      }
      
      public function set direction(param1:uint) : void {
         this._nDirection = param1;
      }
      
      public function get direction() : uint {
         return this._nDirection;
      }
      
      public function getCells(param1:uint=0) : Vector.<uint> {
         var _loc6_:* = false;
         var _loc2_:Vector.<uint> = new Vector.<uint>();
         var _loc3_:MapPoint = MapPoint.fromCellId(param1);
         var _loc4_:int = _loc3_.x;
         var _loc5_:int = _loc3_.y;
         var _loc7_:int = this._minRadius;
         for(;_loc7_ <= this._radius;_loc7_++)
         {
            switch(this._nDirection)
            {
               case DirectionsEnum.LEFT:
                  if(MapPoint.isInMap(_loc4_ - _loc7_,_loc5_ - _loc7_))
                  {
                     _loc6_ = this.addCell(_loc4_ - _loc7_,_loc5_ - _loc7_,_loc2_);
                  }
                  break;
               case DirectionsEnum.UP:
                  if(MapPoint.isInMap(_loc4_ - _loc7_,_loc5_ + _loc7_))
                  {
                     _loc6_ = this.addCell(_loc4_ - _loc7_,_loc5_ + _loc7_,_loc2_);
                  }
                  break;
               case DirectionsEnum.RIGHT:
                  if(MapPoint.isInMap(_loc4_ + _loc7_,_loc5_ + _loc7_))
                  {
                     _loc6_ = this.addCell(_loc4_ + _loc7_,_loc5_ + _loc7_,_loc2_);
                  }
                  break;
               case DirectionsEnum.DOWN:
                  if(MapPoint.isInMap(_loc4_ + _loc7_,_loc5_ - _loc7_))
                  {
                     _loc6_ = this.addCell(_loc4_ + _loc7_,_loc5_ - _loc7_,_loc2_);
                  }
                  break;
               case DirectionsEnum.UP_LEFT:
                  if(MapPoint.isInMap(_loc4_ - _loc7_,_loc5_))
                  {
                     _loc6_ = this.addCell(_loc4_ - _loc7_,_loc5_,_loc2_);
                  }
                  break;
               case DirectionsEnum.DOWN_LEFT:
                  if(MapPoint.isInMap(_loc4_,_loc5_ - _loc7_))
                  {
                     _loc6_ = this.addCell(_loc4_,_loc5_ - _loc7_,_loc2_);
                  }
                  break;
               case DirectionsEnum.DOWN_RIGHT:
                  if(MapPoint.isInMap(_loc4_ + _loc7_,_loc5_))
                  {
                     _loc6_ = this.addCell(_loc4_ + _loc7_,_loc5_,_loc2_);
                  }
                  break;
               case DirectionsEnum.UP_RIGHT:
                  if(MapPoint.isInMap(_loc4_,_loc5_ + _loc7_))
                  {
                     _loc6_ = this.addCell(_loc4_,_loc5_ + _loc7_,_loc2_);
                  }
                  break;
               default:
                  continue;
            }
            if(!_loc6_)
            {
               break;
            }
         }
         return _loc2_;
      }
      
      private function addCell(param1:int, param2:int, param3:Vector.<uint>) : Boolean {
         if(this._dataMapProvider == null || (this._dataMapProvider.pointMov(param1,param2)))
         {
            param3.push(MapPoint.fromCoords(param1,param2).cellId);
            return true;
         }
         return false;
      }
   }
}
