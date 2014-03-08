package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   
   public class Cone extends Object implements IZone
   {
      
      public function Cone(param1:uint, param2:uint, param3:IDataMapProvider) {
         super();
         this.radius = param2;
         this.minRadius = param1;
         this._dataMapProvider = param3;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Cone));
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 0;
      
      private var _nDirection:uint = 1;
      
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
         this._nDirection = param1;
      }
      
      public function get direction() : uint {
         return this._nDirection;
      }
      
      public function get surface() : uint {
         return Math.pow(this._radius + 1,2);
      }
      
      public function getCells(param1:uint=0) : Vector.<uint> {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc2_:Vector.<uint> = new Vector.<uint>();
         var _loc3_:MapPoint = MapPoint.fromCellId(param1);
         var _loc4_:int = _loc3_.x;
         var _loc5_:int = _loc3_.y;
         if(this._radius == 0)
         {
            if(this._minRadius == 0)
            {
               _loc2_.push(param1);
            }
            return _loc2_;
         }
         var _loc8_:* = 1;
         var _loc9_:uint = 0;
         switch(this._nDirection)
         {
            case DirectionsEnum.UP_LEFT:
               _loc6_ = _loc4_;
               while(_loc6_ >= _loc4_ - this._radius)
               {
                  _loc7_ = -_loc9_;
                  while(_loc7_ <= _loc9_)
                  {
                     if(!this._minRadius || Math.abs(_loc4_ - _loc6_) + Math.abs(_loc7_) >= this._minRadius)
                     {
                        if(MapPoint.isInMap(_loc6_,_loc7_ + _loc5_))
                        {
                           this.addCell(_loc6_,_loc7_ + _loc5_,_loc2_);
                        }
                     }
                     _loc7_++;
                  }
                  _loc9_ = _loc9_ + _loc8_;
                  _loc6_--;
               }
               break;
            case DirectionsEnum.DOWN_LEFT:
               _loc7_ = _loc5_;
               while(_loc7_ >= _loc5_ - this._radius)
               {
                  _loc6_ = -_loc9_;
                  while(_loc6_ <= _loc9_)
                  {
                     if(!this._minRadius || Math.abs(_loc6_) + Math.abs(_loc5_ - _loc7_) >= this._minRadius)
                     {
                        if(MapPoint.isInMap(_loc6_ + _loc4_,_loc7_))
                        {
                           this.addCell(_loc6_ + _loc4_,_loc7_,_loc2_);
                        }
                     }
                     _loc6_++;
                  }
                  _loc9_ = _loc9_ + _loc8_;
                  _loc7_--;
               }
               break;
            case DirectionsEnum.DOWN_RIGHT:
               _loc6_ = _loc4_;
               while(_loc6_ <= _loc4_ + this._radius)
               {
                  _loc7_ = -_loc9_;
                  while(_loc7_ <= _loc9_)
                  {
                     if(!this._minRadius || Math.abs(_loc4_ - _loc6_) + Math.abs(_loc7_) >= this._minRadius)
                     {
                        if(MapPoint.isInMap(_loc6_,_loc7_ + _loc5_))
                        {
                           this.addCell(_loc6_,_loc7_ + _loc5_,_loc2_);
                        }
                     }
                     _loc7_++;
                  }
                  _loc9_ = _loc9_ + _loc8_;
                  _loc6_++;
               }
               break;
            case DirectionsEnum.UP_RIGHT:
               _loc7_ = _loc5_;
               while(_loc7_ <= _loc5_ + this._radius)
               {
                  _loc6_ = -_loc9_;
                  while(_loc6_ <= _loc9_)
                  {
                     if(!this._minRadius || Math.abs(_loc6_) + Math.abs(_loc5_ - _loc7_) >= this._minRadius)
                     {
                        if(MapPoint.isInMap(_loc6_ + _loc4_,_loc7_))
                        {
                           this.addCell(_loc6_ + _loc4_,_loc7_,_loc2_);
                        }
                     }
                     _loc6_++;
                  }
                  _loc9_ = _loc9_ + _loc8_;
                  _loc7_++;
               }
               break;
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
