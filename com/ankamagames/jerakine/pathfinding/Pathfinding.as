package com.ankamagames.jerakine.pathfinding
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.map.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Pathfinding extends Object
    {
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
        private var _findAnotherEndInLine:Boolean;
        private static var _minX:int;
        private static var _maxX:int;
        private static var _minY:int;
        private static var _maxY:int;
        static var _log:Logger = Log.getLogger(getQualifiedClassName(Pathfinding));
        private static var _self:Pathfinding;

        public function Pathfinding()
        {
            return;
        }// end function

        public function processFindPath(param1:IDataMapProvider, param2:MapPoint, param3:MapPoint, param4:Boolean = true, param5:Boolean = true, param6:Function = null, param7:Array = null, param8:Boolean = false) : MovementPath
        {
            this._callBackFunction = param6;
            this._argsFunction = param7;
            this._movPath = new MovementPath();
            this._movPath.start = param2;
            this._movPath.end = param3;
            this._bAllowTroughEntity = param5;
            this._bIsFighting = param8;
            this._bAllowDiagCornering = param4;
            if (param1.height == 0 || param1.width == 0 || param2 == null)
            {
                return this._movPath;
            }
            this.findPathInternal(param1, param2, param3, param4);
            if (this._callBackFunction == null)
            {
                return this._movPath;
            }
            return null;
        }// end function

        private function isOpened(param1:int, param2:int) : Boolean
        {
            return this._mapStatus[param1][param2].opened;
        }// end function

        private function isClosed(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = this._mapStatus[param1][param2];
            if (!_loc_3 || !_loc_3.closed)
            {
                return false;
            }
            return _loc_3.closed;
        }// end function

        private function nearerSquare() : uint
        {
            var _loc_3:Number = NaN;
            var _loc_1:Number = 9999999;
            var _loc_2:uint = 0;
            var _loc_4:int = -1;
            var _loc_5:* = this._openList.length;
            while (++_loc_4 < _loc_5)
            {
                
                _loc_3 = this._mapStatus[this._openList[_loc_4][0]][this._openList[_loc_4][1]].heuristic + this._mapStatus[this._openList[_loc_4][0]][this._openList[_loc_4][1]].movementCost;
                if (_loc_3 <= _loc_1)
                {
                    _loc_1 = _loc_3;
                    _loc_2 = _loc_4;
                }
            }
            return _loc_2;
        }// end function

        private function closeSquare(param1:int, param2:int) : void
        {
            var _loc_3:* = this._openList.length;
            var _loc_4:int = -1;
            while (++_loc_4 < _loc_3)
            {
                
                if (this._openList[_loc_4][0] == param1)
                {
                    if (this._openList[_loc_4][1] == param2)
                    {
                        this._openList.splice(_loc_4, 1);
                        break;
                    }
                }
            }
            var _loc_5:* = this._mapStatus[param1][param2];
            this._mapStatus[param1][param2].opened = false;
            _loc_5.closed = true;
            return;
        }// end function

        private function openSquare(param1:int, param2:int, param3:Array, param4:uint, param5:Number, param6:Boolean) : void
        {
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            if (!param6)
            {
                _loc_8 = this._openList.length;
                _loc_9 = -1;
                while (++_loc_9 < _loc_8)
                {
                    
                    if (this._openList[_loc_9][0] == param1 && this._openList[_loc_9][1] == param2)
                    {
                        param6 = true;
                        break;
                    }
                }
            }
            if (!param6)
            {
                this._openList.push([param1, param2]);
                this._mapStatus[param1][param2] = new CellInfo(param5, null, true, false);
            }
            var _loc_7:* = this._mapStatus[param1][param2];
            this._mapStatus[param1][param2].parent = param3;
            _loc_7.movementCost = param4;
            return;
        }// end function

        private function movementPathFromArray(param1:Array) : void
        {
            var _loc_3:PathElement = null;
            var _loc_2:uint = 0;
            while (_loc_2 < (param1.length - 1))
            {
                
                _loc_3 = new PathElement();
                _loc_3.step.x = param1[_loc_2].x;
                _loc_3.step.y = param1[_loc_2].y;
                _loc_3.orientation = param1[_loc_2].orientationTo(param1[(_loc_2 + 1)]);
                this._movPath.addPoint(_loc_3);
                _loc_2 = _loc_2 + 1;
            }
            this._movPath.compress();
            this._movPath.fill();
            return;
        }// end function

        private function initFindPath() : void
        {
            this._currentTime = 0;
            if (this._callBackFunction == null)
            {
                this._maxTime = 2000000;
                this.pathFrame(null);
            }
            else
            {
                if (!this._enterFrameIsActive)
                {
                    this._enterFrameIsActive = true;
                    EnterFrameDispatcher.addEventListener(this.pathFrame, "pathFrame");
                }
                this._maxTime = 20;
            }
            return;
        }// end function

        private function pathFrame(event:Event) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Number = NaN;
            var _loc_7:int = 0;
            var _loc_8:Boolean = false;
            var _loc_9:Boolean = false;
            var _loc_10:Boolean = false;
            var _loc_11:Boolean = false;
            var _loc_12:MapPoint = null;
            var _loc_13:int = 0;
            var _loc_14:Number = NaN;
            if (this._currentTime == 0)
            {
                this._currentTime = getTimer();
            }
            if (this._openList.length > 0 && !this.isClosed(this._endY, this._endX))
            {
                _loc_2 = this.nearerSquare();
                this._nowY = this._openList[_loc_2][0];
                this._nowX = this._openList[_loc_2][1];
                this.closeSquare(this._nowY, this._nowX);
                _loc_3 = this._nowY - 1;
                while (_loc_3 < this._nowY + 2)
                {
                    
                    _loc_5 = this._nowX - 1;
                    while (_loc_5 < this._nowX + 2)
                    {
                        
                        if (_loc_3 >= _minY && _loc_3 < _maxY && _loc_5 >= _minX && _loc_5 < _maxX && !(_loc_3 == this._nowY && _loc_5 == this._nowX) && (this._allowDiag || _loc_3 == this._nowY || _loc_5 == this._nowX && (this._bAllowDiagCornering || _loc_3 == this._nowY || _loc_5 == this._nowX || (this._map.pointMov(this._nowX, _loc_3, this._bAllowTroughEntity) || this._map.pointMov(_loc_5, this._nowY, this._bAllowTroughEntity)))))
                        {
                            if (!this._map.pointMov(this._nowX, _loc_3, this._bAllowTroughEntity) && (!this._map.pointMov(_loc_5, this._nowY, this._bAllowTroughEntity) && !this._bIsFighting && this._allowDiag))
                            {
                            }
                            else if (this._map.pointMov(_loc_5, _loc_3, this._bAllowTroughEntity))
                            {
                                if (!this.isClosed(_loc_3, _loc_5))
                                {
                                    if (_loc_5 == this._endX && _loc_3 == this._endY)
                                    {
                                        _loc_6 = 1;
                                    }
                                    else
                                    {
                                        _loc_6 = this._map.pointWeight(_loc_5, _loc_3, this._bAllowTroughEntity);
                                    }
                                    _loc_7 = this._mapStatus[this._nowY][this._nowX].movementCost + (_loc_3 == this._nowY || _loc_5 == this._nowX ? (this._nHVCost) : (this._nDCost)) * _loc_6;
                                    if (this._bAllowTroughEntity)
                                    {
                                        _loc_8 = _loc_5 + _loc_3 == this._endX + this._endY;
                                        _loc_9 = _loc_5 + _loc_3 == this._startX + this._startY;
                                        _loc_10 = _loc_5 - _loc_3 == this._endX - this._endY;
                                        _loc_11 = _loc_5 - _loc_3 == this._startX - this._startY;
                                        _loc_12 = MapPoint.fromCoords(_loc_5, _loc_3);
                                        if (!_loc_8 && !_loc_10 || !_loc_9 && !_loc_11)
                                        {
                                            _loc_7 = _loc_7 + _loc_12.distanceToCell(this._endPoint);
                                            _loc_7 = _loc_7 + _loc_12.distanceToCell(this._startPoint);
                                        }
                                        if (_loc_5 == this._endX || _loc_3 == this._endY)
                                        {
                                            _loc_7 = _loc_7 - 3;
                                        }
                                        if (_loc_8 || _loc_10 || _loc_5 + _loc_3 == this._nowX + this._nowY || _loc_5 - _loc_3 == this._nowX - this._nowY)
                                        {
                                            _loc_7 = _loc_7 - 2;
                                        }
                                        if (_loc_5 == this._startX || _loc_3 == this._startY)
                                        {
                                            _loc_7 = _loc_7 - 3;
                                        }
                                        if (_loc_9 || _loc_11)
                                        {
                                            _loc_7 = _loc_7 - 2;
                                        }
                                        _loc_13 = _loc_12.distanceToCell(this._endPoint);
                                        if (_loc_13 < this._distanceToEnd)
                                        {
                                            if (_loc_5 == this._endX || _loc_3 == this._endY)
                                            {
                                                this._endPointAux = _loc_12;
                                                this._endAuxX = _loc_5;
                                                this._endAuxY = _loc_3;
                                                this._distanceToEnd = _loc_13;
                                            }
                                            else if (!this._findAnotherEndInLine && (_loc_5 + _loc_3 == this._endX + this._endY || _loc_5 - _loc_3 == this._endX - this._endY))
                                            {
                                                this._endPointAux = _loc_12;
                                                this._endAuxX = _loc_5;
                                                this._endAuxY = _loc_3;
                                                this._distanceToEnd = _loc_13;
                                            }
                                        }
                                    }
                                    if (this.isOpened(_loc_3, _loc_5))
                                    {
                                        if (_loc_7 < this._mapStatus[_loc_3][_loc_5].movementCost)
                                        {
                                            this.openSquare(_loc_3, _loc_5, [this._nowY, this._nowX], _loc_7, undefined, true);
                                        }
                                    }
                                    else
                                    {
                                        _loc_14 = this._nHeuristicCost * Math.sqrt((this._endY - _loc_3) * (this._endY - _loc_3) + (this._endX - _loc_5) * (this._endX - _loc_5));
                                        this.openSquare(_loc_3, _loc_5, [this._nowY, this._nowX], _loc_7, _loc_14, false);
                                    }
                                }
                            }
                        }
                        _loc_5++;
                    }
                    _loc_3++;
                }
                _loc_4 = getTimer();
                if (_loc_4 - this._currentTime < this._maxTime)
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
            return;
        }// end function

        private function endPathFrame() : void
        {
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:Array = null;
            var _loc_6:uint = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            this._enterFrameIsActive = false;
            EnterFrameDispatcher.removeEventListener(this.pathFrame);
            var _loc_1:* = this.isClosed(this._endY, this._endX);
            if (!_loc_1)
            {
                this._endY = this._endAuxY;
                this._endX = this._endAuxX;
                this._endPoint = this._endPointAux;
                _loc_1 = true;
                this._movPath.replaceEnd(this._endPoint);
            }
            if (_loc_1)
            {
                _loc_2 = new Array();
                this._nowY = this._endY;
                this._nowX = this._endX;
                while (this._nowY != this._startY || this._nowX != this._startX)
                {
                    
                    _loc_2.push(MapPoint.fromCoords(this._nowX, this._nowY));
                    _loc_3 = this._mapStatus[this._nowY][this._nowX].parent[0];
                    _loc_4 = this._mapStatus[this._nowY][this._nowX].parent[1];
                    this._nowY = _loc_3;
                    this._nowX = _loc_4;
                }
                _loc_2.push(this._startPoint);
                if (this._allowDiag)
                {
                    _loc_5 = new Array();
                    _loc_6 = 0;
                    while (_loc_6 < _loc_2.length)
                    {
                        
                        _loc_5.push(_loc_2[_loc_6]);
                        if (_loc_2[_loc_6 + 2] && MapPoint(_loc_2[_loc_6]).distanceToCell(_loc_2[_loc_6 + 2]) == 1)
                        {
                            _loc_6 = _loc_6 + 1;
                        }
                        else if (_loc_2[_loc_6 + 3] && MapPoint(_loc_2[_loc_6]).distanceToCell(_loc_2[_loc_6 + 3]) == 2)
                        {
                            _loc_7 = _loc_2[_loc_6].x;
                            _loc_8 = _loc_2[_loc_6].y;
                            _loc_9 = _loc_2[_loc_6 + 3].x;
                            _loc_10 = _loc_2[_loc_6 + 3].y;
                            _loc_11 = _loc_7 + Math.round((_loc_9 - _loc_7) / 2);
                            _loc_12 = _loc_8 + Math.round((_loc_10 - _loc_8) / 2);
                            if (this._map.pointMov(_loc_11, _loc_12, true) && this._map.pointWeight(_loc_11, _loc_12) < 2 && this._map.pointMov(_loc_11, _loc_12, this._bAllowTroughEntity))
                            {
                                _loc_5.push(MapPoint.fromCoords(_loc_11, _loc_12));
                                ++_loc_6 = ++_loc_6 + 1;
                            }
                        }
                        else if (_loc_2[++_loc_6 + 2] && MapPoint(_loc_2[_loc_6]).distanceToCell(_loc_2[_loc_6 + 2]) == 2)
                        {
                            _loc_7 = _loc_2[_loc_6].x;
                            _loc_8 = _loc_2[_loc_6].y;
                            _loc_9 = _loc_2[_loc_6 + 2].x;
                            _loc_10 = _loc_2[_loc_6 + 2].y;
                            _loc_11 = _loc_2[(_loc_6 + 1)].x;
                            _loc_12 = _loc_2[(_loc_6 + 1)].y;
                            if (_loc_7 + _loc_8 == _loc_9 + _loc_10 && _loc_7 - _loc_8 != _loc_11 - _loc_12)
                            {
                                _loc_6 = _loc_6 + 1;
                            }
                            else if (_loc_7 - _loc_8 == _loc_9 - _loc_10 && _loc_7 - _loc_8 != _loc_11 - _loc_12)
                            {
                                _loc_6 = _loc_6 + 1;
                            }
                            else if (_loc_7 == _loc_9 && _loc_7 != _loc_11 && this._map.pointWeight(_loc_7, _loc_12) < 2 && this._map.pointMov(_loc_7, _loc_12, this._bAllowTroughEntity))
                            {
                                _loc_5.push(MapPoint.fromCoords(_loc_7, _loc_12));
                                _loc_6 = _loc_6 + 1;
                            }
                            else if (_loc_8 == _loc_10 && _loc_8 != _loc_12 && this._map.pointWeight(_loc_11, _loc_8) < 2 && this._map.pointMov(_loc_11, _loc_8, this._bAllowTroughEntity))
                            {
                                _loc_5.push(MapPoint.fromCoords(_loc_11, _loc_8));
                                _loc_6 = _loc_6 + 1;
                            }
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                    _loc_2 = _loc_5;
                }
                if (_loc_2.length == 1)
                {
                    _loc_2 = new Array();
                }
                _loc_2.reverse();
                this.movementPathFromArray(_loc_2);
            }
            if (this._callBackFunction != null)
            {
                if (this._argsFunction)
                {
                    this._callBackFunction(this._movPath, this._argsFunction);
                }
                else
                {
                    this._callBackFunction(this._movPath);
                }
            }
            return;
        }// end function

        private function findPathInternal(param1:IDataMapProvider, param2:MapPoint, param3:MapPoint, param4:Boolean) : void
        {
            var _loc_6:uint = 0;
            this._findAnotherEndInLine = !param1.pointMov(param3.x, param3.y, true);
            this._map = param1;
            this._start = param2;
            this._end = param3;
            this._allowDiag = param4;
            this._endPoint = MapPoint.fromCoords(param3.x, param3.y);
            this._startPoint = MapPoint.fromCoords(param2.x, param2.y);
            this._endX = param3.x;
            this._endY = param3.y;
            this._startX = param2.x;
            this._startY = param2.y;
            this._endPointAux = this._startPoint;
            this._endAuxX = this._startX;
            this._endAuxY = this._startY;
            this._distanceToEnd = this._startPoint.distanceToCell(this._endPoint);
            this._mapStatus = new Array();
            var _loc_5:* = _minY;
            while (_loc_5 < _maxY)
            {
                
                this._mapStatus[_loc_5] = new Array();
                _loc_6 = _minX;
                while (_loc_6 <= _maxX)
                {
                    
                    this._mapStatus[_loc_5][_loc_6] = new CellInfo(0, new Array(), false, false);
                    _loc_6 = _loc_6 + 1;
                }
                _loc_5++;
            }
            this._openList = new Array();
            this.openSquare(this._startY, this._startX, undefined, 0, undefined, false);
            this.initFindPath();
            return;
        }// end function

        private function tracePath(param1:Array) : void
        {
            var _loc_3:MapPoint = null;
            var _loc_2:* = new String("");
            var _loc_4:uint = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_3 = param1[_loc_4] as MapPoint;
                _loc_2 = _loc_2.concat(" " + _loc_3.cellId);
                _loc_4 = _loc_4 + 1;
            }
            trace(_loc_2);
            return;
        }// end function

        private function nearObstacle(param1:int, param2:int, param3:IDataMapProvider) : int
        {
            var _loc_7:int = 0;
            var _loc_4:int = 2;
            var _loc_5:int = 42;
            var _loc_6:* = -_loc_4;
            while (_loc_6 < _loc_4)
            {
                
                _loc_7 = -_loc_4;
                while (_loc_7 < _loc_4)
                {
                    
                    if (!param3.pointMov(param1 + _loc_6, param2 + _loc_7, true))
                    {
                        _loc_5 = Math.min(_loc_5, MapPoint(MapPoint.fromCoords(param1, param2)).distanceToCell(MapPoint.fromCoords(param1 + _loc_6, param2 + _loc_7)));
                    }
                    _loc_7++;
                }
                _loc_6++;
            }
            return _loc_5;
        }// end function

        public static function init(param1:int, param2:int, param3:int, param4:int) : void
        {
            _minX = param1;
            _maxX = param2;
            _minY = param3;
            _maxY = param4;
            return;
        }// end function

        public static function findPath(param1:IDataMapProvider, param2:MapPoint, param3:MapPoint, param4:Boolean = true, param5:Boolean = true, param6:Function = null, param7:Array = null, param8:Boolean = false) : MovementPath
        {
            return new Pathfinding.processFindPath(param1, param2, param3, param4, param5, param6, param7, param8);
        }// end function

    }
}
