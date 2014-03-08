package com.ankamagames.jerakine.pathfinding
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class Pathfinding extends Object
   {
      
      public function Pathfinding() {
         super();
      }
      
      private static var _minX:int;
      
      private static var _maxX:int;
      
      private static var _minY:int;
      
      private static var _maxY:int;
      
      protected static var _log:Logger = Log.getLogger(getQualifiedClassName(Pathfinding));
      
      private static var _self:Pathfinding;
      
      public static function init(param1:int, param2:int, param3:int, param4:int) : void {
         _minX = param1;
         _maxX = param2;
         _minY = param3;
         _maxY = param4;
      }
      
      public static function findPath(param1:IDataMapProvider, param2:MapPoint, param3:MapPoint, param4:Boolean=true, param5:Boolean=true, param6:Function=null, param7:Array=null, param8:Boolean=false) : MovementPath {
         return new Pathfinding().processFindPath(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      private var _mapStatus:Array;
      
      private var _openList:Array;
      
      private var _movPath:MovementPath;
      
      private var _nHVCost:uint = 10;
      
      private var _nDCost:uint = 15;
      
      private var _nHeuristicCost:uint = 10;
      
      private var _bAllowDiagCornering:Boolean = false;
      
      private var _bAllowTroughEntity:Boolean;
      
      private var _bIsFighting:Boolean;
      
      private var _callBackFunction:Function;
      
      private var _argsFunction:Array;
      
      private var _enterFrameIsActive:Boolean = false;
      
      private var _map:IDataMapProvider;
      
      private var _start:MapPoint;
      
      private var _end:MapPoint;
      
      private var _allowDiag:Boolean;
      
      private var _endX:int;
      
      private var _endY:int;
      
      private var _endPoint:MapPoint;
      
      private var _startPoint:MapPoint;
      
      private var _startX:int;
      
      private var _startY:int;
      
      private var _endPointAux:MapPoint;
      
      private var _endAuxX:int;
      
      private var _endAuxY:int;
      
      private var _distanceToEnd:int;
      
      private var _nowY:int;
      
      private var _nowX:int;
      
      private var _currentTime:int;
      
      private var _maxTime:int = 30;
      
      private var _previousCellId:int;
      
      public function processFindPath(param1:IDataMapProvider, param2:MapPoint, param3:MapPoint, param4:Boolean=true, param5:Boolean=true, param6:Function=null, param7:Array=null, param8:Boolean=false) : MovementPath {
         this._callBackFunction = param6;
         this._argsFunction = param7;
         this._movPath = new MovementPath();
         this._movPath.start = param2;
         this._movPath.end = param3;
         this._bAllowTroughEntity = param5;
         this._bIsFighting = param8;
         this._bAllowDiagCornering = param4;
         if(param1.height == 0 || param1.width == 0 || param2 == null)
         {
            return this._movPath;
         }
         this.findPathInternal(param1,param2,param3,param4);
         if(this._callBackFunction == null)
         {
            return this._movPath;
         }
         return null;
      }
      
      private function isOpened(param1:int, param2:int) : Boolean {
         return this._mapStatus[param1][param2].opened;
      }
      
      private function isClosed(param1:int, param2:int) : Boolean {
         var _loc3_:CellInfo = this._mapStatus[param1][param2];
         if(!_loc3_ || !_loc3_.closed)
         {
            return false;
         }
         return _loc3_.closed;
      }
      
      private function nearerSquare() : uint {
         var _loc3_:* = NaN;
         var _loc1_:Number = 9999999;
         var _loc2_:uint = 0;
         var _loc4_:* = -1;
         var _loc5_:int = this._openList.length;
         while(++_loc4_ < _loc5_)
         {
            _loc3_ = this._mapStatus[this._openList[_loc4_][0]][this._openList[_loc4_][1]].heuristic + this._mapStatus[this._openList[_loc4_][0]][this._openList[_loc4_][1]].movementCost;
            _loc3_ = this._mapStatus[this._openList[_loc4_][0]][this._openList[_loc4_][1]].heuristic + this._mapStatus[this._openList[_loc4_][0]][this._openList[_loc4_][1]].movementCost;
            if(_loc3_ <= _loc1_)
            {
               _loc1_ = _loc3_;
               _loc2_ = _loc4_;
            }
         }
         return _loc2_;
      }
      
      private function closeSquare(param1:int, param2:int) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function openSquare(param1:int, param2:int, param3:Array, param4:uint, param5:Number, param6:Boolean) : void {
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         if(!param6)
         {
            _loc8_ = this._openList.length;
            _loc9_ = -1;
            while(++_loc9_ < _loc8_)
            {
               if(this._openList[_loc9_][0] == param1 && this._openList[_loc9_][1] == param2)
               {
                  param6 = true;
                  break;
               }
            }
         }
         if(!param6)
         {
            this._openList.push([param1,param2]);
            this._mapStatus[param1][param2] = new CellInfo(param5,null,true,false);
         }
         var _loc7_:CellInfo = this._mapStatus[param1][param2];
         _loc7_.parent = param3;
         _loc7_.movementCost = param4;
      }
      
      private function movementPathFromArray(param1:Array) : void {
         var _loc3_:PathElement = null;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length-1)
         {
            _loc3_ = new PathElement();
            _loc3_.step.x = param1[_loc2_].x;
            _loc3_.step.y = param1[_loc2_].y;
            _loc3_.orientation = param1[_loc2_].orientationTo(param1[_loc2_ + 1]);
            this._movPath.addPoint(_loc3_);
            _loc2_++;
         }
         this._movPath.compress();
         this._movPath.fill();
      }
      
      private function initFindPath() : void {
         this._currentTime = 0;
         if(this._callBackFunction == null)
         {
            this._maxTime = 2000000;
            this.pathFrame(null);
         }
         else
         {
            if(!this._enterFrameIsActive)
            {
               this._enterFrameIsActive = true;
               EnterFrameDispatcher.addEventListener(this.pathFrame,"pathFrame");
            }
            this._maxTime = 20;
         }
      }
      
      private function pathFrame(param1:Event) : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = NaN;
         var _loc7_:* = 0;
         var _loc8_:* = false;
         var _loc9_:* = false;
         var _loc10_:* = false;
         var _loc11_:* = false;
         var _loc12_:MapPoint = null;
         var _loc13_:* = 0;
         var _loc14_:* = NaN;
         if(this._currentTime == 0)
         {
            this._currentTime = getTimer();
         }
         if(this._openList.length > 0 && !this.isClosed(this._endY,this._endX))
         {
            _loc2_ = this.nearerSquare();
            this._nowY = this._openList[_loc2_][0];
            this._nowX = this._openList[_loc2_][1];
            this._previousCellId = MapPoint.fromCoords(this._nowX,this._nowY).cellId;
            this.closeSquare(this._nowY,this._nowX);
            _loc3_ = this._nowY-1;
            while(_loc3_ < this._nowY + 2)
            {
               _loc5_ = this._nowX-1;
               while(_loc5_ < this._nowX + 2)
               {
                  if(_loc3_ >= _minY && _loc3_ < _maxY && _loc5_ >= _minX && _loc5_ < _maxX && !(_loc3_ == this._nowY && _loc5_ == this._nowX) && ((this._allowDiag) || _loc3_ == this._nowY || _loc5_ == this._nowX && ((this._bAllowDiagCornering) || _loc3_ == this._nowY || _loc5_ == this._nowX || (this._map.pointMov(this._nowX,_loc3_,this._bAllowTroughEntity,this._previousCellId)) || (this._map.pointMov(_loc5_,this._nowY,this._bAllowTroughEntity,this._previousCellId)))))
                  {
                     if(!(!this._map.pointMov(this._nowX,_loc3_,this._bAllowTroughEntity,this._previousCellId) && !this._map.pointMov(_loc5_,this._nowY,this._bAllowTroughEntity,this._previousCellId) && !this._bIsFighting && (this._allowDiag)))
                     {
                        if(this._map.pointMov(_loc5_,_loc3_,this._bAllowTroughEntity,this._previousCellId))
                        {
                           if(!this.isClosed(_loc3_,_loc5_))
                           {
                              if(_loc5_ == this._endX && _loc3_ == this._endY)
                              {
                                 _loc6_ = 1;
                              }
                              else
                              {
                                 _loc6_ = this._map.pointWeight(_loc5_,_loc3_,this._bAllowTroughEntity);
                              }
                              _loc7_ = this._mapStatus[this._nowY][this._nowX].movementCost + (_loc3_ == this._nowY || _loc5_ == this._nowX?this._nHVCost:this._nDCost) * _loc6_;
                              if(this._bAllowTroughEntity)
                              {
                                 _loc8_ = _loc5_ + _loc3_ == this._endX + this._endY;
                                 _loc9_ = _loc5_ + _loc3_ == this._startX + this._startY;
                                 _loc10_ = _loc5_ - _loc3_ == this._endX - this._endY;
                                 _loc11_ = _loc5_ - _loc3_ == this._startX - this._startY;
                                 _loc12_ = MapPoint.fromCoords(_loc5_,_loc3_);
                                 if(!_loc8_ && !_loc10_ || !_loc9_ && !_loc11_)
                                 {
                                    _loc7_ = _loc7_ + _loc12_.distanceToCell(this._endPoint);
                                    _loc7_ = _loc7_ + _loc12_.distanceToCell(this._startPoint);
                                 }
                                 if(_loc5_ == this._endX || _loc3_ == this._endY)
                                 {
                                    _loc7_ = _loc7_ - 3;
                                 }
                                 if((_loc8_) || (_loc10_) || _loc5_ + _loc3_ == this._nowX + this._nowY || _loc5_ - _loc3_ == this._nowX - this._nowY)
                                 {
                                    _loc7_ = _loc7_ - 2;
                                 }
                                 if(_loc5_ == this._startX || _loc3_ == this._startY)
                                 {
                                    _loc7_ = _loc7_ - 3;
                                 }
                                 if((_loc9_) || (_loc11_))
                                 {
                                    _loc7_ = _loc7_ - 2;
                                 }
                                 _loc13_ = _loc12_.distanceToCell(this._endPoint);
                                 if(_loc13_ < this._distanceToEnd)
                                 {
                                    if(_loc5_ == this._endX || _loc3_ == this._endY || _loc5_ + _loc3_ == this._endX + this._endY || _loc5_ - _loc3_ == this._endX - this._endY)
                                    {
                                       this._endPointAux = _loc12_;
                                       this._endAuxX = _loc5_;
                                       this._endAuxY = _loc3_;
                                       this._distanceToEnd = _loc13_;
                                    }
                                 }
                              }
                              if(this.isOpened(_loc3_,_loc5_))
                              {
                                 if(_loc7_ < this._mapStatus[_loc3_][_loc5_].movementCost)
                                 {
                                    this.openSquare(_loc3_,_loc5_,[this._nowY,this._nowX],_loc7_,undefined,true);
                                 }
                              }
                              else
                              {
                                 _loc14_ = this._nHeuristicCost * Math.sqrt((this._endY - _loc3_) * (this._endY - _loc3_) + (this._endX - _loc5_) * (this._endX - _loc5_));
                                 this.openSquare(_loc3_,_loc5_,[this._nowY,this._nowX],_loc7_,_loc14_,false);
                              }
                           }
                        }
                     }
                  }
                  _loc5_++;
               }
               _loc3_++;
            }
            _loc4_ = getTimer();
            if(_loc4_ - this._currentTime < this._maxTime)
            {
               this.pathFrame(null);
            }
            else
            {
               this._currentTime = 0;
            }
         }
         else
         {
            this.endPathFrame();
         }
      }
      
      private function endPathFrame() : void {
         var _loc2_:Array = null;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:MapPoint = null;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         this._enterFrameIsActive = false;
         EnterFrameDispatcher.removeEventListener(this.pathFrame);
         var _loc1_:Boolean = this.isClosed(this._endY,this._endX);
         if(!_loc1_)
         {
            this._endY = this._endAuxY;
            this._endX = this._endAuxX;
            this._endPoint = this._endPointAux;
            _loc1_ = true;
            this._movPath.replaceEnd(this._endPoint);
         }
         this._previousCellId = -1;
         if(_loc1_)
         {
            _loc2_ = new Array();
            this._nowY = this._endY;
            this._nowX = this._endX;
            while(!(this._nowY == this._startY) || !(this._nowX == this._startX))
            {
               _loc2_.push(MapPoint.fromCoords(this._nowX,this._nowY));
               _loc3_ = this._mapStatus[this._nowY][this._nowX].parent[0];
               _loc4_ = this._mapStatus[this._nowY][this._nowX].parent[1];
               this._nowY = _loc3_;
               this._nowX = _loc4_;
            }
            _loc2_.push(this._startPoint);
            if(this._allowDiag)
            {
               _loc6_ = new Array();
               _loc7_ = 0;
               while(_loc7_ < _loc2_.length)
               {
                  _loc6_.push(_loc2_[_loc7_]);
                  this._previousCellId = _loc2_[_loc7_].cellId;
                  if(((_loc2_[_loc7_ + 2]) && (MapPoint(_loc2_[_loc7_]).distanceToCell(_loc2_[_loc7_ + 2]) == 1)) && (!this._map.isChangeZone(_loc2_[_loc7_].cellId,_loc2_[_loc7_ + 1].cellId)) && !this._map.isChangeZone(_loc2_[_loc7_ + 1].cellId,_loc2_[_loc7_ + 2].cellId))
                  {
                     _loc7_++;
                  }
                  else
                  {
                     if((_loc2_[_loc7_ + 3]) && MapPoint(_loc2_[_loc7_]).distanceToCell(_loc2_[_loc7_ + 3]) == 2)
                     {
                        _loc8_ = _loc2_[_loc7_].x;
                        _loc9_ = _loc2_[_loc7_].y;
                        _loc10_ = _loc2_[_loc7_ + 3].x;
                        _loc11_ = _loc2_[_loc7_ + 3].y;
                        _loc12_ = _loc8_ + Math.round((_loc10_ - _loc8_) / 2);
                        _loc13_ = _loc9_ + Math.round((_loc11_ - _loc9_) / 2);
                        if((this._map.pointMov(_loc12_,_loc13_,true,this._previousCellId)) && this._map.pointWeight(_loc12_,_loc13_) < 2)
                        {
                           _loc5_ = MapPoint.fromCoords(_loc12_,_loc13_);
                           _loc6_.push(_loc5_);
                           this._previousCellId = _loc5_.cellId;
                           _loc7_++;
                           _loc7_++;
                        }
                     }
                     else
                     {
                        if((_loc2_[_loc7_ + 2]) && MapPoint(_loc2_[_loc7_]).distanceToCell(_loc2_[_loc7_ + 2]) == 2)
                        {
                           _loc8_ = _loc2_[_loc7_].x;
                           _loc9_ = _loc2_[_loc7_].y;
                           _loc10_ = _loc2_[_loc7_ + 2].x;
                           _loc11_ = _loc2_[_loc7_ + 2].y;
                           _loc12_ = _loc2_[_loc7_ + 1].x;
                           _loc13_ = _loc2_[_loc7_ + 1].y;
                           if(_loc8_ + _loc9_ == _loc10_ + _loc11_ && !(_loc8_ - _loc9_ == _loc12_ - _loc13_) && !this._map.isChangeZone(MapPoint.fromCoords(_loc8_,_loc9_).cellId,MapPoint.fromCoords(_loc12_,_loc13_).cellId) && !this._map.isChangeZone(MapPoint.fromCoords(_loc12_,_loc13_).cellId,MapPoint.fromCoords(_loc10_,_loc11_).cellId))
                           {
                              _loc7_++;
                           }
                           else
                           {
                              if(_loc8_ - _loc9_ == _loc10_ - _loc11_ && !(_loc8_ - _loc9_ == _loc12_ - _loc13_) && !this._map.isChangeZone(MapPoint.fromCoords(_loc8_,_loc9_).cellId,MapPoint.fromCoords(_loc12_,_loc13_).cellId) && !this._map.isChangeZone(MapPoint.fromCoords(_loc12_,_loc13_).cellId,MapPoint.fromCoords(_loc10_,_loc11_).cellId))
                              {
                                 _loc7_++;
                              }
                              else
                              {
                                 if(_loc8_ == _loc10_ && !(_loc8_ == _loc12_) && this._map.pointWeight(_loc8_,_loc13_) < 2 && (this._map.pointMov(_loc8_,_loc13_,this._bAllowTroughEntity,this._previousCellId)))
                                 {
                                    _loc5_ = MapPoint.fromCoords(_loc8_,_loc13_);
                                    _loc6_.push(_loc5_);
                                    this._previousCellId = _loc5_.cellId;
                                    _loc7_++;
                                 }
                                 else
                                 {
                                    if(_loc9_ == _loc11_ && !(_loc9_ == _loc13_) && this._map.pointWeight(_loc12_,_loc9_) < 2 && (this._map.pointMov(_loc12_,_loc9_,this._bAllowTroughEntity,this._previousCellId)))
                                    {
                                       _loc5_ = MapPoint.fromCoords(_loc12_,_loc9_);
                                       _loc6_.push(_loc5_);
                                       this._previousCellId = _loc5_.cellId;
                                       _loc7_++;
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
                  _loc7_++;
               }
               _loc2_ = _loc6_;
            }
            if(_loc2_.length == 1)
            {
               _loc2_ = new Array();
            }
            _loc2_.reverse();
            this.movementPathFromArray(_loc2_);
         }
         if(this._callBackFunction != null)
         {
            if(this._argsFunction)
            {
               this._callBackFunction(this._movPath,this._argsFunction);
            }
            else
            {
               this._callBackFunction(this._movPath);
            }
         }
      }
      
      private function findPathInternal(param1:IDataMapProvider, param2:MapPoint, param3:MapPoint, param4:Boolean) : void {
         var _loc6_:uint = 0;
         this._map = param1;
         this._start = param2;
         this._end = param3;
         this._allowDiag = param4;
         this._endPoint = MapPoint.fromCoords(param3.x,param3.y);
         this._startPoint = MapPoint.fromCoords(param2.x,param2.y);
         this._endX = param3.x;
         this._endY = param3.y;
         this._startX = param2.x;
         this._startY = param2.y;
         this._endPointAux = this._startPoint;
         this._endAuxX = this._startX;
         this._endAuxY = this._startY;
         this._distanceToEnd = this._startPoint.distanceToCell(this._endPoint);
         this._mapStatus = new Array();
         var _loc5_:int = _minY;
         while(_loc5_ < _maxY)
         {
            this._mapStatus[_loc5_] = new Array();
            _loc6_ = _minX;
            while(_loc6_ <= _maxX)
            {
               this._mapStatus[_loc5_][_loc6_] = new CellInfo(0,new Array(),false,false);
               _loc6_++;
            }
            _loc5_++;
         }
         this._openList = new Array();
         this.openSquare(this._startY,this._startX,undefined,0,undefined,false);
         this.initFindPath();
      }
      
      private function tracePath(param1:Array) : void {
         var _loc3_:MapPoint = null;
         var _loc2_:String = new String("");
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_] as MapPoint;
            _loc2_ = _loc2_.concat(" " + _loc3_.cellId);
            _loc4_++;
         }
      }
      
      private function nearObstacle(param1:int, param2:int, param3:IDataMapProvider) : int {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
