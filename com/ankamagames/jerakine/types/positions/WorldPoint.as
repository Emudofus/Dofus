package com.ankamagames.jerakine.types.positions
{
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.geom.*;

    public class WorldPoint extends Object implements IDataCenter
    {
        private var _mapId:uint;
        private var _worldId:uint;
        private var _x:int;
        private var _y:int;
        private static const WORLD_ID_MAX:uint = 2 << 12;
        private static const MAP_COORDS_MAX:uint = 2 << 8;

        public function WorldPoint()
        {
            return;
        }// end function

        public function get mapId() : uint
        {
            return this._mapId;
        }// end function

        public function set mapId(param1:uint) : void
        {
            this._mapId = param1;
            this.setFromMapId();
            return;
        }// end function

        public function get worldId() : uint
        {
            return this._worldId;
        }// end function

        public function set worldId(param1:uint) : void
        {
            this._worldId = param1;
            this.setFromCoords();
            return;
        }// end function

        public function get x() : int
        {
            return this._x;
        }// end function

        public function set x(param1:int) : void
        {
            this._x = param1;
            this.setFromCoords();
            return;
        }// end function

        public function get y() : int
        {
            return this._y;
        }// end function

        public function set y(param1:int) : void
        {
            this._y = param1;
            this.setFromCoords();
            return;
        }// end function

        public function add(param1:Point) : void
        {
            this._x = this._x + param1.x;
            this._y = this._y + param1.y;
            this.setFromCoords();
            return;
        }// end function

        protected function setFromMapId() : void
        {
            this._worldId = (this._mapId & 1073479680) >> 18;
            this._x = this._mapId >> 9 & 511;
            this._y = this._mapId & 511;
            if ((this._x & 256) == 256)
            {
                this._x = -(this._x & 255);
            }
            if ((this._y & 256) == 256)
            {
                this._y = -(this._y & 255);
            }
            return;
        }// end function

        protected function setFromCoords() : void
        {
            if (this._x > MAP_COORDS_MAX || this._y > MAP_COORDS_MAX || this._worldId > WORLD_ID_MAX)
            {
                throw new JerakineError("Coordinates or world identifier out of range.");
            }
            var _loc_1:* = this._worldId & 4095;
            var _loc_2:* = Math.abs(this._x) & 255;
            if (this._x < 0)
            {
                _loc_2 = _loc_2 | 256;
            }
            var _loc_3:* = Math.abs(this._y) & 255;
            if (this._y < 0)
            {
                _loc_3 = _loc_3 | 256;
            }
            this._mapId = _loc_1 << 18 | (_loc_2 << 9 | _loc_3);
            return;
        }// end function

        public static function fromMapId(param1:uint) : WorldPoint
        {
            var _loc_2:* = new WorldPoint;
            _loc_2._mapId = param1;
            _loc_2.setFromMapId();
            return _loc_2;
        }// end function

        public static function fromCoords(param1:uint, param2:int, param3:int) : WorldPoint
        {
            var _loc_4:* = new WorldPoint;
            new WorldPoint._worldId = param1;
            _loc_4._x = param2;
            _loc_4._y = param3;
            _loc_4.setFromCoords();
            return _loc_4;
        }// end function

    }
}
