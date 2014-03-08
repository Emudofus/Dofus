package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class Cross extends Object implements IZone
   {
      
      public function Cross(param1:uint, param2:uint, param3:IDataMapProvider) {
         this.disabledDirection = [];
         super();
         this.minRadius = param1;
         this.radius = param2;
         this._dataMapProvider = param3;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Cross));
      
      private var _radius:uint = 0;
      
      private var _minRadius:uint = 0;
      
      private var _dataMapProvider:IDataMapProvider;
      
      private var _direction:uint;
      
      private var _diagonal:Boolean = false;
      
      private var _allDirections:Boolean = false;
      
      public function get radius() : uint {
         return this._radius;
      }
      
      public function set radius(param1:uint) : void {
         this._radius = param1;
      }
      
      public function get surface() : uint {
         return this._radius * 4 + 1;
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
      
      public function set diagonal(param1:Boolean) : void {
         this._diagonal = param1;
      }
      
      public function get diagonal() : Boolean {
         return this._diagonal;
      }
      
      public function set allDirections(param1:Boolean) : void {
         this._allDirections = param1;
         if(this._allDirections)
         {
            this.diagonal = false;
         }
      }
      
      public function get allDirections() : Boolean {
         return this._allDirections;
      }
      
      public var disabledDirection:Array;
      
      public var onlyPerpendicular:Boolean = false;
      
      public function getCells(param1:uint=0) : Vector.<uint> {
         var _loc2_:Vector.<uint> = new Vector.<uint>();
         if(this._minRadius == 0)
         {
            _loc2_.push(param1);
         }
         if(this.onlyPerpendicular)
         {
            switch(this._direction)
            {
               case DirectionsEnum.DOWN_RIGHT:
               case DirectionsEnum.UP_LEFT:
                  this.disabledDirection = [DirectionsEnum.DOWN_RIGHT,DirectionsEnum.UP_LEFT];
                  break;
               case DirectionsEnum.UP_RIGHT:
               case DirectionsEnum.DOWN_LEFT:
                  this.disabledDirection = [DirectionsEnum.UP_RIGHT,DirectionsEnum.DOWN_LEFT];
                  break;
               case DirectionsEnum.DOWN:
               case DirectionsEnum.UP:
                  this.disabledDirection = [DirectionsEnum.DOWN,DirectionsEnum.UP];
                  break;
               case DirectionsEnum.RIGHT:
               case DirectionsEnum.LEFT:
                  this.disabledDirection = [DirectionsEnum.RIGHT,DirectionsEnum.LEFT];
                  break;
            }
         }
         var _loc3_:MapPoint = MapPoint.fromCellId(param1);
         var _loc4_:int = _loc3_.x;
         var _loc5_:int = _loc3_.y;
         var _loc6_:int = this._radius;
         while(_loc6_ > 0)
         {
            if(_loc6_ >= this._minRadius)
            {
               if(!this._diagonal)
               {
                  if((MapPoint.isInMap(_loc4_ + _loc6_,_loc5_)) && this.disabledDirection.indexOf(DirectionsEnum.DOWN_RIGHT) == -1)
                  {
                     this.addCell(_loc4_ + _loc6_,_loc5_,_loc2_);
                  }
                  if((MapPoint.isInMap(_loc4_ - _loc6_,_loc5_)) && this.disabledDirection.indexOf(DirectionsEnum.UP_LEFT) == -1)
                  {
                     this.addCell(_loc4_ - _loc6_,_loc5_,_loc2_);
                  }
                  if((MapPoint.isInMap(_loc4_,_loc5_ + _loc6_)) && this.disabledDirection.indexOf(DirectionsEnum.UP_RIGHT) == -1)
                  {
                     this.addCell(_loc4_,_loc5_ + _loc6_,_loc2_);
                  }
                  if((MapPoint.isInMap(_loc4_,_loc5_ - _loc6_)) && this.disabledDirection.indexOf(DirectionsEnum.DOWN_LEFT) == -1)
                  {
                     this.addCell(_loc4_,_loc5_ - _loc6_,_loc2_);
                  }
               }
               if((this._diagonal) || (this._allDirections))
               {
                  if((MapPoint.isInMap(_loc4_ + _loc6_,_loc5_ - _loc6_)) && this.disabledDirection.indexOf(DirectionsEnum.DOWN) == -1)
                  {
                     this.addCell(_loc4_ + _loc6_,_loc5_ - _loc6_,_loc2_);
                  }
                  if((MapPoint.isInMap(_loc4_ - _loc6_,_loc5_ + _loc6_)) && this.disabledDirection.indexOf(DirectionsEnum.UP) == -1)
                  {
                     this.addCell(_loc4_ - _loc6_,_loc5_ + _loc6_,_loc2_);
                  }
                  if((MapPoint.isInMap(_loc4_ + _loc6_,_loc5_ + _loc6_)) && this.disabledDirection.indexOf(DirectionsEnum.RIGHT) == -1)
                  {
                     this.addCell(_loc4_ + _loc6_,_loc5_ + _loc6_,_loc2_);
                  }
                  if((MapPoint.isInMap(_loc4_ - _loc6_,_loc5_ - _loc6_)) && this.disabledDirection.indexOf(DirectionsEnum.LEFT) == -1)
                  {
                     this.addCell(_loc4_ - _loc6_,_loc5_ - _loc6_,_loc2_);
                  }
               }
            }
            _loc6_--;
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
