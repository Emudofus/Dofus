package com.ankamagames.dofus.datacenter.world
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class MapCoordinates extends Object implements IDataCenter
    {
        public var compressedCoords:uint;
        public var mapIds:Vector.<int>;
        private var _x:int = -2.14748e+009;
        private var _y:int = -2.14748e+009;
        private var _maps:Vector.<MapPosition>;
        private static const MODULE:String = "MapCoordinates";
        private static const UNDEFINED_COORD:int = -2.14748e+009;

        public function MapCoordinates()
        {
            return;
        }// end function

        public function get x() : int
        {
            if (this._x == UNDEFINED_COORD)
            {
                this._x = getSignedValue((this.compressedCoords & 4294901760) >> 16);
            }
            return this._x;
        }// end function

        public function get y() : int
        {
            if (this._y == UNDEFINED_COORD)
            {
                this._y = getSignedValue(this.compressedCoords & 65535);
            }
            return this._y;
        }// end function

        public function get maps() : Vector.<MapPosition>
        {
            var _loc_1:* = 0;
            if (!this._maps)
            {
                this._maps = new Vector.<MapPosition>(this.mapIds.length, true);
                _loc_1 = 0;
                while (_loc_1 < this.mapIds.length)
                {
                    
                    this._maps[_loc_1] = MapPosition.getMapPositionById(this.mapIds[_loc_1]);
                    _loc_1++;
                }
            }
            return this._maps;
        }// end function

        public static function getMapCoordinatesByCompressedCoords(param1:uint) : MapCoordinates
        {
            return GameData.getObject(MODULE, param1) as MapCoordinates;
        }// end function

        public static function getMapCoordinatesByCoords(param1:int, param2:int) : MapCoordinates
        {
            return getMapCoordinatesByCompressedCoords((getCompressedValue(param1) << 16) + getCompressedValue(param2));
        }// end function

        private static function getSignedValue(param1:int) : int
        {
            var _loc_2:* = (param1 & 32768) > 0;
            var _loc_3:* = param1 & 32767;
            return _loc_2 ? (-_loc_3) : (_loc_3);
        }// end function

        private static function getCompressedValue(param1:int) : uint
        {
            return param1 < 0 ? (32768 | param1 & 32767) : (param1 & 32767);
        }// end function

    }
}
