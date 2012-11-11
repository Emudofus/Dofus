package com.ankamagames.jerakine.types.zones
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.map.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import flash.utils.*;

    public class Line extends Object implements IZone
    {
        private var _radius:uint = 0;
        private var _minRadius:uint = 0;
        private var _nDirection:uint = 1;
        private var _dataMapProvider:IDataMapProvider;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Line));

        public function Line(param1:uint, param2:IDataMapProvider)
        {
            this.radius = param1;
            this._dataMapProvider = param2;
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

        public function get surface() : uint
        {
            return (this._radius + 1);
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

        public function getCells(param1:uint = 0) : Vector.<uint>
        {
            var _loc_6:* = false;
            var _loc_2:* = new Vector.<uint>;
            var _loc_3:* = MapPoint.fromCellId(param1);
            var _loc_4:* = _loc_3.x;
            var _loc_5:* = _loc_3.y;
            var _loc_7:* = this._minRadius;
            while (_loc_7 <= this._radius)
            {
                
                switch(this._nDirection)
                {
                    case DirectionsEnum.LEFT:
                    {
                        if (MapPoint.isInMap(_loc_4 - _loc_7, _loc_5 - _loc_7))
                        {
                            _loc_6 = this.addCell(_loc_4 - _loc_7, _loc_5 - _loc_7, _loc_2);
                        }
                        break;
                    }
                    case DirectionsEnum.UP:
                    {
                        if (MapPoint.isInMap(_loc_4 - _loc_7, _loc_5 + _loc_7))
                        {
                            _loc_6 = this.addCell(_loc_4 - _loc_7, _loc_5 + _loc_7, _loc_2);
                        }
                        break;
                    }
                    case DirectionsEnum.RIGHT:
                    {
                        if (MapPoint.isInMap(_loc_4 + _loc_7, _loc_5 + _loc_7))
                        {
                            _loc_6 = this.addCell(_loc_4 + _loc_7, _loc_5 + _loc_7, _loc_2);
                        }
                        break;
                    }
                    case DirectionsEnum.DOWN:
                    {
                        if (MapPoint.isInMap(_loc_4 + _loc_7, _loc_5 - _loc_7))
                        {
                            _loc_6 = this.addCell(_loc_4 + _loc_7, _loc_5 - _loc_7, _loc_2);
                        }
                        break;
                    }
                    case DirectionsEnum.UP_LEFT:
                    {
                        if (MapPoint.isInMap(_loc_4 - _loc_7, _loc_5))
                        {
                            _loc_6 = this.addCell(_loc_4 - _loc_7, _loc_5, _loc_2);
                        }
                        break;
                    }
                    case DirectionsEnum.DOWN_LEFT:
                    {
                        if (MapPoint.isInMap(_loc_4, _loc_5 - _loc_7))
                        {
                            _loc_6 = this.addCell(_loc_4, _loc_5 - _loc_7, _loc_2);
                        }
                        break;
                    }
                    case DirectionsEnum.DOWN_RIGHT:
                    {
                        if (MapPoint.isInMap(_loc_4 + _loc_7, _loc_5))
                        {
                            _loc_6 = this.addCell(_loc_4 + _loc_7, _loc_5, _loc_2);
                        }
                        break;
                    }
                    case DirectionsEnum.UP_RIGHT:
                    {
                        if (MapPoint.isInMap(_loc_4, _loc_5 + _loc_7))
                        {
                            _loc_6 = this.addCell(_loc_4, _loc_5 + _loc_7, _loc_2);
                        }
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
                if (!_loc_6)
                {
                    break;
                }
                _loc_7++;
            }
            return _loc_2;
        }// end function

        private function addCell(param1:int, param2:int, param3:Vector.<uint>) : Boolean
        {
            if (this._dataMapProvider == null || this._dataMapProvider.pointMov(param1, param2))
            {
                param3.push(MapPoint.fromCoords(param1, param2).cellId);
                return true;
            }
            return false;
        }// end function

    }
}
