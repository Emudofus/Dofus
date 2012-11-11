package com.ankamagames.jerakine.types.positions
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.map.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.geom.*;

    public class MapPoint extends Object
    {
        private var _nCellId:uint;
        private var _nX:int;
        private var _nY:int;
        private static const VECTOR_RIGHT:Point = new Point(1, 1);
        private static const VECTOR_DOWN_RIGHT:Point = new Point(1, 0);
        private static const VECTOR_DOWN:Point = new Point(1, -1);
        private static const VECTOR_DOWN_LEFT:Point = new Point(0, -1);
        private static const VECTOR_LEFT:Point = new Point(-1, -1);
        private static const VECTOR_UP_LEFT:Point = new Point(-1, 0);
        private static const VECTOR_UP:Point = new Point(-1, 1);
        private static const VECTOR_UP_RIGHT:Point = new Point(0, 1);
        public static const MAP_WIDTH:uint = 14;
        public static const MAP_HEIGHT:uint = 20;
        private static var _bInit:Boolean = false;
        public static var CELLPOS:Array = new Array();

        public function MapPoint()
        {
            return;
        }// end function

        public function get cellId() : uint
        {
            return this._nCellId;
        }// end function

        public function set cellId(param1:uint) : void
        {
            this._nCellId = param1;
            this.setFromCellId();
            return;
        }// end function

        public function get x() : int
        {
            return this._nX;
        }// end function

        public function set x(param1:int) : void
        {
            this._nX = param1;
            this.setFromCoords();
            return;
        }// end function

        public function get y() : int
        {
            return this._nY;
        }// end function

        public function set y(param1:int) : void
        {
            this._nY = param1;
            this.setFromCoords();
            return;
        }// end function

        public function distanceTo(param1:MapPoint) : uint
        {
            return Math.sqrt(Math.pow(param1.x - this.x, 2) + Math.pow(param1.y - this.y, 2));
        }// end function

        public function distanceToCell(param1:MapPoint) : int
        {
            return Math.abs(this.x - param1.x) + Math.abs(this.y - param1.y);
        }// end function

        public function orientationTo(param1:MapPoint) : uint
        {
            var _loc_3:* = 0;
            if (this.x == param1.x && this.y == param1.y)
            {
                return 1;
            }
            var _loc_2:* = new Point();
            _loc_2.x = param1.x > this.x ? (1) : (param1.x < this.x ? (-1) : (0));
            _loc_2.y = param1.y > this.y ? (1) : (param1.y < this.y ? (-1) : (0));
            if (_loc_2.x == VECTOR_RIGHT.x && _loc_2.y == VECTOR_RIGHT.y)
            {
                _loc_3 = DirectionsEnum.RIGHT;
            }
            else if (_loc_2.x == VECTOR_DOWN_RIGHT.x && _loc_2.y == VECTOR_DOWN_RIGHT.y)
            {
                _loc_3 = DirectionsEnum.DOWN_RIGHT;
            }
            else if (_loc_2.x == VECTOR_DOWN.x && _loc_2.y == VECTOR_DOWN.y)
            {
                _loc_3 = DirectionsEnum.DOWN;
            }
            else if (_loc_2.x == VECTOR_DOWN_LEFT.x && _loc_2.y == VECTOR_DOWN_LEFT.y)
            {
                _loc_3 = DirectionsEnum.DOWN_LEFT;
            }
            else if (_loc_2.x == VECTOR_LEFT.x && _loc_2.y == VECTOR_LEFT.y)
            {
                _loc_3 = DirectionsEnum.LEFT;
            }
            else if (_loc_2.x == VECTOR_UP_LEFT.x && _loc_2.y == VECTOR_UP_LEFT.y)
            {
                _loc_3 = DirectionsEnum.UP_LEFT;
            }
            else if (_loc_2.x == VECTOR_UP.x && _loc_2.y == VECTOR_UP.y)
            {
                _loc_3 = DirectionsEnum.UP;
            }
            else if (_loc_2.x == VECTOR_UP_RIGHT.x && _loc_2.y == VECTOR_UP_RIGHT.y)
            {
                _loc_3 = DirectionsEnum.UP_RIGHT;
            }
            return _loc_3;
        }// end function

        public function advancedOrientationTo(param1:MapPoint, param2:Boolean = true) : uint
        {
            var _loc_3:* = param1.x - this.x;
            var _loc_4:* = this.y - param1.y;
            var _loc_5:* = Math.acos(_loc_3 / Math.sqrt(Math.pow(_loc_3, 2) + Math.pow(_loc_4, 2))) * 180 / Math.PI * (param1.y > this.y ? (-1) : (1));
            if (param2)
            {
                _loc_5 = Math.round(_loc_5 / 90) * 2 + 1;
            }
            else
            {
                _loc_5 = Math.round(_loc_5 / 45) + 1;
            }
            if (_loc_5 < 0)
            {
                _loc_5 = _loc_5 + 8;
            }
            return _loc_5;
        }// end function

        public function getNearestFreeCell(param1:IDataMapProvider, param2:Boolean = true) : MapPoint
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            while (_loc_4 < 8)
            {
                
                _loc_3 = this.getNearestFreeCellInDirection(_loc_4, param1, false, param2);
                if (_loc_3)
                {
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            return _loc_3;
        }// end function

        public function getNearestCellInDirection(param1:uint) : MapPoint
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case 0:
                {
                    _loc_2 = MapPoint.fromCoords((this._nX + 1), (this._nY + 1));
                    break;
                }
                case 1:
                {
                    _loc_2 = MapPoint.fromCoords((this._nX + 1), this._nY);
                    break;
                }
                case 2:
                {
                    _loc_2 = MapPoint.fromCoords((this._nX + 1), (this._nY - 1));
                    break;
                }
                case 3:
                {
                    _loc_2 = MapPoint.fromCoords(this._nX, (this._nY - 1));
                    break;
                }
                case 4:
                {
                    _loc_2 = MapPoint.fromCoords((this._nX - 1), (this._nY - 1));
                    break;
                }
                case 5:
                {
                    _loc_2 = MapPoint.fromCoords((this._nX - 1), this._nY);
                    break;
                }
                case 6:
                {
                    _loc_2 = MapPoint.fromCoords((this._nX - 1), (this._nY + 1));
                    break;
                }
                case 7:
                {
                    _loc_2 = MapPoint.fromCoords(this._nX, (this._nY + 1));
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (MapPoint.isInMap(_loc_2._nX, _loc_2._nY))
            {
                return _loc_2;
            }
            return null;
        }// end function

        public function getNearestFreeCellInDirection(param1:uint, param2:IDataMapProvider, param3:Boolean = true, param4:Boolean = true, param5:Array = null) : MapPoint
        {
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_12:* = 0;
            var _loc_6:* = null;
            if (param5 == null)
            {
                param5 = new Array();
            }
            var _loc_7:* = new Vector.<MapPoint>(8, true);
            var _loc_8:* = new Vector.<int>(8, true);
            _loc_9 = 0;
            while (_loc_9 < 8)
            {
                
                _loc_6 = this.getNearestCellInDirection(_loc_9);
                if (_loc_6 != null && param5.indexOf(_loc_6.cellId) == -1)
                {
                    _loc_10 = param2.getCellSpeed(_loc_6.cellId);
                    if (!param2.pointMov(_loc_6._nX, _loc_6._nY, param4, this.cellId))
                    {
                        _loc_10 = -100;
                    }
                    _loc_8[_loc_9] = getOrientationsDistance(_loc_9, param1) + (_loc_10 >= 0 ? (5 - _loc_10) : (11 + Math.abs(_loc_10)));
                }
                else
                {
                    _loc_8[_loc_9] = 1000;
                }
                _loc_7[_loc_9] = _loc_6;
                _loc_9++;
            }
            _loc_6 = null;
            var _loc_11:* = 0;
            var _loc_13:* = _loc_8[0];
            _loc_9 = 1;
            while (_loc_9 < 8)
            {
                
                _loc_12 = _loc_8[_loc_9];
                if (_loc_12 < _loc_13 && _loc_7[_loc_9] != null)
                {
                    _loc_13 = _loc_12;
                    _loc_11 = _loc_9;
                }
                _loc_9++;
            }
            _loc_6 = _loc_7[_loc_11];
            if (_loc_6 == null && param3 && param2.pointMov(this._nX, this._nY, param4, this.cellId))
            {
                return this;
            }
            return _loc_6;
        }// end function

        public function equals(param1:MapPoint) : Boolean
        {
            return param1.cellId == this.cellId;
        }// end function

        public function toString() : String
        {
            return "[MapPoint(x:" + this._nX + ", y:" + this._nY + ", id:" + this._nCellId + ")]";
        }// end function

        private function setFromCoords() : void
        {
            if (!_bInit)
            {
                init();
            }
            this._nCellId = (this._nX - this._nY) * MAP_WIDTH + this._nY + (this._nX - this._nY) / 2;
            return;
        }// end function

        private function setFromCellId() : void
        {
            if (!_bInit)
            {
                init();
            }
            if (!CELLPOS[this._nCellId])
            {
                throw new JerakineError("Cell identifier out of bounds (" + this._nCellId + ").");
            }
            var _loc_1:* = CELLPOS[this._nCellId];
            this._nX = _loc_1.x;
            this._nY = _loc_1.y;
            return;
        }// end function

        public static function fromCellId(param1:uint) : MapPoint
        {
            var _loc_2:* = new MapPoint;
            _loc_2._nCellId = param1;
            _loc_2.setFromCellId();
            return _loc_2;
        }// end function

        public static function fromCoords(param1:int, param2:int) : MapPoint
        {
            var _loc_3:* = new MapPoint;
            _loc_3._nX = param1;
            _loc_3._nY = param2;
            _loc_3.setFromCoords();
            return _loc_3;
        }// end function

        public static function getOrientationsDistance(param1:int, param2:int) : int
        {
            return Math.min(Math.abs(param2 - param1), Math.abs(8 - param2 + param1));
        }// end function

        public static function isInMap(param1:int, param2:int) : Boolean
        {
            return param1 + param2 >= 0 && param1 - param2 >= 0 && param1 - param2 < MAP_HEIGHT * 2 && param1 + param2 < MAP_WIDTH * 2;
        }// end function

        private static function init() : void
        {
            var _loc_4:* = 0;
            _bInit = true;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < MAP_HEIGHT)
            {
                
                _loc_4 = 0;
                while (_loc_4 < MAP_WIDTH)
                {
                    
                    CELLPOS[_loc_3] = new Point(_loc_1 + _loc_4, _loc_2 + _loc_4);
                    _loc_3++;
                    _loc_4++;
                }
                _loc_1++;
                _loc_4 = 0;
                while (_loc_4 < MAP_WIDTH)
                {
                    
                    CELLPOS[_loc_3] = new Point(_loc_1 + _loc_4, _loc_2 + _loc_4);
                    _loc_3++;
                    _loc_4++;
                }
                _loc_2 = _loc_2 - 1;
                _loc_5++;
            }
            return;
        }// end function

    }
}
