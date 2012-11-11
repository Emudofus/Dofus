package com.ankamagames.jerakine.types.zones
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.map.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;

    public class ZRectangle extends Object implements IZone
    {
        private var _radius:uint = 0;
        private var _radius2:uint;
        private var _minRadius:uint = 2;
        private var _dataMapProvider:IDataMapProvider;
        private var _diagonalFree:Boolean = false;

        public function ZRectangle(param1:uint, param2:uint, param3:uint, param4:IDataMapProvider)
        {
            this.radius = param2;
            this._radius2 = param3 ? (param3) : (param2);
            this.minRadius = param1;
            this._dataMapProvider = param4;
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
            return;
        }// end function

        public function get direction() : uint
        {
            return null;
        }// end function

        public function set diagonalFree(param1:Boolean) : void
        {
            this._diagonalFree = param1;
            return;
        }// end function

        public function get diagonalFree() : Boolean
        {
            return this._diagonalFree;
        }// end function

        public function get surface() : uint
        {
            return Math.pow(this._radius + this._radius2 + 1, 2);
        }// end function

        public function getCells(param1:uint = 0) : Vector.<uint>
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = new Vector.<uint>;
            var _loc_3:* = MapPoint.fromCellId(param1);
            var _loc_4:* = _loc_3.x;
            var _loc_5:* = _loc_3.y;
            if (this._radius == 0 || this._radius2 == 0)
            {
                if (this._minRadius == 0 && !this._diagonalFree)
                {
                    _loc_2.push(param1);
                }
                return _loc_2;
            }
            _loc_6 = _loc_4 - this._radius;
            while (_loc_6 <= _loc_4 + this._radius)
            {
                
                _loc_7 = _loc_5 - this._radius2;
                while (_loc_7 <= _loc_5 + this._radius2)
                {
                    
                    if (!this._minRadius || Math.abs(_loc_4 - _loc_6) + Math.abs(_loc_5 - _loc_7) >= this._minRadius)
                    {
                        if (!this._diagonalFree || Math.abs(_loc_4 - _loc_6) != Math.abs(_loc_5 - _loc_7))
                        {
                            if (MapPoint.isInMap(_loc_6, _loc_7))
                            {
                                this.addCell(_loc_6, _loc_7, _loc_2);
                            }
                        }
                    }
                    _loc_7++;
                }
                _loc_6++;
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
