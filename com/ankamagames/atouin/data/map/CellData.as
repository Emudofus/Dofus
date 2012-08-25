package com.ankamagames.atouin.data.map
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class CellData extends Object
    {
        public var speed:int;
        public var mapChangeData:uint;
        public var moveZone:uint;
        private var _losmov:int = 3;
        private var _floor:int;
        private var _map:Map;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CellData));

        public function CellData(param1:Map)
        {
            this._map = param1;
            return;
        }// end function

        public function get map() : Map
        {
            return this._map;
        }// end function

        public function get mov() : Boolean
        {
            return (this._losmov & 1) == 1;
        }// end function

        public function get los() : Boolean
        {
            return (this._losmov & 2) >> 1 == 1;
        }// end function

        public function get nonWalkableDuringFight() : Boolean
        {
            return (this._losmov & 4) >> 2 == 1;
        }// end function

        public function get red() : Boolean
        {
            return (this._losmov & 8) >> 3 == 1;
        }// end function

        public function get blue() : Boolean
        {
            return (this._losmov & 16) >> 4 == 1;
        }// end function

        public function get farmCell() : Boolean
        {
            return (this._losmov & 32) >> 5 == 1;
        }// end function

        public function get visible() : Boolean
        {
            return (this._losmov & 64) >> 6 == 1;
        }// end function

        public function get nonWalkableDuringRP() : Boolean
        {
            return (this._losmov & 128) >> 7 == 1;
        }// end function

        public function get floor() : int
        {
            return this._floor;
        }// end function

        public function fromRaw(param1:IDataInput) : void
        {
            var raw:* = param1;
            try
            {
                this._floor = raw.readByte() * 10;
                if (this._floor == -1280)
                {
                    return;
                }
                this._losmov = raw.readUnsignedByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("  (CellData) LOS+MOV : " + this._losmov);
                }
                this.speed = raw.readByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("  (CellData) Speed : " + this.speed);
                }
                this.mapChangeData = raw.readUnsignedByte();
                if (AtouinConstants.DEBUG_FILES_PARSING)
                {
                    _log.debug("  (CellData) MapChangeData : " + this.mapChangeData);
                }
                if (this._map.mapVersion > 5)
                {
                    this.moveZone = raw.readUnsignedByte();
                    if (AtouinConstants.DEBUG_FILES_PARSING)
                    {
                        _log.debug("  (CellData) moveZone : " + this.moveZone);
                    }
                }
            }
            catch (e)
            {
                throw e;
            }
            return;
        }// end function

    }
}
