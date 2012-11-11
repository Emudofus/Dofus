package com.ankamagames.jerakine.types.zones
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.map.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import flash.utils.*;

    public class Cross extends Object implements IZone
    {
        private var _radius:uint = 0;
        private var _minRadius:uint = 0;
        private var _dataMapProvider:IDataMapProvider;
        private var _direction:uint;
        private var _diagonal:Boolean = false;
        private var _allDirections:Boolean = false;
        public var disabledDirection:Array;
        public var onlyPerpendicular:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Cross));

        public function Cross(param1:uint, param2:uint, param3:IDataMapProvider)
        {
            this.disabledDirection = [];
            this.minRadius = param1;
            this.radius = param2;
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

        public function get surface() : uint
        {
            return this._radius * 4 + 1;
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
            this._direction = param1;
            return;
        }// end function

        public function get direction() : uint
        {
            return this._direction;
        }// end function

        public function set diagonal(param1:Boolean) : void
        {
            this._diagonal = param1;
            return;
        }// end function

        public function get diagonal() : Boolean
        {
            return this._diagonal;
        }// end function

        public function set allDirections(param1:Boolean) : void
        {
            this._allDirections = param1;
            if (this._allDirections)
            {
                this.diagonal = false;
            }
            return;
        }// end function

        public function get allDirections() : Boolean
        {
            return this._allDirections;
        }// end function

        public function getCells(param1:uint = 0) : Vector.<uint>
        {
            var _loc_2:* = new Vector.<uint>;
            if (this._minRadius == 0)
            {
                _loc_2.push(param1);
            }
            if (this.onlyPerpendicular)
            {
                switch(this._direction)
                {
                    case DirectionsEnum.DOWN_RIGHT:
                    case DirectionsEnum.UP_LEFT:
                    {
                        this.disabledDirection = [DirectionsEnum.DOWN_RIGHT, DirectionsEnum.UP_LEFT];
                        break;
                    }
                    case DirectionsEnum.UP_RIGHT:
                    case DirectionsEnum.DOWN_LEFT:
                    {
                        this.disabledDirection = [DirectionsEnum.UP_RIGHT, DirectionsEnum.DOWN_LEFT];
                        break;
                    }
                    case DirectionsEnum.DOWN:
                    case DirectionsEnum.UP:
                    {
                        this.disabledDirection = [DirectionsEnum.DOWN, DirectionsEnum.UP];
                        break;
                    }
                    case DirectionsEnum.RIGHT:
                    case DirectionsEnum.LEFT:
                    {
                        this.disabledDirection = [DirectionsEnum.RIGHT, DirectionsEnum.LEFT];
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            var _loc_3:* = MapPoint.fromCellId(param1);
            var _loc_4:* = _loc_3.x;
            var _loc_5:* = _loc_3.y;
            var _loc_6:* = this._radius;
            while (_loc_6 > 0)
            {
                
                if (_loc_6 >= this._minRadius)
                {
                    if (!this._diagonal)
                    {
                        if (MapPoint.isInMap(_loc_4 + _loc_6, _loc_5) && this.disabledDirection.indexOf(DirectionsEnum.DOWN_RIGHT) == -1)
                        {
                            this.addCell(_loc_4 + _loc_6, _loc_5, _loc_2);
                        }
                        if (MapPoint.isInMap(_loc_4 - _loc_6, _loc_5) && this.disabledDirection.indexOf(DirectionsEnum.UP_LEFT) == -1)
                        {
                            this.addCell(_loc_4 - _loc_6, _loc_5, _loc_2);
                        }
                        if (MapPoint.isInMap(_loc_4, _loc_5 + _loc_6) && this.disabledDirection.indexOf(DirectionsEnum.UP_RIGHT) == -1)
                        {
                            this.addCell(_loc_4, _loc_5 + _loc_6, _loc_2);
                        }
                        if (MapPoint.isInMap(_loc_4, _loc_5 - _loc_6) && this.disabledDirection.indexOf(DirectionsEnum.DOWN_LEFT) == -1)
                        {
                            this.addCell(_loc_4, _loc_5 - _loc_6, _loc_2);
                        }
                    }
                    if (this._diagonal || this._allDirections)
                    {
                        if (MapPoint.isInMap(_loc_4 + _loc_6, _loc_5 - _loc_6) && this.disabledDirection.indexOf(DirectionsEnum.DOWN) == -1)
                        {
                            this.addCell(_loc_4 + _loc_6, _loc_5 - _loc_6, _loc_2);
                        }
                        if (MapPoint.isInMap(_loc_4 - _loc_6, _loc_5 + _loc_6) && this.disabledDirection.indexOf(DirectionsEnum.UP) == -1)
                        {
                            this.addCell(_loc_4 - _loc_6, _loc_5 + _loc_6, _loc_2);
                        }
                        if (MapPoint.isInMap(_loc_4 + _loc_6, _loc_5 + _loc_6) && this.disabledDirection.indexOf(DirectionsEnum.RIGHT) == -1)
                        {
                            this.addCell(_loc_4 + _loc_6, _loc_5 + _loc_6, _loc_2);
                        }
                        if (MapPoint.isInMap(_loc_4 - _loc_6, _loc_5 - _loc_6) && this.disabledDirection.indexOf(DirectionsEnum.LEFT) == -1)
                        {
                            this.addCell(_loc_4 - _loc_6, _loc_5 - _loc_6, _loc_2);
                        }
                    }
                }
                _loc_6 = _loc_6 - 1;
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
