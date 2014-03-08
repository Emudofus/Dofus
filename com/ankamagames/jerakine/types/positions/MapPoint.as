package com.ankamagames.jerakine.types.positions
{
   import flash.geom.Point;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.utils.errors.JerakineError;
   
   public class MapPoint extends Object
   {
      
      public function MapPoint() {
         super();
      }
      
      private static const VECTOR_RIGHT:Point = new Point(1,1);
      
      private static const VECTOR_DOWN_RIGHT:Point = new Point(1,0);
      
      private static const VECTOR_DOWN:Point = new Point(1,-1);
      
      private static const VECTOR_DOWN_LEFT:Point = new Point(0,-1);
      
      private static const VECTOR_LEFT:Point = new Point(-1,-1);
      
      private static const VECTOR_UP_LEFT:Point = new Point(-1,0);
      
      private static const VECTOR_UP:Point = new Point(-1,1);
      
      private static const VECTOR_UP_RIGHT:Point = new Point(0,1);
      
      public static const MAP_WIDTH:uint = 14;
      
      public static const MAP_HEIGHT:uint = 20;
      
      private static var _bInit:Boolean = false;
      
      public static var CELLPOS:Array = new Array();
      
      public static function fromCellId(param1:uint) : MapPoint {
         var _loc2_:MapPoint = new MapPoint();
         _loc2_._nCellId = param1;
         _loc2_.setFromCellId();
         return _loc2_;
      }
      
      public static function fromCoords(param1:int, param2:int) : MapPoint {
         var _loc3_:MapPoint = new MapPoint();
         _loc3_._nX = param1;
         _loc3_._nY = param2;
         _loc3_.setFromCoords();
         return _loc3_;
      }
      
      public static function getOrientationsDistance(param1:int, param2:int) : int {
         return Math.min(Math.abs(param2 - param1),Math.abs(8 - param2 + param1));
      }
      
      public static function isInMap(param1:int, param2:int) : Boolean {
         return param1 + param2 >= 0 && param1 - param2 >= 0 && param1 - param2 < MAP_HEIGHT * 2 && param1 + param2 < MAP_WIDTH * 2;
      }
      
      private static function init() : void {
         var _loc4_:* = 0;
         _bInit = true;
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         while(_loc5_ < MAP_HEIGHT)
         {
            _loc4_ = 0;
            while(_loc4_ < MAP_WIDTH)
            {
               CELLPOS[_loc3_] = new Point(_loc1_ + _loc4_,_loc2_ + _loc4_);
               _loc3_++;
               _loc4_++;
            }
            _loc1_++;
            _loc4_ = 0;
            while(_loc4_ < MAP_WIDTH)
            {
               CELLPOS[_loc3_] = new Point(_loc1_ + _loc4_,_loc2_ + _loc4_);
               _loc3_++;
               _loc4_++;
            }
            _loc2_--;
            _loc5_++;
         }
      }
      
      private var _nCellId:uint;
      
      private var _nX:int;
      
      private var _nY:int;
      
      public function get cellId() : uint {
         return this._nCellId;
      }
      
      public function set cellId(param1:uint) : void {
         this._nCellId = param1;
         this.setFromCellId();
      }
      
      public function get x() : int {
         return this._nX;
      }
      
      public function set x(param1:int) : void {
         this._nX = param1;
         this.setFromCoords();
      }
      
      public function get y() : int {
         return this._nY;
      }
      
      public function set y(param1:int) : void {
         this._nY = param1;
         this.setFromCoords();
      }
      
      public function distanceTo(param1:MapPoint) : uint {
         return Math.sqrt(Math.pow(param1.x - this.x,2) + Math.pow(param1.y - this.y,2));
      }
      
      public function distanceToCell(param1:MapPoint) : int {
         return Math.abs(this.x - param1.x) + Math.abs(this.y - param1.y);
      }
      
      public function orientationTo(param1:MapPoint) : uint {
         var _loc3_:uint = 0;
         if(this.x == param1.x && this.y == param1.y)
         {
            return 1;
         }
         var _loc2_:Point = new Point();
         _loc2_.x = param1.x > this.x?1:param1.x < this.x?-1:0;
         _loc2_.y = param1.y > this.y?1:param1.y < this.y?-1:0;
         if(_loc2_.x == VECTOR_RIGHT.x && _loc2_.y == VECTOR_RIGHT.y)
         {
            _loc3_ = DirectionsEnum.RIGHT;
         }
         else
         {
            if(_loc2_.x == VECTOR_DOWN_RIGHT.x && _loc2_.y == VECTOR_DOWN_RIGHT.y)
            {
               _loc3_ = DirectionsEnum.DOWN_RIGHT;
            }
            else
            {
               if(_loc2_.x == VECTOR_DOWN.x && _loc2_.y == VECTOR_DOWN.y)
               {
                  _loc3_ = DirectionsEnum.DOWN;
               }
               else
               {
                  if(_loc2_.x == VECTOR_DOWN_LEFT.x && _loc2_.y == VECTOR_DOWN_LEFT.y)
                  {
                     _loc3_ = DirectionsEnum.DOWN_LEFT;
                  }
                  else
                  {
                     if(_loc2_.x == VECTOR_LEFT.x && _loc2_.y == VECTOR_LEFT.y)
                     {
                        _loc3_ = DirectionsEnum.LEFT;
                     }
                     else
                     {
                        if(_loc2_.x == VECTOR_UP_LEFT.x && _loc2_.y == VECTOR_UP_LEFT.y)
                        {
                           _loc3_ = DirectionsEnum.UP_LEFT;
                        }
                        else
                        {
                           if(_loc2_.x == VECTOR_UP.x && _loc2_.y == VECTOR_UP.y)
                           {
                              _loc3_ = DirectionsEnum.UP;
                           }
                           else
                           {
                              if(_loc2_.x == VECTOR_UP_RIGHT.x && _loc2_.y == VECTOR_UP_RIGHT.y)
                              {
                                 _loc3_ = DirectionsEnum.UP_RIGHT;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function advancedOrientationTo(param1:MapPoint, param2:Boolean=true) : uint {
         if(!param1)
         {
            return 0;
         }
         var _loc3_:int = param1.x - this.x;
         var _loc4_:int = this.y - param1.y;
         var _loc5_:int = Math.acos(_loc3_ / Math.sqrt(Math.pow(_loc3_,2) + Math.pow(_loc4_,2))) * 180 / Math.PI * (param1.y > this.y?-1:1);
         if(param2)
         {
            _loc5_ = Math.round(_loc5_ / 90) * 2 + 1;
         }
         else
         {
            _loc5_ = Math.round(_loc5_ / 45) + 1;
         }
         if(_loc5_ < 0)
         {
            _loc5_ = _loc5_ + 8;
         }
         return _loc5_;
      }
      
      public function getNearestFreeCell(param1:IDataMapProvider, param2:Boolean=true) : MapPoint {
         var _loc3_:MapPoint = null;
         var _loc4_:uint = 0;
         while(_loc4_ < 8)
         {
            _loc3_ = this.getNearestFreeCellInDirection(_loc4_,param1,false,param2);
            if(_loc3_)
            {
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getNearestCellInDirection(param1:uint) : MapPoint {
         var _loc2_:MapPoint = null;
         switch(param1)
         {
            case 0:
               _loc2_ = MapPoint.fromCoords(this._nX + 1,this._nY + 1);
               break;
            case 1:
               _loc2_ = MapPoint.fromCoords(this._nX + 1,this._nY);
               break;
            case 2:
               _loc2_ = MapPoint.fromCoords(this._nX + 1,this._nY-1);
               break;
            case 3:
               _loc2_ = MapPoint.fromCoords(this._nX,this._nY-1);
               break;
            case 4:
               _loc2_ = MapPoint.fromCoords(this._nX-1,this._nY-1);
               break;
            case 5:
               _loc2_ = MapPoint.fromCoords(this._nX-1,this._nY);
               break;
            case 6:
               _loc2_ = MapPoint.fromCoords(this._nX-1,this._nY + 1);
               break;
            case 7:
               _loc2_ = MapPoint.fromCoords(this._nX,this._nY + 1);
               break;
         }
         if(MapPoint.isInMap(_loc2_._nX,_loc2_._nY))
         {
            return _loc2_;
         }
         return null;
      }
      
      public function getNearestFreeCellInDirection(param1:uint, param2:IDataMapProvider, param3:Boolean=true, param4:Boolean=true, param5:Array=null) : MapPoint {
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc12_:* = 0;
         var _loc6_:MapPoint = null;
         if(param5 == null)
         {
            param5 = new Array();
         }
         var _loc7_:Vector.<MapPoint> = new Vector.<MapPoint>(8,true);
         var _loc8_:Vector.<int> = new Vector.<int>(8,true);
         _loc9_ = 0;
         while(_loc9_ < 8)
         {
            _loc6_ = this.getNearestCellInDirection(_loc9_);
            if(!(_loc6_ == null) && param5.indexOf(_loc6_.cellId) == -1)
            {
               _loc10_ = param2.getCellSpeed(_loc6_.cellId);
               if(!param2.pointMov(_loc6_._nX,_loc6_._nY,param4,this.cellId))
               {
                  _loc10_ = -100;
               }
               _loc8_[_loc9_] = getOrientationsDistance(_loc9_,param1) + (_loc10_ >= 0?5 - _loc10_:11 + Math.abs(_loc10_));
            }
            else
            {
               _loc8_[_loc9_] = 1000;
            }
            _loc7_[_loc9_] = _loc6_;
            _loc9_++;
         }
         _loc6_ = null;
         var _loc11_:* = 0;
         var _loc13_:int = _loc8_[0];
         _loc9_ = 1;
         while(_loc9_ < 8)
         {
            _loc12_ = _loc8_[_loc9_];
            if(_loc12_ < _loc13_ && !(_loc7_[_loc9_] == null))
            {
               _loc13_ = _loc12_;
               _loc11_ = _loc9_;
            }
            _loc9_++;
         }
         _loc6_ = _loc7_[_loc11_];
         if(_loc6_ == null && (param3) && (param2.pointMov(this._nX,this._nY,param4,this.cellId)))
         {
            return this;
         }
         return _loc6_;
      }
      
      public function equals(param1:MapPoint) : Boolean {
         return param1.cellId == this.cellId;
      }
      
      public function toString() : String {
         return "[MapPoint(x:" + this._nX + ", y:" + this._nY + ", id:" + this._nCellId + ")]";
      }
      
      private function setFromCoords() : void {
         if(!_bInit)
         {
            init();
         }
         this._nCellId = (this._nX - this._nY) * MAP_WIDTH + this._nY + (this._nX - this._nY) / 2;
      }
      
      private function setFromCellId() : void {
         if(!_bInit)
         {
            init();
         }
         if(!CELLPOS[this._nCellId])
         {
            throw new JerakineError("Cell identifier out of bounds (" + this._nCellId + ").");
         }
         else
         {
            _loc1_ = CELLPOS[this._nCellId];
            this._nX = _loc1_.x;
            this._nY = _loc1_.y;
            return;
         }
      }
   }
}
