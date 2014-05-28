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
      
      protected static var _log:Logger;
      
      private static var _self:Pathfinding;
      
      public static function init(minX:int, maxX:int, minY:int, maxY:int) : void {
         _minX = minX;
         _maxX = maxX;
         _minY = minY;
         _maxY = maxY;
      }
      
      public static function findPath(map:IDataMapProvider, start:MapPoint, end:MapPoint, allowDiag:Boolean = true, bAllowTroughEntity:Boolean = true, callBack:Function = null, args:Array = null, bIsFighting:Boolean = false) : MovementPath {
         return new Pathfinding().processFindPath(map,start,end,allowDiag,bAllowTroughEntity,callBack,args,bIsFighting);
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
      
      public function processFindPath(map:IDataMapProvider, start:MapPoint, end:MapPoint, allowDiag:Boolean = true, bAllowTroughEntity:Boolean = true, callBack:Function = null, args:Array = null, bIsFighting:Boolean = false) : MovementPath {
         this._callBackFunction = callBack;
         this._argsFunction = args;
         this._movPath = new MovementPath();
         this._movPath.start = start;
         this._movPath.end = end;
         this._bAllowTroughEntity = bAllowTroughEntity;
         this._bIsFighting = bIsFighting;
         this._bAllowDiagCornering = allowDiag;
         if((map.height == 0) || (map.width == 0) || (start == null))
         {
            return this._movPath;
         }
         this.findPathInternal(map,start,end,allowDiag);
         if(this._callBackFunction == null)
         {
            return this._movPath;
         }
         return null;
      }
      
      private function isOpened(y:int, x:int) : Boolean {
         return this._mapStatus[y][x].opened;
      }
      
      private function isClosed(y:int, x:int) : Boolean {
         var cellInfo:CellInfo = this._mapStatus[y][x];
         if((!cellInfo) || (!cellInfo.closed))
         {
            return false;
         }
         return cellInfo.closed;
      }
      
      private function nearerSquare() : uint {
         var thisF:* = NaN;
         var minimum:Number = 9999999;
         var indexFound:uint = 0;
         var i:int = -1;
         var len:int = this._openList.length;
         while(++i < len)
         {
            thisF = this._mapStatus[this._openList[i][0]][this._openList[i][1]].heuristic + this._mapStatus[this._openList[i][0]][this._openList[i][1]].movementCost;
            thisF = this._mapStatus[this._openList[i][0]][this._openList[i][1]].heuristic + this._mapStatus[this._openList[i][0]][this._openList[i][1]].movementCost;
            if(thisF <= minimum)
            {
               minimum = thisF;
               indexFound = i;
            }
         }
         return indexFound;
      }
      
      private function closeSquare(y:int, x:int) : void {
         var len:uint = this._openList.length;
         var i:int = -1;
         while(++i < len)
         {
            if(this._openList[i][0] == y)
            {
               if(this._openList[i][1] == x)
               {
                  this._openList.splice(i,1);
                  break;
               }
            }
         }
         var cellInfo:CellInfo = this._mapStatus[y][x];
         cellInfo.opened = false;
         cellInfo.closed = true;
      }
      
      private function openSquare(y:int, x:int, parent:Array, movementCost:uint, heuristic:Number, replacing:Boolean) : void {
         var len:* = 0;
         var i:* = 0;
         if(!replacing)
         {
            len = this._openList.length;
            i = -1;
            while(++i < len)
            {
               if((this._openList[i][0] == y) && (this._openList[i][1] == x))
               {
                  replacing = true;
                  break;
               }
            }
         }
         if(!replacing)
         {
            this._openList.push([y,x]);
            this._mapStatus[y][x] = new CellInfo(heuristic,null,true,false);
         }
         var cellInfo:CellInfo = this._mapStatus[y][x];
         cellInfo.parent = parent;
         cellInfo.movementCost = movementCost;
      }
      
      private function movementPathFromArray(returnPath:Array) : void {
         var pElem:PathElement = null;
         var i:uint = 0;
         while(i < returnPath.length - 1)
         {
            pElem = new PathElement();
            pElem.step.x = returnPath[i].x;
            pElem.step.y = returnPath[i].y;
            pElem.orientation = returnPath[i].orientationTo(returnPath[i + 1]);
            this._movPath.addPoint(pElem);
            i++;
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
      
      private function pathFrame(E:Event) : void {
         var n:* = 0;
         var j:* = 0;
         var time:* = 0;
         var i:* = 0;
         var pointWeight:* = NaN;
         var movementCost:* = 0;
         var cellOnEndColumn:* = false;
         var cellOnStartColumn:* = false;
         var cellOnEndLine:* = false;
         var cellOnStartLine:* = false;
         var mp:MapPoint = null;
         var distanceTmpToEnd:* = 0;
         var heuristic:* = NaN;
         if(this._currentTime == 0)
         {
            this._currentTime = getTimer();
         }
         if((this._openList.length > 0) && (!this.isClosed(this._endY,this._endX)))
         {
            n = this.nearerSquare();
            this._nowY = this._openList[n][0];
            this._nowX = this._openList[n][1];
            this._previousCellId = MapPoint.fromCoords(this._nowX,this._nowY).cellId;
            this.closeSquare(this._nowY,this._nowX);
            j = this._nowY - 1;
            while(j < this._nowY + 2)
            {
               i = this._nowX - 1;
               while(i < this._nowX + 2)
               {
                  if((j >= _minY) && (j < _maxY) && (i >= _minX) && (i < _maxX) && (!((j == this._nowY) && (i == this._nowX))) && ((this._allowDiag) || (j == this._nowY) || (i == this._nowX) && ((this._bAllowDiagCornering) || (j == this._nowY) || (i == this._nowX) || (this._map.pointMov(this._nowX,j,this._bAllowTroughEntity,this._previousCellId)) || (this._map.pointMov(i,this._nowY,this._bAllowTroughEntity,this._previousCellId)))))
                  {
                     if(!((!this._map.pointMov(this._nowX,j,this._bAllowTroughEntity,this._previousCellId)) && (!this._map.pointMov(i,this._nowY,this._bAllowTroughEntity,this._previousCellId)) && (!this._bIsFighting) && (this._allowDiag)))
                     {
                        if(this._map.pointMov(i,j,this._bAllowTroughEntity,this._previousCellId))
                        {
                           if(!this.isClosed(j,i))
                           {
                              if((i == this._endX) && (j == this._endY))
                              {
                                 pointWeight = 1;
                              }
                              else
                              {
                                 pointWeight = this._map.pointWeight(i,j,this._bAllowTroughEntity);
                              }
                              movementCost = this._mapStatus[this._nowY][this._nowX].movementCost + ((j == this._nowY) || (i == this._nowX)?this._nHVCost:this._nDCost) * pointWeight;
                              if(this._bAllowTroughEntity)
                              {
                                 cellOnEndColumn = i + j == this._endX + this._endY;
                                 cellOnStartColumn = i + j == this._startX + this._startY;
                                 cellOnEndLine = i - j == this._endX - this._endY;
                                 cellOnStartLine = i - j == this._startX - this._startY;
                                 mp = MapPoint.fromCoords(i,j);
                                 if((!cellOnEndColumn) && (!cellOnEndLine) || (!cellOnStartColumn) && (!cellOnStartLine))
                                 {
                                    movementCost = movementCost + mp.distanceToCell(this._endPoint);
                                    movementCost = movementCost + mp.distanceToCell(this._startPoint);
                                 }
                                 if((i == this._endX) || (j == this._endY))
                                 {
                                    movementCost = movementCost - 3;
                                 }
                                 if((cellOnEndColumn) || (cellOnEndLine) || (i + j == this._nowX + this._nowY) || (i - j == this._nowX - this._nowY))
                                 {
                                    movementCost = movementCost - 2;
                                 }
                                 if((i == this._startX) || (j == this._startY))
                                 {
                                    movementCost = movementCost - 3;
                                 }
                                 if((cellOnStartColumn) || (cellOnStartLine))
                                 {
                                    movementCost = movementCost - 2;
                                 }
                                 distanceTmpToEnd = mp.distanceToCell(this._endPoint);
                                 if(distanceTmpToEnd < this._distanceToEnd)
                                 {
                                    if((i == this._endX) || (j == this._endY) || (i + j == this._endX + this._endY) || (i - j == this._endX - this._endY))
                                    {
                                       this._endPointAux = mp;
                                       this._endAuxX = i;
                                       this._endAuxY = j;
                                       this._distanceToEnd = distanceTmpToEnd;
                                    }
                                 }
                              }
                              if(this.isOpened(j,i))
                              {
                                 if(movementCost < this._mapStatus[j][i].movementCost)
                                 {
                                    this.openSquare(j,i,[this._nowY,this._nowX],movementCost,undefined,true);
                                 }
                              }
                              else
                              {
                                 heuristic = this._nHeuristicCost * Math.sqrt((this._endY - j) * (this._endY - j) + (this._endX - i) * (this._endX - i));
                                 this.openSquare(j,i,[this._nowY,this._nowX],movementCost,heuristic,false);
                              }
                           }
                        }
                     }
                  }
                  i++;
               }
               j++;
            }
            time = getTimer();
            if(time - this._currentTime < this._maxTime)
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
         var returnPath:Array = null;
         var newY:* = 0;
         var newX:* = 0;
         var tmpMapPoint:MapPoint = null;
         var returnPathOpti:Array = null;
         var k:uint = 0;
         var kX:* = 0;
         var kY:* = 0;
         var nextX:* = 0;
         var nextY:* = 0;
         var interX:* = 0;
         var interY:* = 0;
         this._enterFrameIsActive = false;
         EnterFrameDispatcher.removeEventListener(this.pathFrame);
         var pFound:Boolean = this.isClosed(this._endY,this._endX);
         if(!pFound)
         {
            this._endY = this._endAuxY;
            this._endX = this._endAuxX;
            this._endPoint = this._endPointAux;
            pFound = true;
            this._movPath.replaceEnd(this._endPoint);
         }
         this._previousCellId = -1;
         if(pFound)
         {
            returnPath = new Array();
            this._nowY = this._endY;
            this._nowX = this._endX;
            while((!(this._nowY == this._startY)) || (!(this._nowX == this._startX)))
            {
               returnPath.push(MapPoint.fromCoords(this._nowX,this._nowY));
               newY = this._mapStatus[this._nowY][this._nowX].parent[0];
               newX = this._mapStatus[this._nowY][this._nowX].parent[1];
               this._nowY = newY;
               this._nowX = newX;
            }
            returnPath.push(this._startPoint);
            if(this._allowDiag)
            {
               returnPathOpti = new Array();
               k = 0;
               while(k < returnPath.length)
               {
                  returnPathOpti.push(returnPath[k]);
                  this._previousCellId = returnPath[k].cellId;
                  if((returnPath[k + 2] && MapPoint(returnPath[k]).distanceToCell(returnPath[k + 2]) == 1) && (!this._map.isChangeZone(returnPath[k].cellId,returnPath[k + 1].cellId)) && (!this._map.isChangeZone(returnPath[k + 1].cellId,returnPath[k + 2].cellId)))
                  {
                     k++;
                  }
                  else if((returnPath[k + 3]) && (MapPoint(returnPath[k]).distanceToCell(returnPath[k + 3]) == 2))
                  {
                     kX = returnPath[k].x;
                     kY = returnPath[k].y;
                     nextX = returnPath[k + 3].x;
                     nextY = returnPath[k + 3].y;
                     interX = kX + Math.round((nextX - kX) / 2);
                     interY = kY + Math.round((nextY - kY) / 2);
                     if((this._map.pointMov(interX,interY,true,this._previousCellId)) && (this._map.pointWeight(interX,interY) < 2))
                     {
                        tmpMapPoint = MapPoint.fromCoords(interX,interY);
                        returnPathOpti.push(tmpMapPoint);
                        this._previousCellId = tmpMapPoint.cellId;
                        k++;
                        k++;
                     }
                  }
                  else if((returnPath[k + 2]) && (MapPoint(returnPath[k]).distanceToCell(returnPath[k + 2]) == 2))
                  {
                     kX = returnPath[k].x;
                     kY = returnPath[k].y;
                     nextX = returnPath[k + 2].x;
                     nextY = returnPath[k + 2].y;
                     interX = returnPath[k + 1].x;
                     interY = returnPath[k + 1].y;
                     if((kX + kY == nextX + nextY) && (!(kX - kY == interX - interY)) && (!this._map.isChangeZone(MapPoint.fromCoords(kX,kY).cellId,MapPoint.fromCoords(interX,interY).cellId)) && (!this._map.isChangeZone(MapPoint.fromCoords(interX,interY).cellId,MapPoint.fromCoords(nextX,nextY).cellId)))
                     {
                        k++;
                     }
                     else if((kX - kY == nextX - nextY) && (!(kX - kY == interX - interY)) && (!this._map.isChangeZone(MapPoint.fromCoords(kX,kY).cellId,MapPoint.fromCoords(interX,interY).cellId)) && (!this._map.isChangeZone(MapPoint.fromCoords(interX,interY).cellId,MapPoint.fromCoords(nextX,nextY).cellId)))
                     {
                        k++;
                     }
                     else if((kX == nextX) && (!(kX == interX)) && (this._map.pointWeight(kX,interY) < 2) && (this._map.pointMov(kX,interY,this._bAllowTroughEntity,this._previousCellId)))
                     {
                        tmpMapPoint = MapPoint.fromCoords(kX,interY);
                        returnPathOpti.push(tmpMapPoint);
                        this._previousCellId = tmpMapPoint.cellId;
                        k++;
                     }
                     else if((kY == nextY) && (!(kY == interY)) && (this._map.pointWeight(interX,kY) < 2) && (this._map.pointMov(interX,kY,this._bAllowTroughEntity,this._previousCellId)))
                     {
                        tmpMapPoint = MapPoint.fromCoords(interX,kY);
                        returnPathOpti.push(tmpMapPoint);
                        this._previousCellId = tmpMapPoint.cellId;
                        k++;
                     }
                     
                     
                     
                  }
                  
                  
                  k++;
               }
               returnPath = returnPathOpti;
            }
            if(returnPath.length == 1)
            {
               returnPath = new Array();
            }
            returnPath.reverse();
            this.movementPathFromArray(returnPath);
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
      
      private function findPathInternal(map:IDataMapProvider, start:MapPoint, end:MapPoint, allowDiag:Boolean) : void {
         var x:uint = 0;
         this._map = map;
         this._start = start;
         this._end = end;
         this._allowDiag = allowDiag;
         this._endPoint = MapPoint.fromCoords(end.x,end.y);
         this._startPoint = MapPoint.fromCoords(start.x,start.y);
         this._endX = end.x;
         this._endY = end.y;
         this._startX = start.x;
         this._startY = start.y;
         this._endPointAux = this._startPoint;
         this._endAuxX = this._startX;
         this._endAuxY = this._startY;
         this._distanceToEnd = this._startPoint.distanceToCell(this._endPoint);
         this._mapStatus = new Array();
         var y:int = _minY;
         while(y < _maxY)
         {
            this._mapStatus[y] = new Array();
            x = _minX;
            while(x <= _maxX)
            {
               this._mapStatus[y][x] = new CellInfo(0,new Array(),false,false);
               x++;
            }
            y++;
         }
         this._openList = new Array();
         this.openSquare(this._startY,this._startX,undefined,0,undefined,false);
         this.initFindPath();
      }
      
      private function tracePath(returnPath:Array) : void {
         var point:MapPoint = null;
         var cheminEnChaine:String = new String("");
         var i:uint = 0;
         while(i < returnPath.length)
         {
            point = returnPath[i] as MapPoint;
            cheminEnChaine = cheminEnChaine.concat(" " + point.cellId);
            i++;
         }
      }
      
      private function nearObstacle(x:int, y:int, map:IDataMapProvider) : int {
         var j:* = 0;
         var distanceMaxToCheck:int = 2;
         var distanceMin:int = 42;
         var i:int = -distanceMaxToCheck;
         while(i < distanceMaxToCheck)
         {
            j = -distanceMaxToCheck;
            while(j < distanceMaxToCheck)
            {
               if(!map.pointMov(x + i,y + j,true,this._previousCellId))
               {
                  distanceMin = Math.min(distanceMin,MapPoint(MapPoint.fromCoords(x,y)).distanceToCell(MapPoint.fromCoords(x + i,y + j)));
               }
               j++;
            }
            i++;
         }
         return distanceMin;
      }
   }
}
