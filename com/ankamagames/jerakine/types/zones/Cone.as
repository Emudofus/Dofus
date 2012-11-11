package com.ankamagames.jerakine.types.zones
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.map.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import flash.utils.*;

    public class Cone extends Object implements IZone
    {
        private var _radius:uint = 0;
        private var _minRadius:uint = 0;
        private var _nDirection:uint = 1;
        private var _dataMapProvider:IDataMapProvider;
        private var _diagonalFree:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Cone));

        public function Cone(param1:uint, param2:uint, param3:IDataMapProvider)
        {
            this.radius = param2;
            this.minRadius = param1;
            this._dataMapProvider = param3;
            return;
        }// end function

        public function get radius() : uint
        {
            return this._radius;
        }// end function

        public function set radius(param1:uint) : void
        {
            this._radius = param1;
            return;
        }// end function

        public function set minRadius(param1:uint) : void
        {
            this._minRadius = param1;
            return;
        }// end function

        public function get minRadius() : uint
        {
            return this._minRadius;
        }// end function

        public function set direction(param1:uint) : void
        {
            this._nDirection = param1;
            return;
        }// end function

        public function get direction() : uint
        {
            return this._nDirection;
        }// end function

        public function get surface() : uint
        {
            return Math.pow((this._radius + 1), 2);
        }// end function

        public function getCells(param1:uint = 0) : Vector.<uint>
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = new Vector.<uint>;
            var _loc_3:* = MapPoint.fromCellId(param1);
            var _loc_4:* = _loc_3.x;
            var _loc_5:* = _loc_3.y;
            if (this._radius == 0)
            {
                if (this._minRadius == 0)
                {
                    _loc_2.push(param1);
                }
                return _loc_2;
            }
            var _loc_8:* = 1;
            var _loc_9:* = 0;
            switch(this._nDirection)
            {
                case DirectionsEnum.UP_LEFT:
                {
                    _loc_6 = _loc_4;
                    while (_loc_6 >= _loc_4 - this._radius)
                    {
                        
                        _loc_7 = -_loc_9;
                        while (_loc_7 <= _loc_9)
                        {
                            
                            if (!this._minRadius || Math.abs(_loc_4 - _loc_6) + Math.abs(_loc_7) >= this._minRadius)
                            {
                                if (MapPoint.isInMap(_loc_6, _loc_7 + _loc_5))
                                {
                                    this.addCell(_loc_6, _loc_7 + _loc_5, _loc_2);
                                }
                            }
                            _loc_7++;
                        }
                        _loc_9 = _loc_9 + _loc_8;
                        _loc_6 = _loc_6 - 1;
                    }
                    break;
                }
                case DirectionsEnum.DOWN_LEFT:
                {
                    _loc_7 = _loc_5;
                    while (_loc_7 >= _loc_5 - this._radius)
                    {
                        
                        _loc_6 = -_loc_9;
                        while (_loc_6 <= _loc_9)
                        {
                            
                            if (!this._minRadius || Math.abs(_loc_6) + Math.abs(_loc_5 - _loc_7) >= this._minRadius)
                            {
                                if (MapPoint.isInMap(_loc_6 + _loc_4, _loc_7))
                                {
                                    this.addCell(_loc_6 + _loc_4, _loc_7, _loc_2);
                                }
                            }
                            _loc_6++;
                        }
                        _loc_9 = _loc_9 + _loc_8;
                        _loc_7 = _loc_7 - 1;
                    }
                    break;
                }
                case DirectionsEnum.DOWN_RIGHT:
                {
                    _loc_6 = _loc_4;
                    while (_loc_6 <= _loc_4 + this._radius)
                    {
                        
                        _loc_7 = -_loc_9;
                        while (_loc_7 <= _loc_9)
                        {
                            
                            if (!this._minRadius || Math.abs(_loc_4 - _loc_6) + Math.abs(_loc_7) >= this._minRadius)
                            {
                                if (MapPoint.isInMap(_loc_6, _loc_7 + _loc_5))
                                {
                                    this.addCell(_loc_6, _loc_7 + _loc_5, _loc_2);
                                }
                            }
                            _loc_7++;
                        }
                        _loc_9 = _loc_9 + _loc_8;
                        _loc_6++;
                    }
                    break;
                }
                case DirectionsEnum.UP_RIGHT:
                {
                    _loc_7 = _loc_5;
                    while (_loc_7 <= _loc_5 + this._radius)
                    {
                        
                        _loc_6 = -_loc_9;
                        while (_loc_6 <= _loc_9)
                        {
                            
                            if (!this._minRadius || Math.abs(_loc_6) + Math.abs(_loc_5 - _loc_7) >= this._minRadius)
                            {
                                if (MapPoint.isInMap(_loc_6 + _loc_4, _loc_7))
                                {
                                    this.addCell(_loc_6 + _loc_4, _loc_7, _loc_2);
                                }
                            }
                            _loc_6++;
                        }
                        _loc_9 = _loc_9 + _loc_8;
                        _loc_7++;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function addCell(param1:int, param2:int, param3:Vector.<uint>) : void
        {
            if (this._dataMapProvider == null || this._dataMapProvider.pointMov(param1, param2))
            {
                param3.push(MapPoint.fromCoords(param1, param2).cellId);
            }
            return;
        }// end function

    }
}
