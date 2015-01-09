package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;
    import __AS3__.vec.*;

    public class MapCoordinates implements IDataCenter 
    {

        public static const MODULE:String = "MapCoordinates";
        private static const UNDEFINED_COORD:int = int.MIN_VALUE;//-2147483648

        public var compressedCoords:uint;
        public var mapIds:Vector.<int>;
        private var _x:int = -2147483648;
        private var _y:int = -2147483648;
        private var _maps:Vector.<MapPosition>;


        public static function getMapCoordinatesByCompressedCoords(compressedCoords:uint):MapCoordinates
        {
            return ((GameData.getObject(MODULE, compressedCoords) as MapCoordinates));
        }

        public static function getMapCoordinatesByCoords(x:int, y:int):MapCoordinates
        {
            return (getMapCoordinatesByCompressedCoords(((getCompressedValue(x) << 16) + getCompressedValue(y))));
        }

        private static function getSignedValue(v:int):int
        {
            var isNegative:Boolean = ((v & 0x8000) > 0);
            var trueValue:int = (v & 32767);
            return (((isNegative) ? (0 - trueValue) : trueValue));
        }

        private static function getCompressedValue(v:int):uint
        {
            return ((((v < 0)) ? (0x8000 | (v & 32767)) : (v & 32767)));
        }


        public function get x():int
        {
            if (this._x == UNDEFINED_COORD)
            {
                this._x = getSignedValue(((this.compressedCoords & 0xFFFF0000) >> 16));
            };
            return (this._x);
        }

        public function get y():int
        {
            if (this._y == UNDEFINED_COORD)
            {
                this._y = getSignedValue((this.compressedCoords & 0xFFFF));
            };
            return (this._y);
        }

        public function get maps():Vector.<MapPosition>
        {
            var i:int;
            if (!(this._maps))
            {
                this._maps = new Vector.<MapPosition>(this.mapIds.length, true);
                i = 0;
                while (i < this.mapIds.length)
                {
                    this._maps[i] = MapPosition.getMapPositionById(this.mapIds[i]);
                    i++;
                };
            };
            return (this._maps);
        }


    }
}//package com.ankamagames.dofus.datacenter.world

