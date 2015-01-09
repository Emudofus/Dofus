package com.ankamagames.jerakine.types.positions
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import flash.geom.Point;
    import com.ankamagames.jerakine.utils.errors.JerakineError;

    public class WorldPoint implements IDataCenter 
    {

        private static const WORLD_ID_MAX:uint = (2 << 12);
        private static const MAP_COORDS_MAX:uint = (2 << 8);

        private var _mapId:uint;
        private var _worldId:uint;
        private var _x:int;
        private var _y:int;


        public static function fromMapId(mapId:uint):WorldPoint
        {
            var wp:WorldPoint = new (WorldPoint)();
            wp._mapId = mapId;
            wp.setFromMapId();
            return (wp);
        }

        public static function fromCoords(worldId:uint, x:int, y:int):WorldPoint
        {
            var wp:WorldPoint = new (WorldPoint)();
            wp._worldId = worldId;
            wp._x = x;
            wp._y = y;
            wp.setFromCoords();
            return (wp);
        }


        public function get mapId():uint
        {
            return (this._mapId);
        }

        public function set mapId(mapId:uint):void
        {
            this._mapId = mapId;
            this.setFromMapId();
        }

        public function get worldId():uint
        {
            return (this._worldId);
        }

        public function set worldId(worldId:uint):void
        {
            this._worldId = worldId;
            this.setFromCoords();
        }

        public function get x():int
        {
            return (this._x);
        }

        public function set x(x:int):void
        {
            this._x = x;
            this.setFromCoords();
        }

        public function get y():int
        {
            return (this._y);
        }

        public function set y(y:int):void
        {
            this._y = y;
            this.setFromCoords();
        }

        public function add(offset:Point):void
        {
            this._x = (this._x + offset.x);
            this._y = (this._y + offset.y);
            this.setFromCoords();
        }

        protected function setFromMapId():void
        {
            this._worldId = ((this._mapId & 0x3FFC0000) >> 18);
            this._x = ((this._mapId >> 9) & 511);
            this._y = (this._mapId & 511);
            if ((this._x & 0x0100) == 0x0100)
            {
                this._x = -((this._x & 0xFF));
            };
            if ((this._y & 0x0100) == 0x0100)
            {
                this._y = -((this._y & 0xFF));
            };
        }

        protected function setFromCoords():void
        {
            if ((((((this._x > MAP_COORDS_MAX)) || ((this._y > MAP_COORDS_MAX)))) || ((this._worldId > WORLD_ID_MAX))))
            {
                throw (new JerakineError("Coordinates or world identifier out of range."));
            };
            var worldValue:uint = (this._worldId & 4095);
            var xValue:uint = (Math.abs(this._x) & 0xFF);
            if (this._x < 0)
            {
                xValue = (xValue | 0x0100);
            };
            var yValue:uint = (Math.abs(this._y) & 0xFF);
            if (this._y < 0)
            {
                yValue = (yValue | 0x0100);
            };
            this._mapId = ((worldValue << 18) | ((xValue << 9) | yValue));
        }


    }
}//package com.ankamagames.jerakine.types.positions

